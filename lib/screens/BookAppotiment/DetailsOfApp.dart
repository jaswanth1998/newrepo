

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getit/models/MainAppotimentModel.dart';
import 'package:getit/screens/BookAppotiment/MainTranscation.dart';
import 'package:getit/screens/BookAppotiment/UpiBookAppotiment.dart';
import 'package:getit/screens/Home/myAppotiments.dart';
import 'package:getit/services/database.dart';
import 'package:upi_india/upi_india.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:flutter/services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class DetailsOfApp extends StatefulWidget {
  MainAppotimentModel basicDetails;
  DetailsOfApp({this.basicDetails});
  @override
  _DetailsOfAppState createState() =>
      _DetailsOfAppState(basicDetails: this.basicDetails);
}

class _DetailsOfAppState extends State<DetailsOfApp> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;
  // String selectedSlot = "Morning";
  String getDate = "";
  MainAppotimentModel basicDetails;
  bool isMorning = true;
  bool isMale = true;

  _DetailsOfAppState({this.basicDetails});
  Future _transaction;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(amount, phoneNum) async {
    var options = {
      'key': 'rzp_test_8IbZwSARRQ1LA4',
      'amount': amount,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': phoneNum, 'email': 'doctorguru@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
      print("sucess");
    } catch (e) {
      print("i am catch");
      debugPrint(e);
    }
  }

//   void openCheckout(amount, phoneNum) async {
// var response  =     await  http.post("http://34.87.152.11:5001/first-website-48486/us-central1/getPaymentToken?amount=10",body: {
// "amount":amount
//     });
//     print("i am response");
//    var responseJson =  jsonDecode(response.body);
//    if(responseJson["status"])
//  String stage = "TEST";
//     String orderId = responseJson["orderId"];
//     String orderAmount = amount.toString();
//     String tokenData = responseJson["token"];
//     String customerName = "Customer Name";
//     String orderNote = "Order Note";
//     String orderCurrency = "INR";
//     String appId = "403163baeaec68acd2f8e06fb61304";
//     String customerPhone = "9999999999";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";

//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "notifyUrl": notifyUrl,
//       "tokenData":tokenData
//     };

//     CashfreePGSDK.doPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//               print("$key : $value");
//               //Do something with the result
//             }));

//   }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("i am sucess response");
    print(response.paymentId);

    DataBaseServices().mainTransactionOfAppotiment(
        this.basicDetails.doctorUid,
        this.basicDetails.doctorName,
        this.basicDetails.patientUid,
        this.basicDetails.patientName,
        this.basicDetails.patientNum,
        response.paymentId,
        this.basicDetails.appotimentSlot,
        this.basicDetails.patientAge,
        this.basicDetails.patientGender,
        this.basicDetails.doctorFee);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyAppotiments(
          userId: this.basicDetails.patientUid,
        ),
        // settings: RouteSettings(
        //   arguments: [catgary[index],this.userid],
        // ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("i am  response");
    print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("i am  handle response");
    print(response);
  }

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
                  Text("You are Booking with " +
                      this.basicDetails.hostipalName +
                      " of Doctor " +
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
                        hintText: "Age",
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
                  Text("Select Slot"),
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
                      SizedBox(height: 10),
                      Text("Note: The amount charged is for the service. There is not self-cancellation of the booking. The amount will be refunded if the booking is canceled from the Doctor's end.", textAlign: TextAlign.center,),
                      SizedBox(height: 10),

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
                              child: Text("Pay " +
                                  this.basicDetails.doctorFee.toString()),
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
                                  if (this.isMale) {
                                    this.basicDetails.patientGender = "Male";
                                  } else {
                                    this.basicDetails.patientGender = "Female";
                                  }
                                  if (this.isMorning) {
                                    this.basicDetails.appotimentSlot =
                                        "Morning";
                                  } else {
                                    this.basicDetails.appotimentSlot =
                                        "Evening";
                                  }
                                  openCheckout(
                                      this.basicDetails.doctorFee * 100,
                                      this.basicDetails.patientNum);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => MainTranscation(
                                  //               basicDetails: this.basicDetails,
                                  //             )));
                                }
                              },
                            ),
                          ])
                    ],
                  ),
                ]),
              )),
        ));
  }
}
