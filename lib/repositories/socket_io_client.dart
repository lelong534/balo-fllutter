// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:zalo/models/message.dart';

// class SocketIoClient {
//   Socket socket;
//   bool init = false;

//   void initialize() {
//     socket = io(
//       'https://zalochatserver.herokuapp.com',
//       OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
//     );

//     socket.onConnectError((e) {
//       print('onConnectError: $e');
//     });
//   }

//   void connect({String userId}) {
//     if (!init) {
//       initialize();
//       init = true;
//     }

//     socket.io.options['extraHeaders'] = {'user_id': userId};

//     socket.connect();
//   }

//   void disconnect() {
//     socket.disconnect();
//   }

//   void sendMessage({Message message}) {
//     // socket.emit('send', messageToJson(message));
//   }

//   void subscribeCallback({String event, dynamic callback}) {
//     socket.on(event, (jsonData) {
//       print('event: $event: $jsonData');
//       callback(jsonData);
//     });
//   }
// }
