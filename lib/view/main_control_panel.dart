import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:home_light/services/const.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MainControlPanel extends StatefulWidget {
  const MainControlPanel({super.key});

  @override
  State<MainControlPanel> createState() => _MainControlPanelState();
}

class _MainControlPanelState extends State<MainControlPanel> {
  Map<String, dynamic> updatedPayloadMap = {};
  late MqttServerClient client;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    client = MqttServerClient.withPort('mqtt.onwords.in', 'Client Test', 1883);
    client.logging(on: false);
    client.keepAlivePeriod = 60;
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;

    final connectMessage = MqttConnectMessage()
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .withWillRetain();
    client.connectionMessage = connectMessage;

    try {
      log('Attempting to connect...');
      await client.connect(username, password);
    } catch (e) {
      log("Error connecting: $e");
      client.disconnect();
      log('Retrying connection in 5 seconds...');

      // Retry connection after a delay
      Future.delayed(const Duration(seconds: 5), _connect);
    }
  }

  void _onConnected() {
    log('Connected');
    setState(() {
      _subscribeToTopics();
    });
  }

  void _onDisconnected() {
    log('Disconnected');
  }

  void _onSubscribed(String topic) {
    log('Subscribed to $topic');
  }

  void _subscribeToTopics() {
    client.subscribe('onwords/$productId/currentStatus', MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
      final MqttPublishMessage receivedMessage =
          c![0].payload as MqttPublishMessage;
      final String payload = MqttPublishPayload.bytesToStringAsString(
          receivedMessage.payload.message);
      log("Received message: $payload from topic: ${c[0].topic}");

      setState(() {
        updatedPayloadMap = jsonDecode(payload);
        log('Updated Payload: $updatedPayloadMap');
      });
    });
  }

  void publishStatuss({
    required String deviceKey,
    required int status,
    int? speed,
    int? speed_1,
  }) {
    const topic = 'onwords/$productId/status';
    final builder = MqttClientPayloadBuilder();

    Map<String, dynamic> payloadMap = {
      deviceKey: status,
    };

    if (speed != null) {
      payloadMap['speed'] = speed;
    }
    if (speed_1 != null) {
      payloadMap['speed_1'] = speed_1;
    }

    final payloadJson = jsonEncode(payloadMap);
    log('Payload Map: $payloadMap');
    log('JSON Payload: $payloadJson');

    builder.addString(payloadJson);
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  @override
  Widget build(BuildContext context) {
    List<String> deviceKeys = updatedPayloadMap.keys.toList();

    if (deviceKeys.length > 8) deviceKeys.removeAt(7);
    if (deviceKeys.length > 6) deviceKeys.removeAt(5);
    if (deviceKeys.length > 6) deviceKeys.removeAt(6);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Controller"),
      ),
      body: updatedPayloadMap.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 4 / 3,
              ),
              itemCount: deviceKeys.length,
              itemBuilder: (context, index) {
                String deviceKey = deviceKeys[index];
                dynamic deviceValue = updatedPayloadMap[deviceKey];

                if (deviceKey == 'device5' || deviceKey == 'device6') {
                  String speedKey =
                      (deviceKey == 'device5') ? 'speed' : 'speed_1';

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          int newValue = (deviceValue == 1) ? 0 : 1;
                          setState(() {
                            updatedPayloadMap[deviceKey] = newValue;
                          });

                          publishStatuss(
                            deviceKey: deviceKey,
                            status: newValue,
                            speed: (deviceKey == 'device5')
                                ? updatedPayloadMap['speed']
                                : null,
                            speed_1: (deviceKey == 'device6')
                                ? updatedPayloadMap['speed_1']
                                : null,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: deviceValue == 1
                                ? Colors.green
                                : Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                deviceKey,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                (deviceValue == 1) ? 'ON' : 'OFF',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: (deviceValue == 1)
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                              if (deviceValue == 1 && speedKey.isNotEmpty)
                                Slider(
                                  onChanged: (value) {
                                    setState(() {
                                      updatedPayloadMap[speedKey] =
                                          value.toInt();
                                    });

                                    publishStatuss(
                                      deviceKey: deviceKey,
                                      status: updatedPayloadMap[deviceKey],
                                      speed: (deviceKey == 'device5')
                                          ? value.toInt()
                                          : null,
                                      speed_1: (deviceKey == 'device6')
                                          ? value.toInt()
                                          : null,
                                    );
                                  },
                                  value:
                                      updatedPayloadMap[speedKey]?.toDouble() ??
                                          0.0,
                                  min: 0,
                                  max: 5,
                                  label:
                                      '$speedKey: ${updatedPayloadMap[speedKey]}',
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return GestureDetector(
                  onTap: () {
                    int newValue = (deviceValue == 1) ? 0 : 1;
                    setState(() {
                      updatedPayloadMap[deviceKey] = newValue;
                    });
                    publishStatuss(
                      deviceKey: deviceKey,
                      status: newValue,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: deviceValue == 1
                          ? Colors.green
                          : Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          deviceKey,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (deviceValue == 1) ? 'ON' : 'OFF',
                          style: TextStyle(
                            fontSize: 16,
                            color: (deviceValue == 1)
                                ? Colors.black
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
