// import 'dart:convert';
// import 'dart:developer';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// class MqttService {
//   late MqttServerClient client;
//   final String username;
//   final String password;
//   final String productId;

//   MqttService({
//     required this.username,
//     required this.password,
//     required this.productId,
//   }) {
//     _connect();
//   }

//   Future<void> _connect() async {
//     client = MqttServerClient.withPort('mqtt.onwords.in', 'Client Test', 1883);
//     client.logging(on: false);
//     client.keepAlivePeriod = 60;

//     final connectMessage = MqttConnectMessage()
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce)
//         .withWillRetain();
//     client.connectionMessage = connectMessage;

//     try {
//       log('Attempting to connect...');
//       await client.connect(username, password);
//       log('Connected');
//     } catch (e) {
//       log("Error connecting: $e");
//       client.disconnect();
//       log('Retrying connection in 5 seconds...');
//       Future.delayed(const Duration(seconds: 5), _connect);
//     }
//   }

//   void publishStatus({
//     required String deviceKey,
//     required int status,
//     int? speed,
//     int? speed_1,
//   }) {
//     const String productId = '4l2ftc006';
//     const topic = 'onwords/$productId/status';
//     final builder = MqttClientPayloadBuilder();

//     Map<String, dynamic> payloadMap = {
//       deviceKey: status,
//     };

//     if (speed != null) {
//       payloadMap['speed'] = speed;
//     }
//     if (speed_1 != null) {
//       payloadMap['speed_1'] = speed_1;
//     }

//     final payloadJson = jsonEncode(payloadMap);
//     log('Payload Map: $payloadMap');
//     log('JSON Payload: $payloadJson');

//     builder.addString(payloadJson);
//     client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//   }

//   Stream<Map<String, dynamic>> subscribeToStatusUpdates() {
//     client.subscribe('onwords/$productId/currentStatus', MqttQos.atMostOnce);
//     return client.updates!.map((List<MqttReceivedMessage<MqttMessage>> c) {
//       final MqttPublishMessage receivedMessage =
//           c[0].payload as MqttPublishMessage;
//       final String payload = MqttPublishPayload.bytesToStringAsString(
//           receivedMessage.payload.message);
//       log("Received message: $payload from topic: ${c[0].topic}");
//       return jsonDecode(payload);
//     });
//   }
// }
