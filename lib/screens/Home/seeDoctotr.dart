import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:getit/models/doctorUserModel.dart';
import 'package:getit/screens/ShareWidget/shareCard.dart';
import 'package:getit/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeeDoctor extends StatefulWidget {
  String userid;
  String searchcat;
  String searchCity;

  SeeDoctor({this.userid, this.searchcat, this.searchCity});
  @override
  _SeeDoctorState createState() => _SeeDoctorState(
      userid: this.userid,
      searchcat: this.searchcat,
      searchCity: this.searchCity);
}

class _SeeDoctorState extends State<SeeDoctor> {
  String userid;
  String searchcat;
  String searchCity;

  _SeeDoctorState({this.userid, this.searchcat, this.searchCity});

  // final brews = Provider.of<List<Brew>>(context)??[];
  List<DoctorUserModel> data;
  @override
  Widget build(BuildContext context) {
    print("i am from serch");
    print(this.searchcat);
    // final doctor = Provider.of<List<QuerySnapshot>>(context)??[];

    // final String todo = ModalRoute.of(context).settings.arguments;

    //  bool user =  DataBaseServices().getData();
    // print(user);
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("data"),
    //   ),
    //   body: Text(todo),
    // );

    return Scaffold(
      appBar: AppBar(title: Text("Doctors")),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Users')
              .where(
                "Doctor",
                isEqualTo: true,
              )
              .where("specialization", isEqualTo: this.searchcat)
              .where("leave", isEqualTo: false)
              .where("city", isEqualTo: this.searchCity)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("Loading");
              return Text("Loading");
            }
            if (snapshot.data.documents.length == 0) {
              print("Loading");
              return Center(child: Text("No Doctors available"));
            }
            var userDocument = snapshot;

            this.data = (userDocument.data.documents.map((useData) {
              return DoctorUserModel(
                  doctorDocumentId: useData.documentID,
                  age: useData["Age"],
                  experience: useData["Experience"],
                  firstname: useData["First name"],
                  lastName: useData["Last Name"],
                  uID: useData["UID"],
                  hospital: useData["Hospital"],
                  city: useData["city"],
                  phoneNo: useData["phone"],
                  specialization: useData["specialization"],
                  gender: useData["gender"],
                  qualificition: useData["Qualificition"]);
            })).toList();

            return SingleChildScrollView(
              child: Column(
                children: data.map((foo) {
                  print(this.userid + "i am frm seeDocootr");
                  return ShareCard(
                    useModel: foo,
                    userId: this.userid,
                  );
                }).toList(),
              ),
            );
          }),
    );
  }
}
