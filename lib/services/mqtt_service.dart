

// // class Mqtt {
// //   MqttServerClient? client;


// //   Future<void> connectToMqtt() async {
// //     final client = MqttServerClient(brokerId, clientId);
// //     client.port = port;
// //     client.logging(on: true);
// //     client.keepAlivePeriod = 20;
// //     client.onConnected = onConnected;
// //     client.onDisconnected = onDisconnected;
// //     client.onSubscribed = onSubscribed;
// //     client.onUnsubscribed = onUnsubscribed;
// //     client.onSubscribeFail = onSubscribeFail;
// //     client.pongCallback = pong;

// //     final connMess = MqttConnectMessage()
// //         .withClientIdentifier(clientId)
// //         .authenticateAs(username, password)
// //         // ignore: deprecated_member_use
// //         .keepAliveFor(20)
// //         .withWillTopic('willtopic')
// //         .withWillMessage('Will message')
// //         .startClean()
// //         .withWillQos(MqttQos.atLeastOnce);

// //     client.connectionMessage = connMess;

// //     try {
// //       log('Connecting to the MQTT server...');
// //       await client.connect();
// //     } catch (e) {
// //       log('Connection failed: $e');
// //       client.disconnect();
// //     }

// //     if (client.connectionStatus!.state == MqttConnectionState.connected) {
// //       log('MQTT client connected');
// //     } else {
// //       log('MQTT client connection failed - disconnecting');
// //       client.disconnect();
// //     }
// //   }

// //   void onConnected() {
// //     log('Connected to the MQTT server');
// //   }

// //   void onDisconnected() {
// //     log('Disconnected from the MQTT server');
// //   }

// //   void onSubscribed(String topic) {
// //     log('Subscribed to topic: $topic');
// //   }

// //   void onUnsubscribed(String? topic) {
// //     log('Unsubscribed from topic: $topic');
// //   }

// //   void onSubscribeFail(String topic) {
// //     log('Failed to subscribe to topic: $topic');
// //   }

// //   void pong() {
// //     log('Ping response received');
// //   }

// //   void publish() {
// //     client?.subscribe('topic', MqttQos.atLeastOnce);
// //     const String pubTopic = 'topic';
// //     final builder = MqttClientPayloadBuilder();
// //     builder.addString('Haaaa');
// //     client?.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
// //   }
// // }

// // class MqttService {
// //   final String brokerId = 'mqtt.onwords.in';
// //   final int port = 1883;
// //   final String username = 'Appteam';
// //   final String password = 'Appteam@321';
// //   final String clientId = '4l2ftc006';

// //   late MqttServerClient client;
// //   bool isConnected = false;

// //   Future<void> connect() async {
// //     client = MqttServerClient(brokerId, clientId);
// //     client.port = port;
// //     client.logging(on: false);
// //     client.keepAlivePeriod = 20;

// //     final connMess = MqttConnectMessage()
// //         .withClientIdentifier(clientId)
// //         .authenticateAs(username, password)
// //         // ignore: deprecated_member_use
// //         .keepAliveFor(20)
// //         .startClean()
// //         .withWillQos(MqttQos.atLeastOnce);
// //         print(connMess);
// //     client.connectionMessage = connMess;

// //     try {
// //       await client.connect();
// //     } catch (e) {
// //       client.disconnect();
// //       throw Exception('Failed to connect: $e');
// //     }

// //     if (client.connectionStatus!.state == MqttConnectionState.connected) {
// //       print(client.connectionStatus!.state);
// //       isConnected = true;
// //       print('Connected');
// //     } else {
// //       client.disconnect();
// //       print(' Not Connected');
// //     }
// //   }

// //   void publish(String topic, String message) {
// //     final builder = MqttClientPayloadBuilder();
// //     // print(message);
// //     // print(topic );
// //     builder.addString(message);
// //     client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
// //   }

// //   void disconnect() {
// //     client.disconnect();
// //     isConnected = false;
// //   }
// // }
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// const String brokerId = 'mqtt.onwords.in';
// const int port = 1883;
// const String username = 'Appteam';
// const String password = 'Appteam@321';
// const String deviceId = '4l2ftc006';

// class MqttService {
//   late MqttServerClient client;
//   bool isConnected = false;

//   Future<void> connect() async {
//     client = MqttServerClient.withPort(brokerId, deviceId, port);
//     client.logging(on: false);
//     client.keepAlivePeriod = 20;

