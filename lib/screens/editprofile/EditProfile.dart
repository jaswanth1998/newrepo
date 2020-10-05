import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getit/screens/ShareWidget/constart.dart';
import 'package:getit/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  String userid;
  EditProfile({this.userid});
  @override
  _EditProfileState createState() => _EditProfileState(userid: this.userid);
}

class _EditProfileState extends State<EditProfile> {
  String userid;
  _EditProfileState({this.userid});

  

  String firstName;

  String lastName;

  int age;

  String gender = "Male";

  String city;

  String phoneNum;

  String userNotificationToken = "";

  final _formkey6 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(this.userid+ "this is userisfor edit");
    
     Future<SharedPreferences> setData = SharedPreferences.getInstance();
    setData.then((data) => {
          this.userNotificationToken = data.getString("User Notification Token")
        });
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(this.userid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              
              if (snapshot.hasData) {


          this.firstName  = snapshot.data.data()["data"]["first Name"];

          this.lastName = snapshot.data.data()["data"]["Last Name"];

          this.age = snapshot.data.data()["data"]["age"];

          this.gender  = snapshot.data.data()["data"]["gender"];

          this.city = snapshot.data.data()["data"]["city"];

          this.phoneNum = snapshot.data.data()["data"]["phone Num"];

               return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Text(
                        "Registration Page",
                        textAlign: TextAlign.center,
                      )),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Form(
                          key: _formkey6,
                          child: SingleChildScrollView(
                            reverse: true,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  initialValue: firstName,
                                  decoration: textInputDecarator.copyWith(
                                      hintText: "First Name"),
                                  onChanged: (val) {
                                    this.firstName = val;
                                  },
                                  validator: (val) => val.length <= 1
                                      ? 'Enter First Name'
                                      : null,
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: lastName,
                                  decoration: textInputDecarator.copyWith(
                                      hintText: "Last Name"),
                                  onChanged: (val) {
                                    this.lastName = val;
                                  },
                                  validator: (val) => val.length <= 1
                                      ? 'Enter Last Name'
                                      : null,
                                ),
                                SizedBox(height: 10),
                              
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: this.age.toString(),
                                  decoration: textInputDecarator.copyWith(
                                      hintText: "Age"),
                                  validator: (val) =>
                                      val.length > 2 || val.length == 0
                                          ? 'Enter correct age'
                                          : null,
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    this.age = int.parse(val);
                                  },
                                ),
                                SizedBox(height: 10),

                                // TextFormField(
                                //   decoration:
                                //       textInputDecarator.copyWith(hintText: "Gender"),
                                //   onChanged: (val) {
                                //     this.gender = val;
                                //   },
                                //   validator: (val) =>
                                //       val.length <= 1 ? 'Enter Gender' : null,
                                // ),
                                TextFormField(
                                  initialValue: this.city,
                                  decoration: textInputDecarator.copyWith(
                                      hintText: "City"),
                                  onChanged: (val) {
                                    this.city = val;
                                  },
                                  validator: (val) =>
                                      val.length <= 1 ? 'Enter City' : null,
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: this.phoneNum,
                                  keyboardType: TextInputType.number,
                                  decoration: textInputDecarator.copyWith(
                                      hintText: "Phone Number"),
                                  onChanged: (val) {
                                    this.phoneNum = val;
                                  },
                                  validator: (val) => val.length == 10
                                      ? null
                                      : "Enter 10 digit phone Num",
                                ),
                                SizedBox(height: 20),
                               
                               
                                SizedBox(height: 10),
                                RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      if (_formkey6.currentState.validate()) {
                                        dynamic result = DataBaseServices()
                                            .registerUser(
                                                this.userid,
                                                this.firstName,
                                                this.lastName,
                                                this.age,
                                                this.gender,
                                                this.city,
                                                this.phoneNum,
                                                this.userNotificationToken);
                                        print(result);
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Text("Loding");
              }
            }));
  }
}
