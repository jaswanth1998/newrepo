import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LiveToken extends StatelessWidget {
  String userId;
  List<Text> data = [];
  LiveToken({this.userId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text("Home"),
        ),
        body: 
        // Text("i am ok")
        StreamBuilder(
          


          stream: Firestore.instance.collection("Appotiments")

        .where("Uid",isEqualTo: userId)
        .where("status",isEqualTo:"success")
        
        .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
           var userDocument = snapshot;

          // this.data = (userDocument.data.documents.map((useData) {
            
          //   return Text(useData["Token"]);
          // })).toList();
          return Text("NO Live Token");
          // return Text(snapshot.data.documentChanges.map((f)));
        }
        ),
    );
  }
}