//     final connMess = MqttConnectMessage()
//         .withClientIdentifier(deviceId)
//         .authenticateAs(username, password)
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce);
//     client.connectionMessage = connMess;

//     try {
//       await client.connect();
//     } catch (e) {
//       client.disconnect();
//       throw Exception('Failed to connect: $e');
//     }

//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       isConnected = true;
//       print('Connected to MQTT broker');
//     } else {
//       client.disconnect();
//       print('Failed to connect to MQTT broker');
//     }
//   }

//   void publish(String topic, String message) {
//     if (isConnected) {
//       final builder = MqttClientPayloadBuilder();
//       builder.addString(message);
//       client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
//       print('Published message: $message to topic: $topic');
//     } else {
//       print('Cannot publish. Client is not connected.');
//     }
//   }

//   void disconnect() {
//     if (isConnected) {
//       client.disconnect();
//       isConnected = false;
//       print('Disconnected from MQTT broker');
//     }
//   }
// }
// import 'dart:convert';
// import 'dart:developer';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// class MqttService {
//   late MqttServerClient client;
//   final String broker = 'mqtt.onwords.in';
//   final int port = 1883;
//   final String clientId = 'Client Test';
//   final String username = 'Appteam';
//   final String password = 'Appteam@321';

//   Set<String> subscribedTopics = <String>{};
  
//   final Function(String, String) onMessageReceived;

//   MqttService(this.onMessageReceived);

//   Future<bool> connect() async {
//     bool status = false;
//     log("called local mqtt connection");

//     client = MqttServerClient.withPort(broker, clientId, port);

//     client.logging(on: false);
//     client.keepAlivePeriod = 60;
//     client.onConnected = _onConnected;
//     client.onDisconnected = _onDisconnected;
//     client.onSubscribed = _onSubscribed;
//     client.onUnsubscribed = _onUnsubscribed;

//     final connectMessage = MqttConnectMessage()
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce)
//         .withWillRetain();
//     client.connectionMessage = connectMessage;

//     try {
//       await client.connect(username, password);
//       if (isConnected) status = true;

//     } catch (e) {
//       log("Error in mqtt connection $e");
//       client.disconnect();
//     }

//     return status;
//   }

//   bool get isConnected {
//     return client.connectionStatus!.state == MqttConnectionState.connected;
//   }

//   void disconnect() {
//     client.disconnect();
//   }

//   void subscribe(String topic) {
//     if (isConnected && !subscribedTopics.contains(topic)) {
//       print(client.connectionStatus);
//       client.subscribe(topic, MqttQos.atLeastOnce);
//     }
//   }

//   void unSubscribe(String topic) {
//     if (subscribedTopics.contains(topic)) {
//       client.unsubscribe(topic);
//       subscribedTopics.remove(topic);
//     }
//   }

//   void _onConnected() {
//     log('MQTTClient::Connected');
//   }

//   void _onDisconnected() {
//     log('MQTTClient::Disconnected');
//     subscribedTopics.clear();
//   }

//   void _onSubscribed(String topic) {
//     subscribedTopics.add(topic);
//     log('MQTTClient::Subscribed to topic: $topic');
//   }

//   void _onUnsubscribed(String? topic) {
//     log('MQTTClient::Unsubscribed topic: $topic');
//   }

//   void listenToMessages() {
//     client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
//       final MqttPublishMessage receivedMessage =
//           c![0].payload as MqttPublishMessage;
//           print(receivedMessage);
//       final String payload = MqttPublishPayload.bytesToStringAsString(
//           receivedMessage.payload.message);
//       log("Received message: $payload from topic ${c[0].topic}");

//       onMessageReceived(c[0].topic, payload);
//     });
//   }

//   void publish(String topic, Map<String, dynamic> payloadMap) {
//     final builder = MqttClientPayloadBuilder();
//     final payloadJson = jsonEncode(payloadMap);
//     builder.addString(payloadJson);
//     client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//     log('Published payload: $payloadJson');
//   }
// }



// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:home_light/services/const.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// class MainControlPanel extends StatefulWidget {
//   const MainControlPanel({super.key});

//   @override
//   State<MainControlPanel> createState() => _MainControlPanelState();
// }

// class _MainControlPanelState extends State<MainControlPanel> {
//   Map<String, dynamic> updatedPayloadMap = {};

//   late MqttServerClient client;

//   @override
//   void initState() {
//     super.initState();
//     _connect();
//   }

