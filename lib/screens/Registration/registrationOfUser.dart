import 'package:flutter/material.dart';
import 'package:getit/screens/ShareWidget/constart.dart';
import 'package:getit/screens/auth/displayFrom.dart';
import 'package:getit/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationOfUser extends StatefulWidget {
  String uid;

  RegistrationOfUser({this.uid});

  @override
  _RegistrationOfUserState createState() => _RegistrationOfUserState(uid: this.uid);
}

class _RegistrationOfUserState extends State<RegistrationOfUser> {
  
  String firstName;

  String lastName;

  int age;

  String gender = "Male";

  String city;

  String phoneNum;
    String uid;

    String userNotificationToken = "";

  _RegistrationOfUserState({this.uid});

  @override
  Widget build(BuildContext context) {
    final _formkey5 = GlobalKey<FormState>();
    
     Future<SharedPreferences> setData = SharedPreferences.getInstance();
    setData.then((data) => {
          this.userNotificationToken = data.getString("User Notification Token")
        });
    return 
    
    
    SingleChildScrollView(
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
              key: _formkey5,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: firstName,
                      decoration:
                          textInputDecarator.copyWith(hintText: "First Name"),
                      onChanged: (val) {
                        this.firstName = val;
                      },
                      validator: (val) =>
                          val.length <= 1 ? 'Enter First Name' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: lastName,
                      decoration:
                          textInputDecarator.copyWith(hintText: "Last Name"),
                      onChanged: (val) {
                        this.lastName = val;
                      },
                      validator: (val) =>
                          val.length <= 1 ? 'Enter Last Name' : null,
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      value: gender,
                      // icon: Icon(Icons.arrow_downward),
                      // iconSize: 24,
                      // elevation: 16,
                      // style: TextStyle(
                      //   color: Colors.deepPurple
                      // ),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.deepPurpleAccent,
                      // ),
                      onChanged: (String newValue) {
                        setState(() {
                          this.gender = newValue;
                        });
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: textInputDecarator.copyWith(hintText: "age"),
                      validator: (val) => val.length > 2 || val.length == 0
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
                      decoration: textInputDecarator.copyWith(hintText: "City"),
                      onChanged: (val) {
                        this.city = val;
                      },
                      validator: (val) => val.length <= 1 ? 'Enter City' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          textInputDecarator.copyWith(hintText: "Phone Number"),
                      onChanged: (val) {
                        this.phoneNum = val;
                      },
                      validator: (val) =>
                          val.length == 10 ? null : "Enter 10 digit phone Num",
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          if (_formkey5.currentState.validate()) {
                            dynamic result = DataBaseServices().registerUser(
                                this.uid,
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
  }
}
