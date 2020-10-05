import 'package:flutter/material.dart';
import 'package:getit/screens/ShareWidget/constart.dart';
import 'package:getit/screens/ShareWidget/loding.dart';
import 'package:getit/screens/auth/displayFrom.dart';
import 'package:getit/screens/auth/registerAuth.dart';
import 'package:getit/services/authService.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final _formkey301 = GlobalKey<FormState>();
  String phoneNum = "";
  bool checkOtp = false;
 String userOtp = "";
AuthService _phoneauth =  new   AuthService() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              "Welcome to  Doctor's Token",
              style: TextStyle(fontSize: 34, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            new Image.asset('assests/icon.png')
          
      
            // new Image.asset('assests/splash.gif')
          ],
        ),
      ),
      bottomSheet: Form(
        key:_formkey301 ,
              child: Container(
          color: Colors.lightBlueAccent,
          child: Wrap(
              // margin: EdgeInsets.all(20),

              children: <Widget>[
                
                   TextFormField(
                     
                      decoration:
                          textInputDecarator.copyWith(hintText: "Enter Phone Number"),
                      onChanged: (val) {
                        this.phoneNum = val;
                      },
                      validator: (val) =>
                          val.length != 10 ? 'Check phone number' : null,
                    ),
                    SizedBox(height: 10),
                    this.checkOtp?TextFormField(
                     
                      decoration:
                          textInputDecarator.copyWith(hintText: "OTP"),
                      onChanged: (val) {
                        this.userOtp = val;
                      },
                      validator: (val) =>
                          val.length <= 1? 'Enter OTP' : null,
                    ):Text(""),
                     Center(
                      child: GestureDetector(
                        onTap:(){
                          setState(() {
                            this.checkOtp = false;
                          });
                        },
                        child: this.checkOtp? Text("change Phone Number"):Text("")),
                    ),
                    Center(
                      child: RaisedButton(onPressed: (){
                        
                        if (_formkey301.currentState.validate()) {
                          if(this.userOtp.length<2){
 this._phoneauth.loginWithPhoneNumber(this.phoneNum, context);
                           this.setState(() {
                        this.checkOtp = true; 
                       }); 
                          }else{
                            this.checkOtp = true; 
                            this._phoneauth.verifyWithCode(this.userOtp, context);
                          }
                        
                        }
                      
                      },
                      child: this.checkOtp? Text("validate otp"):Text("Send OTP"),),
                    ),
                   

                
                
              ]),
        ),
      ),
    );
  }

  checkStateOfframeHere() {}
}