//   Future<void> _connect() async {
//     client = MqttServerClient.withPort('mqtt.onwords.in', 'Client Test', 1883);
//     client.logging(on: false);
//     client.keepAlivePeriod = 60;
//     client.onConnected = _onConnected;
//     client.onDisconnected = _onDisconnected;
//     client.onSubscribed = _onSubscribed;

//     final connectMessage = MqttConnectMessage()
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce)
//         .withWillRetain();
//     client.connectionMessage = connectMessage;

//     try {
//       await client.connect(username, password);
//     } catch (e) {
//       log("Error connecting: $e");
//       client.disconnect();
//     }
//   }

//   void _onConnected() {
//     log('Connected');
//     setState(() {
//       _subscribeToTopics();
//     });
//   }

//   void _onDisconnected() {
//     log('Disconnected');
//   }

//   void _onSubscribed(String topic) {
//     log('Subscribed to $topic');
//   }

//   void _subscribeToTopics() {
//     client.subscribe('onwords/$productId/currentStatus', MqttQos.atMostOnce);
//     client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
//       final MqttPublishMessage receivedMessage =
//           c![0].payload as MqttPublishMessage;
//       // print(receivedMessage);
//       final String payload = MqttPublishPayload.bytesToStringAsString(
//           receivedMessage.payload.message);
//       log("Received message: $payload from topic: ${c[0].topic}");
//       setState(() {
//         updatedPayloadMap = jsonDecode(payload);
//         print(updatedPayloadMap);
//       });
//     });
//   }

//   // void publishStatus1() {
//   //   const topic = 'onwords/$productId/statuss';
//   //   final builder = MqttClientPayloadBuilder();
//   //   final payloadJson = jsonEncode(updatedPayloadMap);
//   //   print(updatedPayloadMap);
//   //   print('${payloadJson}--------------');
//   //   builder.addString(payloadJson);
//   //   client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//   //   setState(() {});
//   // }

//   void publishStatuss({required String deviceKey, required int status}) {
//     const topic = 'onwords/$productId/status';
//     final builder = MqttClientPayloadBuilder();

//     Map<String, dynamic> updatedPayloadMap = {
//       deviceKey: status,
//     };
//     final payloadJson = jsonEncode(updatedPayloadMap);
//     print('Updated Payload Map: $updatedPayloadMap');
//     print('JSON Payload: $payloadJson');

//     builder.addString(payloadJson);
//     client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Controller"),
//       ),
//       body: updatedPayloadMap.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               padding: const EdgeInsets.all(20),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 6 / 3,
//               ),
//               itemCount: 8,
//               itemBuilder: (context, index) {
//                 String deviceKey = updatedPayloadMap.keys.elementAt(index);
//                 dynamic deviceValue = updatedPayloadMap[deviceKey];

//                 return index == 5 || index == 7
//                     ? Center(
//                         child: Slider(
//                         onChanged: (value) {
//                           setState(() {
//                             updatedPayloadMap[deviceKey] = value.toInt();
//                           });
//                           publishStatuss(
//                               deviceKey: deviceKey, status: value.toInt());
//                           // publishStatuss(deviceKey, value.toInt());
//                         },
//                         value: deviceValue.toDouble(),
//                         min: 0,
//                         max: 5,
//                       ))
//                     : GestureDetector(
//                         onTap: () {
//                           int newValue = (deviceValue == 1) ? 0 : 1;
//                           setState(() {
//                             updatedPayloadMap[deviceKey] = newValue;
//                           });
//                           publishStatuss(
//                               deviceKey: deviceKey, status: newValue);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: deviceValue == 1
//                                   ? Colors.green
//                                   : Colors.blueGrey[100],
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 deviceKey,
//                                 style: const TextStyle(fontSize: 18),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 (deviceValue == 1) ? 'ON' : 'OFF',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: (deviceValue == 1)
//                                       ? Colors.black
//                                       : Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//               },
//             ),
//     );
//   }
// }

// SECOND CODE BUT ITS WORKING WITHOUT SPEED CONTROL PUBLISHMENT

// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:home_light/services/const.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// class MainControlPanel extends StatefulWidget {
//   const MainControlPanel({super.key});

//   @override
//   State<MainControlPanel> createState() => _MainControlPanelState();
// }

// class _MainControlPanelState extends State<MainControlPanel> {
//   Map<String, dynamic> updatedPayloadMap = {};

//   late MqttServerClient client;

//   @override
//   void initState() {
//     super.initState();
//     _connect();
//   }

