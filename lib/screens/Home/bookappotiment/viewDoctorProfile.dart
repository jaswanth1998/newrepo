import 'package:flutter/material.dart';
import 'package:getit/models/MainAppotimentModel.dart';
import 'package:getit/models/doctorUserModel.dart';
import 'package:getit/screens/BookAppotiment/DetailsOfApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewDoctorProfile extends StatefulWidget {
  DoctorUserModel displayDetails;
  ViewDoctorProfile({this.displayDetails});
  @override
  _ViewDoctorProfileState createState() =>
      _ViewDoctorProfileState(displayDetails: this.displayDetails);
}

class _ViewDoctorProfileState extends State<ViewDoctorProfile> {
  DoctorUserModel displayDetails;

  String sendPatientPhoneNum;

  String sendPatientUid;

  String sendPatientName;
  _ViewDoctorProfileState({this.displayDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Profile")),
      body: Center(
        child: Flexible(
                  child: Column(
            children: <Widget>[
                          SizedBox(height: 20),
              SizedBox(height: 20),

              Center(
                  child: displayDetails.gender == "Male"
                      ? Image.asset('assests/boydoctor.png')
                      : Image.asset('assests/grildoctor.jpeg')
                  //  Image(image: AssetImage("assests/cardDoctor.svg"))
                  ),
              SizedBox(height: 20),
              Text("Name:" +
                  this.displayDetails.firstname +
                  " " +
                  this.displayDetails.lastName
                  ,
                  style: TextStyle(fontSize: 21)),
              SizedBox(height: 20),
              Text("Experience: " + this.displayDetails.experience.toString() + " years",style: TextStyle(fontSize: 21),),
              SizedBox(height: 20),
              Text("Gender:" + this.displayDetails.gender.toString(),
              style: TextStyle(fontSize: 21)),
              SizedBox(height: 20),
              Text("Hospital:" + this.displayDetails.hospital,
              style: TextStyle(fontSize: 21)
              ),
              SizedBox(height: 20),
              Text("City:" + this.displayDetails.city,
              style: TextStyle(fontSize: 21)),
              SizedBox(height: 20),
              Text("Specialization:" + this.displayDetails.specialization,
              style: TextStyle(fontSize: 21)),
                          SizedBox(height: 20),

              RaisedButton(
                  child: Text("Book Appointment"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    // print(this.userId + " iam from sharecard");

                    Future<SharedPreferences> setData =
                        SharedPreferences.getInstance();
                    setData.then((data) => {
                          this.sendPatientPhoneNum =
                              data.getString("patient phoneNum"),
                          this.sendPatientUid = data.getString("patient Uid"),
                          this.sendPatientName = data.getString("patient name"),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsOfApp(
                                        basicDetails: MainAppotimentModel(
                                          doctorName:
                                              this.displayDetails.firstname,
                                          doctorUid: this
                                              .displayDetails
                                              .doctorDocumentId,
                                          doctorNum: this.displayDetails.phoneNo,
                                          patientName: this.sendPatientName,
                                          patientNum: this.sendPatientPhoneNum,
                                          patientUid: this.sendPatientUid,
                                          hostipalName:
                                              this.displayDetails.hospital,
                                        ),
                                      )))
                        });

                    // ShareBottomSheet(context: context)
                    //     .settingModalBottomSheet(
                    //         context,
                    //         displayDetails.doctorDocumentId,
                    //         displayDetails.firstname,
                    //         this.userId);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
