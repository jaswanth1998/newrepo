import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:getit/models/MainAppotimentModel.dart';
import 'package:getit/screens/BookAppotiment/ResultOfAppotiment.dart';
import 'package:upi_india/upi_india.dart';

class MainTranscation extends StatefulWidget {
  MainAppotimentModel basicDetails;
  MainTranscation({this.basicDetails});

  @override
  _HomePageState createState() =>
      _HomePageState(basicDetails: this.basicDetails);
}

class _HomePageState extends State<MainTranscation> {
  MainAppotimentModel basicDetails;
  _HomePageState({this.basicDetails});
  Future<UpiIndiaResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiIndiaApp> apps;

  @override
  void initState() {
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
      });
    });
    super.initState();
  }

  Future<UpiIndiaResponse> initiateTransaction(String app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: 'jaswanthtata@ybl',
      receiverName: 'Jaswanth tata',
      transactionRefId: 'TestingId',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps.length == 0)
      return Center(child: Text("No apps found to handle transaction."));
    else
      return Center(
        child: Wrap(
          children: apps.map<Widget>((UpiIndiaApp app) {
            return GestureDetector(
              onTap: () {
                _transaction = initiateTransaction(app.app);
                setState(() {});
              },
              child: Container(
                height: 100,
                width: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.memory(
                      app.icon,
                      height: 60,
                      width: 60,
                    ),
                    Text(app.name),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UPI'), automaticallyImplyLeading: false),
      body: Column(
        children: <Widget>[
          displayUpiApps(),
       
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: _transaction,
              builder: (BuildContext context,
                  AsyncSnapshot<UpiIndiaResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('An Unknown error has occured'));
                  }
                  UpiIndiaResponse _upiResponse;
                  _upiResponse = snapshot.data;

                  if (_upiResponse.error != null) {
                    String text = '';
                    switch (snapshot.data.error) {
                      case UpiIndiaResponseError.APP_NOT_INSTALLED:
                        text = "Requested app not installed on device";
                        break;
                      case UpiIndiaResponseError.INVALID_PARAMETERS:
                        text = "Requested app cannot handle the transaction";
                        break;
                      case UpiIndiaResponseError.NULL_RESPONSE:
                        text = "requested app didn't returned any response";
                        break;
                      case UpiIndiaResponseError.USER_CANCELLED:
                        text = "You cancelled the transaction";
                        break;
                    }
                    return Center(
                      child: Text(text),
                    );
                  } else {
                    String txnId = _upiResponse.transactionId;
                    String resCode = _upiResponse.responseCode;
                    String txnRef = _upiResponse.transactionRefId;
                    String status = _upiResponse.status;
                    String approvalRef = _upiResponse.approvalRefNo;
                    switch (status) {
                      case UpiIndiaResponseStatus.SUCCESS:
                        print('Transaction Successful');
                        try {
// Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultOfAppotimentm()));
                        } catch (e) {}
                        break;
                      case UpiIndiaResponseStatus.SUBMITTED:
                        print('Transaction Submitted');
                        break;
                      case UpiIndiaResponseStatus.FAILURE:
                        print('Transaction Failed');

                        break;
                      default:
                        print('Received an Unknown transaction status');
                    }
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      if (status == "success") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultOfAppotimentm(
                                    upiResponse: _upiResponse,
                                    basicDetails: this.basicDetails,
                                  )),
                        );
                      }
                    });

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Transaction Id: $txnId\n'),
                        Text('Response Code: $resCode\n'),
                        Text('Reference Id: $txnRef\n'),
                        Text('Status: $status\n'),
                        Text('Approval No: $approvalRef'),
                        RaisedButton(
                            child: Text("Click here to proceed further"),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultOfAppotimentm(
                                            upiResponse: _upiResponse,
                                            basicDetails: this.basicDetails,
                                          )));
                            })
                      ],
                    );
                  }
                } else
                  return Text(' ');
              },
            ),
          )
        ],
      ),
    );
  }
}