//   Future<void> _connect() async {
//     client = MqttServerClient.withPort('mqtt.onwords.in', 'Client Test', 1883);
//     client.logging(on: false);
//     client.keepAlivePeriod = 60;
//     client.onConnected = _onConnected;
//     client.onDisconnected = _onDisconnected;
//     client.onSubscribed = _onSubscribed;

//     final connectMessage = MqttConnectMessage()
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce)
//         .withWillRetain();
//     client.connectionMessage = connectMessage;

//     try {
//       await client.connect(username, password);
//     } catch (e) {
//       log("Error connecting: $e");
//       client.disconnect();
//     }
//   }

//   void _onConnected() {
//     log('Connected');
//     setState(() {
//       _subscribeToTopics();
//     });
//   }

//   void _onDisconnected() {
//     log('Disconnected');
//   }

//   void _onSubscribed(String topic) {
//     log('Subscribed to $topic');
//   }

//   void _subscribeToTopics() {
//     client.subscribe('onwords/$productId/currentStatus', MqttQos.atMostOnce);
//     client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
//       final MqttPublishMessage receivedMessage =
//           c![0].payload as MqttPublishMessage;
//       final String payload = MqttPublishPayload.bytesToStringAsString(
//           receivedMessage.payload.message);
//       log("Received message: $payload from topic: ${c[0].topic}");
//       setState(() {
//         updatedPayloadMap = jsonDecode(payload);
//         print(updatedPayloadMap);
//       });
//     });
//   }

//   void publishStatuss({required String deviceKey, required int status}) {
//     const topic = 'onwords/$productId/status';
//     final builder = MqttClientPayloadBuilder();

//     Map<String, dynamic> updatedPayloadMap = {
//       deviceKey: status,
//     };
//     final payloadJson = jsonEncode(updatedPayloadMap);
//     print('Updated Payload Map: $updatedPayloadMap');
//     print('JSON Payload: $payloadJson');

//     builder.addString(payloadJson);
//     client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Controller"),
//       ),
//       body: updatedPayloadMap.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               padding: const EdgeInsets.all(20),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 6 / 3,
//               ),
//               itemCount: 8,
//               itemBuilder: (context, index) {
//                 String deviceKey = updatedPayloadMap.keys.elementAt(index);
//                 dynamic deviceValue = updatedPayloadMap[deviceKey];
//                 if (index == 5 || index == 7) {
//                   return Center(
//                     child: Column(
//                       children: [
//                         Text(
//                           deviceKey,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         Slider(
//                           onChanged: (value) {
//                             setState(() {
//                               updatedPayloadMap[deviceKey] = value.toInt();
//                             });
//                             publishStatuss(
//                               deviceKey: deviceKey,
//                               status: value.toInt(),
//                             );
//                           },
//                           value: deviceValue.toDouble(),
//                           min: 0,
//                           max: 5,
//                           divisions: 5,
//                           label: 'Fan Speed: ${deviceValue.toInt()}',
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return GestureDetector(
//                   onTap: () {
//                     int newValue = (deviceValue == 1) ? 0 : 1;
//                     setState(() {
//                       updatedPayloadMap[deviceKey] = newValue;
//                     });
//                     publishStatuss(
//                       deviceKey: deviceKey,
//                       status: newValue,
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: deviceValue == 1
//                           ? Colors.green
//                           : Colors.blueGrey[100],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           deviceKey,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           (deviceValue == 1) ? 'ON' : 'OFF',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: (deviceValue == 1)
//                                 ? Colors.black
//                                 : Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

//third one working but buggs

// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:home_light/services/const.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// class MainControlPanel extends StatefulWidget {
//   const MainControlPanel({super.key});

//   @override
//   State<MainControlPanel> createState() => _MainControlPanelState();
// }

// class _MainControlPanelState extends State<MainControlPanel> {
//   Map<String, dynamic> updatedPayloadMap = {};

//   late MqttServerClient client;

//   @override
//   void initState() {
//     super.initState();
//     _connect();
//   }

//   Future<void> _connect() async {
//     client = MqttServerClient.withPort('mqtt.onwords.in', 'Client Test', 1883);
//     client.logging(on: false);
//     client.keepAlivePeriod = 60;
//     client.onConnected = _onConnected;
//     client.onDisconnected = _onDisconnected;
//     client.onSubscribed = _onSubscribed;

//     final connectMessage = MqttConnectMessage()
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce)
//         .withWillRetain();
//     client.connectionMessage = connectMessage;

