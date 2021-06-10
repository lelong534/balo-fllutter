// import 'package:zalo/models/message.dart';
// import 'package:zalo/repositories/socket_io_client.dart';

// class SocketIoRepository {
//   final SocketIoClient socketIoClient;

//   SocketIoRepository({this.socketIoClient});

//   void connect({String userId}) {
//     socketIoClient.connect(userId: userId);
//   }

//   void disconnect() {
//     socketIoClient.disconnect();
//   }
// // 
//   void sendMessage({Message message}) {
//     socketIoClient.sendMessage(message: message);
//   }

//   void subscribeReceiveCallback({dynamic callback}) {
//     socketIoClient.subscribeCallback(event: 'receive', callback: callback);
//   }
// }