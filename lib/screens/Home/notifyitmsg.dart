

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
class notifyItmsg{
  
  startNotify(){
    print("i am installed");
_firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        print("onMessage: $message");
        _showItemDialog(message);
              },
              // onBackgroundMessage: myBackgroundMessageHandler,
              // onLaunch: (Map<String, dynamic> message) async {
              //   print("onLaunch: $message");
              //   // _navigateToItemDetail(message);
              // },
              // onResume: (Map<String, dynamic> message) async {
              //   print("onResume: $message");
              //   // _navigateToItemDetail(message);
              // },
            );
          }
        
          void _showItemDialog(message) {
            print(message["notification"]["body"]);
              Fluttertoast.showToast(
        msg: message["notification"]["body"] );
          }
}

