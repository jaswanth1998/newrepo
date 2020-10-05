
import 'package:intl/intl.dart';

class MainAppotimentModel{

 String doctorName;
 String doctorUid;
 String doctorNum;
 String patientName;
 String patientUid;
 String patientNum;
 int patientAge;
 String hostipalName;
 String appotimentSlot;
 String patientGender;
 int doctorFee;

 MainAppotimentModel({
   this.doctorName,
   this.doctorUid,
   this.doctorNum,
   this.patientName,
   this.patientUid,
   this.patientNum,
   this.patientAge,
   this.hostipalName,
   this.appotimentSlot = "Morning",
   this.patientGender,
   this.doctorFee
   
   
 });
 

}

