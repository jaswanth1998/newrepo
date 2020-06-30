import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getit/screens/auth/auth.dart';
import 'package:getit/services/authService.dart';

class DisplayFrom extends StatefulWidget {
  @override
  _DisplayFromState createState() => _DisplayFromState();
}

class _DisplayFromState extends State<DisplayFrom> {
  AuthService userauthservice = AuthService();
  final _formkey100 = GlobalKey<FormState>();
  String emailOfUser = "";
  String sendOtp = "";
  bool checkOtp = true;
  String pass = "";
  bool _showPassword = false;
  bool showPass = true;
  String displayErr = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
          // key: _formkey,
          key: _formkey100,
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

                validator: (val) => val.length >= 3 ? null : "Enter Email",
                onChanged: (val) {
                  this.emailOfUser = val;

                  // setState(() {
                  //   // this.password = val;
                  // });
                },
              ),
              SizedBox(
                height: 12,
              ),
              showPass
                  ? TextFormField(
                      // decoration:  textInputDecarator.copyWith(hintText: "Password"),
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0),
                            ),
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this._showPassword
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() =>
                                    this._showPassword = !this._showPassword);
                              })
                          // prefixText: "" ",

                          ),
                      // obscureText: true,
                      // keyboardType: TextInputType.,
                      obscureText: !_showPassword,

                      validator: (val) =>
                          val.length >= 1 ? null : "Enter Paasword",
                      onChanged: (val) {
                        this.pass = val;

                        // setState(() {
                        //   // this.password = val;
                        // });
                      },
                    )
                  : SizedBox(),
              SizedBox(height: 5),
              Container(
                child: GestureDetector(
                  onTapDown: (tapDtails) => {
                    print(" i am here"),
                    this.setState(() {
                      this.showPass = !this.showPass;
                      print(this.showPass);
                    })
                  },
                  child: Container(
                      width: double.infinity,
                      child:
                          Text("Forget Password", textAlign: TextAlign.start)),
                ),
              ),
              SizedBox(
                height: 12,
              ),
               SizedBox(height: 3),
              Text(
                this.displayErr,
                style: TextStyle(color: Colors.redAccent),
              ),
              SizedBox(height: 3),
              showPass
                  ? RaisedButton(
                      child: Text("Sign IN"),
                      onPressed: () async {
                        print(this.emailOfUser + this.pass);
                        print(_formkey100.currentState.validate());
                        if (_formkey100.currentState.validate()) {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          try {
                            AuthResult user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: this.emailOfUser,
                                    password: this.pass);
                          } catch (e) {
                            print("iam eror2");
                            print(e);
                             var result=  e.message;
                          if (result.length > 2) {
                        this.setState(() {
                          this.displayErr = e.message;
                        });
                      }
                          }
                        }

                        // setState(() {
                        //   // this.checkOtp = !checkOtp;
                        //   // if (_formkey100.currentState.validate()) {

                        //   //   userauthservice.verifyWithCode(
                        //   //       this.sendOtp, context);
                        //   //   //     setState(() {
                        //   //   //   this.checkOtp = !checkOtp;

                        //   //   // });
                        //   //   print("Sign IN");
                        //   // }
                        // }
                        // );
                      },
                    )
                  : RaisedButton(
                      child: Text("Get Email"),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: this.emailOfUser);
                        } catch (e) {
                           var result=  e.message;
                          if (result.length > 2) {
                        this.setState(() {
                          this.displayErr = e.message;
                        });
                      }
                        }
                      }),
            ],
          )),
    );
  }
}
