import 'package:flutter/material.dart';
import 'package:getit/models/MainAppotimentModel.dart';
import 'package:getit/services/database.dart';
import 'package:upi_india/upi_india.dart';

class ResultOfAppotimentm extends StatelessWidget {
  UpiIndiaResponse upiResponse;

  MainAppotimentModel basicDetails;
  ResultOfAppotimentm({this.upiResponse, this.basicDetails}) {
    DataBaseServices().mainTransactionOfAppotiment(
        this.basicDetails.doctorUid,
        this.basicDetails.doctorName,
        this.basicDetails.patientUid,
        this.basicDetails.patientName,
        this.basicDetails.patientNum,
        this.upiResponse.transactionId,
        this.upiResponse.responseCode,
        this.upiResponse.transactionRefId,
        this.upiResponse.status,
        this.upiResponse.approvalRefNo,
        this.basicDetails.appotimentSlot,
        this.basicDetails.patientAge,
        this.basicDetails.patientGender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Card(
        child: Column(
          children: <Widget>[Text("i am ok"), getCardOfOutPut()],
        ),
      )),
    );
  }

  Widget getCardOfOutPut() {
    if (upiResponse.error != null) {
      String text = '';
      // switch (snapshot.data.error) {
      //   case UpiIndiaResponseError.APP_NOT_INSTALLED:
      //     text = "Requested app not installed on device";
      //     break;
      //   case UpiIndiaResponseError.INVALID_PARAMETERS:
      //     text = "Requested app cannot handle the transaction";
      //     break;
      //   case UpiIndiaResponseError.NULL_RESPONSE:
      //     text = "requested app didn't returned any response";
      //     break;
      //   case UpiIndiaResponseError.USER_CANCELLED:
      //     text = "You cancelled the transaction";
      //     break;
      // }
      return Center(
        child: Text(text),
      );
    }
    String txnId = upiResponse.transactionId;
    String resCode = upiResponse.responseCode;
    String txnRef = upiResponse.transactionRefId;
    String status = upiResponse.status;
    String approvalRef = upiResponse.approvalRefNo;
    switch (status) {
      case UpiIndiaResponseStatus.SUCCESS:
        print('Transaction Successful');
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Transaction Id: $txnId\n'),
        Text('Response Code: $resCode\n'),
        Text('Reference Id: $txnRef\n'),
        Text('Status: $status\n'),
        Text('Approval No: $approvalRef'),
      ],
    );
  }
}