//     try {
//       await client.connect(username, password);
//     } catch (e) {
//       log("Error connecting: $e");
//       client.disconnect();
//     }
//   }

//   void _onConnected() {
//     log('Connected');
//     setState(() {
//       _subscribeToTopics();
//     });
//   }

//   void _onDisconnected() {
//     log('Disconnected');
//   }

//   void _onSubscribed(String topic) {
//     log('Subscribed to $topic');
//   }

//   void _subscribeToTopics() {
//     client.subscribe('onwords/$productId/currentStatus', MqttQos.atMostOnce);
//     client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
//       final MqttPublishMessage receivedMessage =
//           c![0].payload as MqttPublishMessage;
//       final String payload = MqttPublishPayload.bytesToStringAsString(
//           receivedMessage.payload.message);
//       log("Received message: $payload from topic: ${c[0].topic}");
//       setState(() {
//         updatedPayloadMap = jsonDecode(payload);
//         print(updatedPayloadMap);
//       });
//     });
//   }

//   void publishStatuss(
//       {required String deviceKey, required int status, int? speedController}) {
//     print(speedController);
//     print('-------------------------------');
//     const topic = 'onwords/$productId/status';
//     final builder = MqttClientPayloadBuilder();

//     Map<String, dynamic> payloadMap = {
//       deviceKey: status,
//       deviceKey:speedController
//     };
//     // Map<String, dynamic> payloadMapSpeed = {
//     //   deviceKey: status,
//     //   deviceKey: speedController
//     // };

//     // print(payloadMapSpeed);
//     // "device5": 1, "speed": 4,

//     final payloadJson = jsonEncode(payloadMap);

//     // print('Payload Map: $payloadMap');
//     print('JSON Payload: $payloadJson');

//     builder.addString(payloadJson);
//     client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Controller"),
//       ),
//       body: updatedPayloadMap.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               padding: const EdgeInsets.all(20),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 6 / 3,
//               ),
//               itemCount: 8,
//               itemBuilder: (context, index) {
//                 String deviceKey = updatedPayloadMap.keys.elementAt(index);
//                 dynamic deviceValue = updatedPayloadMap[deviceKey];

//                 if (index == 5 || index == 7) {
//                   return Center(
//                     child: Column(
//                       children: [
//                         Text(
//                           deviceKey,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         Slider(
//                           onChanged: (value) {
//                             setState(() {
//                               updatedPayloadMap[deviceKey] = value.toInt();
//                               print(updatedPayloadMap[deviceKey]);
//                               publishStatuss(
//                                   deviceKey: deviceKey,
//                                   status: value.toInt(),
//                                   speedController:
//                                       updatedPayloadMap[deviceKey]);
//                               print('sending speed');
//                               // if (deviceKey == 'device5' || deviceValue == 1) {
//                               // } else {
//                               //   publishStatuss(
//                               //       deviceKey: deviceKey,
//                               //       status: value.toInt());
//                               //   print('else');
//                               // }
//                             });
//                           },
//                           value: deviceValue.toDouble(),
//                           min: 0,
//                           max: 5,
//                           divisions: 5,
//                           label: 'Speed: ${deviceValue.toInt()}',
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return GestureDetector(
//                   onTap: () {
//                     int newValue = (deviceValue == 1) ? 0 : 1;
//                     setState(() {
//                       updatedPayloadMap[deviceKey] = newValue;
//                     });
//                     publishStatuss(
//                       deviceKey: deviceKey,
//                       status: newValue,
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: deviceValue == 1
//                           ? Colors.green
//                           : Colors.blueGrey[100],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           deviceKey,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           (deviceValue == 1) ? 'ON' : 'OFF',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: (deviceValue == 1)
//                                 ? Colors.black
//                                 : Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

//working all switches but sliedes are same

// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:home_light/services/const.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// class MainControlPanel extends StatefulWidget {
//   const MainControlPanel({super.key});

//   @override
//   State<MainControlPanel> createState() => _MainControlPanelState();
// }

// class _MainControlPanelState extends State<MainControlPanel> {
//   Map<String, dynamic> updatedPayloadMap = {};

//   late MqttServerClient client;

//   @override
//   void initState() {
//     super.initState();
//     _connect();
//   }

//   Future<void> _connect() async {
//     client = MqttServerClient.withPort('mqtt.onwords.in', 'Client Test', 1883);
//     client.logging(on: false);
//     client.keepAlivePeriod = 60;
//     client.onConnected = _onConnected;
//     client.onDisconnected = _onDisconnected;
//     client.onSubscribed = _onSubscribed;

//     final connectMessage = MqttConnectMessage()
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce)
//         .withWillRetain();
//     client.connectionMessage = connectMessage;

