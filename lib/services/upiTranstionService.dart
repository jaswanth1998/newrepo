import 'package:flutter/material.dart';
import 'package:getit/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_india.dart';

class UpiTranstionService {
  Future _transaction;
  String doctorUserID;
  String patientUid;
  String patientName;
  String patientNum;
  String doctorName;

  UpiTranstionService({this.doctorUserID,this.patientUid,this.doctorName}){
    
           
  }


  Future<UpiIndiaResponse> initiateTransaction({String app =   UpiIndiaApp.GooglePay}) async {

         Future<SharedPreferences> setData = SharedPreferences.getInstance();
              setData.then(
                (data)=>{
                  
                  this.patientNum = data.getString("patient phoneNum"),
                  this.patientName = data.getString("patient name"),
                  print(patientNum+"  "+patientName),
                    DataBaseServices().appotiment("testing",doctorUserID,doctorName, patientUid,patientName,patientNum),
                }
              );
    print("i am here "+ app);
  
    UpiIndia upi = new UpiIndia(
  
    );

    UpiIndiaResponse response = await upi.startTransaction(
          app: app,
      receiverUpiId: 'jaswanthtata@ybl',
      receiverName: 'Jaswanth tata',
      transactionRefId: 'TestingId',
      transactionNote: '.',
      amount: 1.0,
    );
    return response;
  //  UpiIndiaResponse _upiResponse;
  //                     _upiResponse = UpiIndiaResponse(snapshot.data);
  //   print( );
  }

}