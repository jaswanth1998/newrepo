import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getit/screens/Home/catgary.dart';
import 'package:getit/screens/Home/notifyitmsg.dart';
import 'package:getit/screens/Home/showDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getit/screens/Home/testScreen.dart';
import 'package:getit/screens/Registration/registrationOfUser.dart';
import 'package:getit/screens/auth/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  String userid;

  Home({this.userid});

  @override
  _HomeState createState() {
    print("iaam2");
    // print(this.userid);

    return _HomeState(userid: this.userid);
  }
}

class _HomeState extends State<Home> {
  String userid;

  _HomeState({this.userid});

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Future<FirebaseUser> getFirebaseUser() async {
  //   FirebaseUser user = await firebaseAuth.currentUser();
  //   print(user.uid+"iam here");
  //   print(user != null ? user.uid : null);
  // }\

  @override
  Widget build(BuildContext context) {
    // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // Future<FirebaseUser> getFirebaseUser() async {
    //   FirebaseUser user = await firebaseAuth.currentUser();
    //   print(user.uid+"iam here");
    //   print(user != null ? user.uid : null);
    // }
    // print("iam3");
    try {
      print(this.userid + "i am 4");
      // http.post(
      //   'https://test.cashfree.com/api/v2/cftoken/order',
      //   headers: <String, String>{
      //     'Content-Type': 'application/json',
      //     'x-client-id': '403163baeaec68acd2f8e06fb61304',
      //     'x-client-secret': '47e84502f4c6562c4d9f15dd598796d5887504b3'
      //   },
      //   body: jsonEncode(<String, Object>{
      //     "orderId": "Order0001",
      //     "orderAmount": 1,
      //     "orderCurrency": "INR"
      //   }),
      // ).then((value) => {
      //   print("i am value"),
      //   print(jsonDecode(value.body)["cftoken"])
      // });
      notifyItmsg().startNotify();
    } catch (e) {
      print("i am error");
      print(e);
      return Wrapper();
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        drawer: ShowDrawer(
          userId: this.userid,
        ),
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(this.userid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              // print(snapshot.data.exists.toString() +"eits");
              print(this.userid + "iamuserid");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("loading data");
              } else if ((snapshot.connectionState == ConnectionState.active) &&
                  snapshot.data.exists) {
                Future<SharedPreferences> setData =
                    SharedPreferences.getInstance();
                setData.then((data) => {
                      print("patient name"),
                      print(snapshot.data.data()),
                      print(snapshot.data.data()["first Name"]),
                      data.setString(
                          "patient name", snapshot.data.data()["first Name"]),
                      data.setString("patient phoneNum",
                          snapshot.data.data()["phone Num"]),
                    });

                print("patient name");
                print(snapshot.data.data());
                print(snapshot.data.data()["first Name"]);
                // return testScreen();
                return Catgagery(
                  userid: this.userid,
                  userName: snapshot.data.data()["first Name"],
                  sarchCity: snapshot.data.data()["city"],
                );
              } else {
                return RegistrationOfUser(uid: this.userid);
              }
              return SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Text("hi"),
                ],
              ));
            })
        // Catgagery(),
        );
  }
}
