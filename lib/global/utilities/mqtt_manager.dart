import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:soulpot/global/utilities/GUID.dart';

class MQTTManager {
  String host = 'alesia-julianitow.ovh';
  int port = 9443;
  late String clientId;
  late MqttClient client;

  MQTTManager() {
    String uuid = GUID.generate();
    clientId = 'sp-app-$uuid';
    initMqttClient();
  }

  void initMqttClient() {
    client = MqttServerClient.withPort(host, clientId, port);
    client.logging(on: true);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
  }

  void onSubscribed() {
    print("MQTT SUBSCRIBED");
  }

  void onConnected() {
    print('MQTT LOGGED');
  }

  void onDisconnected() {
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('Client disconnect normally.');
    } else {
      print('Error when disconnecting');
    }
  }

  Future<void> connect() async {
    try {
      await client.connect("soulpot", "soulpot");
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
  void publishMsg(String msg, String deviceId) {
    final payloadBuilder = MqttClientPayloadBuilder();
    payloadBuilder.addString(msg);
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      if (payloadBuilder.payload != null) {
        client.publishMessage('events/$deviceId/sprink',
            MqttQos.atLeastOnce, payloadBuilder.payload!);
      } else {
        throw Exception('Payload cannot be null');
      }
    } else {
      throw Exception('MQTT Client not connected');
    }
  }

}