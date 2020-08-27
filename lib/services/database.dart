import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataBaseServices {
  String getCatgary;
  DataBaseServices({this.getCatgary});
  final CollectionReference doctorsRference =
      Firestore.instance.collection("Users");
  final CollectionReference appointementRefrence =
      Firestore.instance.collection("Appotiments");

  final CollectionReference liveTokenRefrence =
      Firestore.instance.collection("LiveToken");

  //Brew list from sanpshot
  _brewListFormQuesrySanpshot(QuerySnapshot snapshot) {
    snapshot.documents.map((doc) {
      print(doc.data["Age"]);
    }).toList();
    //  return  snapshot.documents.map((doc) {
    //     print(doc.data);
    //     return doc.data;
    //     // (Brew(
    //     //     name: doc.data["name"] ?? "",
    //     //     strength: doc.data["strength"] ?? 0,
    //     //     sugars: doc.data['Sugars'] ?? "0"
    //     //  ) );
    //   }).toList();
  }

  // Stream<List<QuerySnapshot>> get brews {
  // //  brewRefrence.snapshots().map(_brewListFormQuesrySanpshot).forEach((action){
  // //    print("object");
  // //     print(action);
  // //   });
  //   return doctorsRference.snapshots().map(_brewListFormQuesrySanpshot);
  // }
  bool getData() {
    print("I am here");
    doctorsRference.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
      return true;
    });
  }

  Future registerUser(String uId, String firstName, String lastName, int age,
      String gender, String city , String phoneNum,String userNotificationToken) async {
    return await doctorsRference.document(uId).setData({
      "userUid": uId,
      "first Name": firstName,
      "Last Name": lastName,
      "age": age,
      "gender": gender,
      "city": city,
      "phone Num":phoneNum,
      "Notification Token":userNotificationToken
    });
  }

  Future transactionOfAppotiment(
      String getDoctorUid,
      String getDoctorName,
      String patientUid,
      String getpatientName,
      String getpatientNum,
      String txnId,
      String resCode,
      String txnRef,
      String status,
      String approvalRef) async {
    print("iam in transtion state");
    return await appointementRefrence.add({
      "Doctor User ID": getDoctorUid,
      "Doctor Name": getDoctorName,
      "Patent Uid": patientUid,
      "patient Name": getpatientName,
      "paatient Num": getpatientNum,
      "refund": false,
      "txnId": txnId,
      "resCode": resCode,
      "txnRef": txnRef,
      "status": status,
      "token": 0,
      "approvalRef": approvalRef,
      "CompletedAt": FieldValue.serverTimestamp(),
    });
  }

  Future appotiment(String testing, String getDoctorUid, String getdoctorName,
      String patientUid, String getpatientName, String getpatientNum) async {
    return await appointementRefrence.add({
      "Testing": testing,
      "patient Uid": patientUid,
      "Doctor User ID": getDoctorUid,
      "patient Name": getpatientName,
      "patient num": getpatientNum,
      "doctor Name": getdoctorName,
      "startedAt": FieldValue.serverTimestamp(),
    });
  }


  Future mainTransactionOfAppotiment(
      String getDoctorUid,
      String getDoctorName,
      String patientUid,
      String getpatientName,
      String getpatientNum,
      String txnId,
      String appotimentSlot,
      int patientAge,
      String patientGender,
      
      
      ) async {
    print("iam in transtion state");
    return await appointementRefrence.add({
      "Doctor User ID": getDoctorUid,
      "Doctor Name": getDoctorName,
      "Patent Uid": patientUid,
      "patient Name": getpatientName,
      "paatient Num": getpatientNum,
      "refund": false,
      "txnId": txnId,
      "token": 0,      
      "CompletedAt": FieldValue.serverTimestamp(),
      "appotimentSlot":appotimentSlot,
      "patient age":patientAge,
      "patient gender":patientGender,
      "status":"success"
    });
  }

  
  // StreamBuilder liveToke(String userId){

  // return Firestore.instance.collection("Appotiments")
  //       .where("Patent Uid",isEqualTo: userId)
  //       .where("status",isEqualTo:"success");

  // }
}