//     try {
//       await client.connect(username, password);
//     } catch (e) {
//       log("Error connecting: $e");
//       client.disconnect();
//     }
//   }

//   void _onConnected() {
//     log('Connected');
//     setState(() {
//       _subscribeToTopics();
//     });
//   }

//   void _onDisconnected() {
//     log('Disconnected');
//   }

//   void _onSubscribed(String topic) {
//     log('Subscribed to $topic');
//   }

//   void _subscribeToTopics() {
//     client.subscribe('onwords/$productId/currentStatus', MqttQos.atMostOnce);
//     client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
//       final MqttPublishMessage receivedMessage =
//           c![0].payload as MqttPublishMessage;
//       final String payload = MqttPublishPayload.bytesToStringAsString(
//           receivedMessage.payload.message);
//       log("Received message: $payload from topic: ${c[0].topic}");
//       setState(() {
//         updatedPayloadMap = jsonDecode(payload);
//         print(updatedPayloadMap);
//       });
//     });
//   }

//   void publishStatuss({
//     required String deviceKey,
//     required int status,
//     int? speed,
//     int? speed_1,
//   }) {
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
//     print('Payload Map: $payloadMap');
//     print('JSON Payload: $payloadJson');

//     builder.addString(payloadJson);
//     client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Controller"),
//       ),
//       body: updatedPayloadMap.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               padding: const EdgeInsets.all(20),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 4 / 3,
//               ),
//               itemCount: 8,
//               itemBuilder: (context, index) {
//                 String deviceKey = updatedPayloadMap.keys.elementAt(index);
//                 dynamic deviceValue = updatedPayloadMap[deviceKey];

//                 if (index == 4 || index == 6) {
//                   String speedKey = index == 5 ? 'speed' : 'speed_1';

//                   return  Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           int newValue = (deviceValue == 1) ? 0 : 1;
//                           setState(() {
//                             updatedPayloadMap[deviceKey] = newValue;
//                           });

//                           publishStatuss(
//                             deviceKey: deviceKey,
//                             status: newValue,
//                             speed: (deviceKey == 'device5')
//                                 ? updatedPayloadMap['speed']
//                                 : null,
//                             speed_1: (deviceKey == 'device6')
//                                 ? updatedPayloadMap['speed_1']
//                                 : null,
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: deviceValue == 1
//                                 ? Colors.green
//                                 : Colors.blueGrey[100],
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 deviceKey,
//                                 style: const TextStyle(fontSize: 18),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 (deviceValue == 1) ? 'ON' : 'OFF',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: (deviceValue == 1)
//                                       ? Colors.black
//                                       : Colors.black,
//                                 ),
//                               ),
//                               if (deviceValue == 1)
//                                 Slider(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       updatedPayloadMap[speedKey] =
//                                           value.toInt();
//                                     });

//                                     publishStatuss(
//                                       deviceKey: deviceKey,
//                                       status: updatedPayloadMap[deviceKey],
//                                       speed: (deviceKey == 'device5')
//                                           ? value.toInt()
//                                           : null,
//                                       speed_1: (deviceKey == 'device6')
//                                           ? value.toInt()
//                                           : null,
//                                     );
//                                   },
//                                   value:
//                                       updatedPayloadMap[speedKey]?.toDouble() ??
//                                           0.0,
//                                   min: 0,
//                                   max: 5,
//                                   divisions: 5, // Optional, for precise control
//                                   label:
//                                       '$speedKey: ${updatedPayloadMap[speedKey]}',
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // Slider will only be enabled if the device is ON (deviceValue == 1)
//                     ],
//                   );
//                 }

//                 return GestureDetector(
//                   onTap: () {
//                     int newValue = (deviceValue == 1) ? 0 : 1;
//                     setState(() {
//                       updatedPayloadMap[deviceKey] = newValue;
//                     });
//                     publishStatuss(
//                       deviceKey: deviceKey,
//                       status: newValue,
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: deviceValue == 1
//                           ? Colors.green
//                           : Colors.blueGrey[100],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           deviceKey,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           (deviceValue == 1) ? 'ON' : 'OFF',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: (deviceValue == 1)
//                                 ? Colors.black
//                                 : Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
