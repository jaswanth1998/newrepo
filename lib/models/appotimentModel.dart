import 'package:intl/intl.dart';
class AppotimentModel {
  String testing;
  var  datenow;
  String doctorid;
  String doctorName;
  int tokenNum;
  String appotimmentSlot;
  AppotimentModel(String testing, var datenow,{this.doctorid,this.tokenNum,this.doctorName,this.appotimmentSlot}){
    this.testing = testing;
    print(DateTime.fromMicrosecondsSinceEpoch(datenow.microsecondsSinceEpoch).toString() + "i am type" );
    // this.datenow  = DateTime.fromMillisecondsSinceEpoch(datenow);
    //  DateFormat.yMMMd().format(new DateTime.now())

    DateTime thatDate = DateTime.fromMicrosecondsSinceEpoch(datenow.microsecondsSinceEpoch) ;
    String formattedDate = DateFormat("dd-MM-yyyy 'on Time' kk:mm").format(thatDate);
    // String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(thatDate);
    this.datenow  = formattedDate;

  }




}