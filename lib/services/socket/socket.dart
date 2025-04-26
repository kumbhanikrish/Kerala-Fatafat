// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'dart:developer';

// import 'package:kolkata_fatafat/utils/theme/colors.dart';
// import 'package:kolkata_fatafat/utils/widgets/custom_dialog.dart';
// import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

// io.Socket? socket;

// class SocketService {
//   void socketConnect({required String userId}) {
//     socket = io.io(
//       'https://giving-equally-camel.ngrok-free.app',
//       io.OptionBuilder()
//           .setTransports(['websocket'])
//           .setQuery({'device': '1', 'u_id': userId})
//           .enableAutoConnect()
//           .setReconnectionAttempts(5)
//           .setReconnectionDelay(2000)
//           .build(),
//     );

//     // Listen for connection
//     socket?.onConnect((_) {
//       log('Connected to Socket.IO Server');
//     });

//     // Listen for incoming messages
//     socket?.on('message', (data) {
//       log('Received message: $data');
//     });

//     // Handle disconnection and attempt reconnect
//     socket?.onDisconnect((_) {
//       log('Disconnected from server. Attempting to reconnect...');
//     });

//     // Handle reconnection attempts
//     socket?.onReconnect((_) {
//       log('Reconnected to server');
//     });

//     // Handle reconnection errors
//     socket?.onReconnectError((error) {
//       log('Reconnection error: $error');
//     });

//     // Handle reconnection failure
//     socket?.onReconnectFailed((_) {
//       log('Reconnection failed. Manual reconnect required.');
//     });

//     // Connect the socket
//     socket?.connect();
//   }

//   disconnectSocket() {
//     socket?.disconnect();
//   }

//   Future<void> sendMessage(
//     BuildContext context, {
//     required Map<String, dynamic> body,
//     required DeviceCubit deviceCubit,
//     required String deviceId,
//   }) async {
//     if (socket != null && socket?.connected == true) {
//       await EasyLoading.show();

//       socket?.emit('message', body);
//       log('Message sent: $body');

//       socket?.on('message', (data) async {
//         await EasyLoading.show();
//         deviceCubit.getDeviceData(
//           context,
//           deviceData: data['data'],
//           channel: data['channel'],
//           deviceId: deviceId,
//         );
//       });
//     } else {
//       log('Socket is not connected. Message not sent.');
//     }
//   }
// }
