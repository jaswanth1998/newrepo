import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getit/screens/auth/auth.dart';
import 'package:getit/services/authService.dart';

class RegisterFromAuth extends StatefulWidget {
  @override
  _RegisterFromAuthState createState() => _RegisterFromAuthState();
}

class _RegisterFromAuthState extends State<RegisterFromAuth> {
  AuthService userauthservice = AuthService();
  final _formkey15 = GlobalKey<FormState>();
  String phoneNum = "";
  String sendOtp = "";
  bool checkOtp = true;
  String pass = "";
  String confromPAss = "";
  bool _showPassword = false;
  String displayErr = "";
  final _formkey101 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
          // key: _formkey,
          key: _formkey101,
          child: Column(
            children: <Widget>[
              TextFormField(
                // decoration:  textInputDecarator.copyWith(hintText: "Password"),
                decoration: InputDecoration(
                  hintText: "Email",
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(25.0),
                    ),
                  ),
                  // prefixText: "" ",
                ),
                // obscureText: true,
                // keyboardType: TextInputType.number,

                validator: (val) => val.length >= 10 ? null : "Enter Email",
                onChanged: (val) {
                  this.phoneNum = val;

                  // setState(() {
                  //   // this.password = val;
                  // });
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                // decoration:  textInputDecarator.copyWith(hintText: "Password"),
                decoration: InputDecoration(
                  hintText: "Password",
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(25.0),
                    ),
                  ),
                  // prefixText: "" ",
                ),
                // obscureText: true,
                // keyboardType: TextInputType.,
                obscureText: true,

                validator: (val) => val.length >= 1 ? null : "Enter Paasword",
                onChanged: (val) {
                  this.pass = val;

                  // setState(() {
                  //   // this.password = val;
                  // });
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                // decoration:  textInputDecarator.copyWith(hintText: "Password"),
                decoration: InputDecoration(
                  hintText: "Conform Password",
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                            () => this._showPassword = !this._showPassword);
                      }),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(25.0),
                    ),
                  ),
                  // prefixText: "" ",
                ),
                // obscureText: true,
                // keyboardType: TextInputType.,
                obscureText: this._showPassword,

                validator: (val) =>
                    val == this.pass ? null : "Password DoesNot match",
                onChanged: (val) {
                  // this.paconfromPAssss = val;

                  // setState(() {
                  //   // this.password = val;
                  // });
                },
              ),

               SizedBox(height: 3),
              Text(
                this.displayErr,
                style: TextStyle(color: Colors.redAccent),
              ),
              SizedBox(height: 3),
              RaisedButton(
                  child: Text("Sign IN"),
                  onPressed: () async {
                    print(this.phoneNum + this.pass);
                    print(_formkey101.currentState.validate());
                    if (_formkey101.currentState.validate()) {
                      try {
                        print("i am here reg");

                        final FirebaseAuth _auth = FirebaseAuth.instance;

                        AuthResult result =
                            await _auth.createUserWithEmailAndPassword(
                                email: this.phoneNum, password: this.pass);
                        try {
                          result.user.sendEmailVerification();
                          // return result.user.uid;
                        } catch (e) {
                          print(
                              "An error occured while trying to send email        verification");
                          print(e);
                        }

                        //                             FirebaseUser user = result.user;
                        // print(user.uid);

                      } catch (e) {
                        print("ia m erroo while register");
                        var result=  e.message;
                          if (result.length > 2) {
                        this.setState(() {
                          this.displayErr = e.message;
                        });
                      }
                      }
                    }
                  }),

              // RaisedButton(onPressed: (){
              //   super.setState(() {

              //   });
              // })
            ],
          )),
    );
  }
}
