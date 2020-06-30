import 'package:flutter/material.dart';
import 'package:getit/models/MainAppotimentModel.dart';
import 'package:getit/screens/BookAppotiment/MainTranscation.dart';
import 'package:getit/screens/BookAppotiment/UpiBookAppotiment.dart';
import 'package:upi_india/upi_india.dart';

class DetailsOfApp extends StatefulWidget {
  MainAppotimentModel basicDetails;
  DetailsOfApp({this.basicDetails});
  @override
  _DetailsOfAppState createState() =>
      _DetailsOfAppState(basicDetails: this.basicDetails);
}

class _DetailsOfAppState extends State<DetailsOfApp> {
  // String selectedSlot = "Morning";
  String getDate = "";
  MainAppotimentModel basicDetails;
  bool isMorning = true;
  bool isMale = true;

  _DetailsOfAppState({this.basicDetails});
  Future _transaction;

  @override
  Widget build(BuildContext context) {
    // this.basicDetails.appotimentSlot = "Morning";
    print("i am basic details");
    print(this.basicDetails.doctorName +
        this.basicDetails.doctorNum +
        this.basicDetails.doctorUid +
        " " +
        this.basicDetails.patientName +
        " " +
        this.basicDetails.patientNum +
        " " +
        this.basicDetails.patientUid);
    print("i am basic details");
    final _formkey11 = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Form(
              key: _formkey11,
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Text("You are booking with " +
                      this.basicDetails.hostipalName +
                      " of doctor " +
                      this.basicDetails.doctorName),
                  SizedBox(height: 10),
                  TextFormField(
                      onChanged: (val) {
                        this.basicDetails.patientName = val;
                      },
                      initialValue: this.basicDetails.patientName,
                      validator: (val) =>
                          val.length <= 1 ? "Enter Your Name" : null,
                      decoration: new InputDecoration(
                        hintText: "Name",
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(25.0),
                          ),
                        ),
                      )),
                  SizedBox(height: 10),
                  TextFormField(
                      initialValue:
                          this.basicDetails.patientAge.toString() == "null"
                              ? ""
                              : this.basicDetails.patientAge.toString(),
                      onChanged: (val) {
                        this.basicDetails.patientAge = int.parse(val);
                      },
                      validator: (val) =>
                          val.length <= 1 ? "Enter Your age" : null,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        hintText: "age",
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(25.0),
                          ),
                        ),
                      )),
                  SizedBox(height: 10),
                  TextFormField(
                      onChanged: (val) {
                        this.basicDetails.patientNum = val;
                      },
                      initialValue: this.basicDetails.patientNum,
                      validator: (val) =>
                          val.length <= 1 ? "Enter Your Phone Number" : null,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        hintText: "Phone Number",
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(25.0),
                          ),
                        ),
                      )),
                  SizedBox(height: 10),
                  Text("Select slot"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  key: null,
                                  onChanged: (val) {
                                    this.setState(() {
                                      this.isMorning = !val;
                                    });
                                  },
                                  value: isMorning),
                              Text("Morning")
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  key: null,
                                  onChanged: (val) {
                                    this.setState(() {
                                      this.isMorning = !val;
                                    });
                                  },
                                  value: !isMorning),
                              Text("Evening")
                            ],
                          ),
                        ),
                      ]),

                  SizedBox(height: 10),
                  Text("Select Gender"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  key: null,
                                  onChanged: (val) {
                                    this.setState(() {
                                      this.isMale = !val;
                                    });
                                  },
                                  value: isMale),
                              Text("Male")
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  key: null,
                                  onChanged: (val) {
                                    this.setState(() {
                                      this.isMale = !val;
                                    });
                                  },
                                  value: !isMale),
                              Text("Female")
                            ],
                          ),
                        ),
                      ]),

                  // Row(children: <Widget>[
                  //   Text("Select slot:     "),
                  //   DropdownButton<String>(
                  //     value: this.basicDetails.appotimentSlot,
                  //     icon: Icon(Icons.arrow_downward),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.deepPurple),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (String newValue) {
                  //       setState(() {
                  //         this.basicDetails.appotimentSlot = newValue;
                  //         this.basicDetails.patientAge =
                  //             this.basicDetails.patientAge;
                  //       });
                  //     },
                  //     items: <String>['Morning', 'Evening']
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ]),

                  Column(
                    children: <Widget>[
                      SizedBox(height: 100),
                      Text(getDate),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 10,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black)),
                                color: Color.fromRGBO(215, 71, 71, 0.5),
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                width: 2, height: 30, color: Colors.black45),
                            SizedBox(width: 10),
                            RaisedButton(
                              color: Color.fromRGBO(71, 215, 71, 0.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              child: Text("Book"),
                              onPressed: () async {
                                if (_formkey11.currentState.validate()) {
                                  print("i am basic details");
                                  print(this.basicDetails.doctorName +
                                      this.basicDetails.doctorNum +
                                      this.basicDetails.doctorUid +
                                      " " +
                                      this.basicDetails.patientName +
                                      " " +
                                      this.basicDetails.patientNum +
                                      " " +
                                      this.basicDetails.patientUid);
                                  print("i am basic details");
                                  if(this.isMale){
                                    this.basicDetails.patientGender = "Male";
                                  }else{
                                   this.basicDetails.patientGender = "Female"; 
                                  }
                                  if(this.isMorning){
                                    this.basicDetails.appotimentSlot = "Morning";
                                  }else{
                                   this.basicDetails.appotimentSlot = "Evening"; 
                                  }

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainTranscation(
                                                basicDetails: this.basicDetails,
                                              )));
                                }
                              },
                            ),
                          ])
                    ],
                  ),

                  // FutureBuilder(
                  //     future: _transaction,
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       print(this._transaction);
                  //       if (snapshot.connectionState ==
                  //               ConnectionState.waiting ||
                  //           snapshot.data == null) {
                  //         return Text('Waiting for result');
                  //       } else {
                  //         switch (snapshot.data.toString()) {
                  //           case UpiIndiaResponseError.APP_NOT_INSTALLED:
                  //             return Text(
                  //               'App not installed.',
                  //             );
                  //             break;
                  //           case UpiIndiaResponseError.INVALID_PARAMETERS:
                  //             return Text(
                  //               'Requested payment is invalid.',
                  //             );
                  //             break;
                  //           case UpiIndiaResponseError.USER_CANCELLED:
                  //             return Text(
                  //               'It seems like you cancelled the transaction.',
                  //             );
                  //             break;
                  //           case UpiIndiaResponseError.NULL_RESPONSE:
                  //             return Text(
                  //               'No data received',
                  //             );
                  //             break;
                  //             UpiIndiaResponse _upiResponse;
                  //             _upiResponse = UpiIndiaResponse(snapshot.data);
                  //             String txnId = _upiResponse.transactionId;
                  //             String resCode = _upiResponse.responseCode;
                  //             String txnRef = _upiResponse.transactionRefId;
                  //             String status = _upiResponse.status;
                  //             String approvalRef = _upiResponse.approvalRefNo;
                  //             return Column(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceEvenly,
                  //               children: <Widget>[
                  //                 Text('Transaction Id: $txnId'),
                  //                 Text('Response Code: $resCode'),
                  //                 Text('Reference Id: $txnRef'),
                  //                 Text('Status: $status'),
                  //                 Text('Approval No: $approvalRef'),
                  //               ],
                  //             );
                  //         }
                  //       }
                  //     }),
                ]),
              )),
          // bottomSheet: Container(

          //   child:
          // )
        ));
  }
}
