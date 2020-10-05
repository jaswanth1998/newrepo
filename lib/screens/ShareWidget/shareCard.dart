import 'package:flutter/material.dart';
import 'package:getit/models/MainAppotimentModel.dart';
import 'package:getit/models/doctorUserModel.dart';
import 'package:getit/screens/BookAppotiment/DetailsOfApp.dart';
import 'package:getit/screens/Home/bookappotiment/viewDoctorProfile.dart';
import 'package:getit/screens/ShareWidget/shareBottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareCard extends StatelessWidget {
  DoctorUserModel useModel;
  String userId;
  String sendPatientName;
  String sendPatientUid;
  String sendPatientPhoneNum;

  ShareCard({this.useModel, this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(17),
        child: Center(
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: 150,
                    child: Center(
                        child: useModel.gender == "Male"
                            ? Image.asset('assests/boydoctor.png')
                            : Image.asset('assests/grildoctor.jpeg')
                        //  Image(image: AssetImage("assests/cardDoctor.svg"))
                        )),
                Container(
                    width: double.infinity,
                    height: 100,
                    child: Text(
                      "\nName: " +
                          useModel.firstname +
                          "" +
                          "\nQualification: " +
                          useModel.qualificition +
                          "\n" +
                          "Hospital Name: " +
                          useModel.hospital +
                          "\n\n",
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        child: Text(
                          "View profile  ",
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewDoctorProfile(
                                      displayDetails: this.useModel)));
                        }),
                    SizedBox(width: 20),
                    RaisedButton(
                        child: Text("Book Appointment"),
                        color: Colors.blueAccent,
                        onPressed: () {
                          print(this.userId + " iam from sharecard");

                          Future<SharedPreferences> setData =
                              SharedPreferences.getInstance();
                          setData.then((data) => {
                                this.sendPatientPhoneNum =
                                    data.getString("patient phoneNum"),
                                this.sendPatientUid =
                                    data.getString("patient Uid"),
                                this.sendPatientName =
                                    data.getString("patient name"),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsOfApp(
                                              basicDetails: MainAppotimentModel(
                                                doctorName:
                                                    this.useModel.firstname,
                                                doctorUid: this
                                                    .useModel
                                                    .doctorDocumentId,
                                                doctorNum:
                                                    this.useModel.phoneNo,
                                                patientName:
                                                    this.sendPatientName,
                                                patientNum:
                                                    this.sendPatientPhoneNum,
                                                patientUid: this.sendPatientUid,
                                                hostipalName:
                                                    this.useModel.hospital,
                                                    doctorFee: useModel.doctorFee
                                              ),
                                            )))
                              });

                          // ShareBottomSheet(context: context)
                          //     .settingModalBottomSheet(
                          //         context,
                          //         useModel.doctorDocumentId,
                          //         useModel.firstname,
                          //         this.userId);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
