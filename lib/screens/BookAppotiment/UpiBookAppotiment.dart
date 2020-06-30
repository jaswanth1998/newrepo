import 'package:upi_india/upi_india.dart';

 class UpiBookAppotiment{
   Future<UpiIndiaResponse> _transaction;

    
   
  Future<UpiIndiaResponse>   startTranstion({String app =   UpiIndiaApp.GooglePay}) async{
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
    print("I am respose");

    print(response);
    print("i am reposnes");
    return response;
    }
 }