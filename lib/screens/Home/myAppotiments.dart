import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getit/models/appotimentModel.dart';
import 'package:getit/screens/Home/LiveToken.dart';

class MyAppotiments extends StatefulWidget {
  String userId;
  MyAppotiments({this.userId});
  @override
  _MyAppotimentsState createState() => _MyAppotimentsState(userId: this.userId);
}

class _MyAppotimentsState extends State<MyAppotiments> {
  String userId;
  _MyAppotimentsState({this.userId});

  List<AppotimentModel> data = [];

  List<Text> data1 = [];
  @override
  Widget build(BuildContext context) {
    print(this.userId + " iam ffrom appointents");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Appointments"),
          bottom: TabBar(
            tabs: [
              Tab(child:Text("Up Coming")),
              Tab(child: Text("Completed"),),
            ],
          ),
        ),
        body: TabBarView(children: [
          StreamBuilder(
            stream: Firestore.instance
                .collection("Appotiments")
                .where("Patent Uid", isEqualTo: userId)
                .where("status", isEqualTo: "success")
                .where("CompletedAt",
                    isGreaterThan: DateTime.now().subtract(Duration(days: 1)))
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                print("Loading");
                return Text("Loading");
              }
              var userDocument = snapshot;

              this.data = (userDocument.data.documents.map((useData) {
                return AppotimentModel(
                    useData["status"], useData["CompletedAt"],
                    doctorName: useData["Doctor Name"],
                    tokenNum: useData["token"],
                    doctorid: useData['Doctor User ID'],
                    appotimmentSlot: useData["appotimentSlot"]


                    //  useData["Doctor User ID"],
                    //  useData["status"],

                    );
              })).toList();
              return SingleChildScrollView(
                child: Column(
                    children: data.map((appotiment) {
                  print(appotiment.datenow);
                  // return Text(appotiment.datenow.toString());
                  return Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text("\n Doctor Name:   " +
                              appotiment.doctorName +
                              "        \n",
                              style: TextStyle(fontSize: 21)),
                          Text(appotiment.datenow + "\n",
                          style: TextStyle(fontSize: 21)),
                          appotiment.tokenNum == 0
                              ? Text("Token Number " +
                                  appotiment.tokenNum.toString(),
                                  style: TextStyle(fontSize: 21))
                              : Text("Your Token Number " +
                                  appotiment.tokenNum.toString(),
                                
              style: TextStyle(fontSize: 21)
                                  
                                  ),

                                 appotiment.appotimmentSlot ==null? Text("Slot Time:"):Text("Slot Time: " + appotiment.appotimmentSlot,style: TextStyle(fontSize: 21)),
                          //  LiveToken(userId: "ok"),

                          appotiment.doctorid.length > 0
                              ? StreamBuilder(
                                  stream: Firestore.instance
                                      .collection("LiveToken")
                                      .where("Uid",
                                          isEqualTo: appotiment.doctorid)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    var userDocument = snapshot;
                                    print("iam doc1");
                                    print(appotiment.doctorid);
                                    int check = -2;
                                    if (!snapshot.hasData) {
                                      return Text("No Data found");
                                    } else {
                                      this.data1 = (userDocument.data.documents
                                          .map((useData) {
                                        print("iam doc2");
                                        check = useData["Token"];
                                      })).toList();
                                      print(("i am here4"));
                                      if (check == -2) {
                                        return Text("NO Live Token");
                                      } else {
                                        return Text(
                                            "Live Token " + check.toString(),
              style: TextStyle(fontSize: 21)
                                            );
                                      }
                                    }
                                    // return Text(snapshot.data.documentChanges.map((f)));
                                  })
                              : Text("No Live Token"),
                          // Text("Still pending with doctor \n"),
                        ],
                      ));
                }).toList()),
              );
            },
          ),
          StreamBuilder(
            stream: Firestore.instance
                .collection("Appotiments")
                .where("Patent Uid", isEqualTo: userId)
                .where("status", isEqualTo: "success")
                .where("CompletedAt",
                    isLessThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                print("Loading");
                return Text("Loading",
              style: TextStyle(fontSize: 21)
                );
              }
              var userDocument = snapshot;

              this.data = (userDocument.data.documents.map((useData) {
                return AppotimentModel(
                    useData["status"], useData["CompletedAt"],
                    doctorName: useData["Doctor Name"],
                    tokenNum: useData["token"],
                    doctorid: useData['Doctor User ID']

                    //  useData["Doctor User ID"],
                    //  useData["status"],

                    );
              })).toList();
              return SingleChildScrollView(
                child: Column(
                    children: data.map((appotiment) {
                  print(appotiment.datenow);
                  // return Text(appotiment.datenow.toString());
                  return Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text("\n Doctor Name:   " +
                              appotiment.doctorName +
                              "        \n",
              style: TextStyle(fontSize: 21)
                              ),
                          Text(appotiment.datenow + "\n",
                          
              style: TextStyle(fontSize: 21)
                          ),
                          appotiment.tokenNum == 0
                              ? Text("token Number " +
                                  appotiment.tokenNum.toString(),
              style: TextStyle(fontSize: 21)
                                  )
                              : Text("Your token Number " +
                                  appotiment.tokenNum.toString(),
              style: TextStyle(fontSize: 21)
                                  
                                  ),
                                  appotiment.appotimmentSlot ==null? Text("Slot Time:"):Text("Slot Time: " + appotiment.appotimmentSlot,style: TextStyle(fontSize: 21)),

                          //  LiveToken(userId: "ok"),

                          appotiment.doctorid.length > 0
                              ? StreamBuilder(
                                  stream: Firestore.instance
                                      .collection("LiveToken")
                                      .where("Uid",
                                          isEqualTo: appotiment.doctorid)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    var userDocument = snapshot;
                                    print("iam doc1");
                                    print(appotiment.doctorid);
                                    int check = -2;
                                    if (!snapshot.hasData) {
                                      return Text("No Data found",
              style: TextStyle(fontSize: 21)
                                      );
                                    } else {
                                      this.data1 = (userDocument.data.documents
                                          .map((useData) {
                                        print("iam doc2");
                                        check = useData["Token"];
                                      })).toList();
                                      print(("i am here4"));
                                      if (check == -2) {
                                        return Text("NO Live Token",
                                        
              style: TextStyle(fontSize: 21)
                                        );
                                      } else {
                                        return Text(
                                            "Live Token " + check.toString(),
                                            
              style: TextStyle(fontSize: 21)
                                            );
                                      }
                                    }
                                    // return Text(snapshot.data.documentChanges.map((f)));
                                  })
                              : Text("No Live Token"),
                          // Text("Still pending with doctor \n"),
                        ],
                      ));
                }).toList()),
              );
            },
          ),
        ]),
      ),
    );
  }
}
