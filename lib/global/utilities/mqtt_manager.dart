import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:soulpot/global/utilities/GUID.dart';

class MQTTManager {
  static String host = 'alesia-julianitow.ovh';
  static String username = "soulpot";
  static String password = "soulpot";
  static int port = 9443;
  static late String clientId;
  static late MqttClient client;
  static final MQTTManager instance = MQTTManager._internal();

  MQTTManager._internal();

  factory MQTTManager() {
    String uuid = GUID.generate();
    clientId = 'sp-app-$uuid';
    initMqttClient();
    return instance;
  }

  static void initMqttClient() {
    client = MqttServerClient.withPort(host, clientId, port);
    client.logging(on: false);
    client.setProtocolV311();
    client.keepAlivePeriod = 1000;
    client.onConnected = onConnected;
  }

  static void onSubscribed() {
    print("MQTT SUBSCRIBED");
  }

  static void onConnected() {
    print('MQTT LOGGED');
  }

  static void onDisconnected() {
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('Client disconnect normally.');
    } else {
      print('Error when disconnecting');
    }
  }

  Future<void> connect() async {
    try {
      await client.connect(username, password);
      return;
    } on NoConnectionException catch (e) {
      print('Client exception - $e');
      client.disconnect();
    } on Exception catch (e) {
      print('Socket exception $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print('MQTT connection failed -> status: ${client.connectionStatus}');
      client.disconnect();
    }
  }
  void publishMsg(String msg, String deviceId, String topic) {
    final payloadBuilder = MqttClientPayloadBuilder();
    payloadBuilder.addString(msg);
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      if (payloadBuilder.payload != null) {
        client.publishMessage('c2d/$deviceId$topic',
            MqttQos.atLeastOnce, payloadBuilder.payload!);
      } else {
        throw Exception('Payload cannot be null');
      }
    } else {
      throw Exception('MQTT Client not connected');
    }
  }

}