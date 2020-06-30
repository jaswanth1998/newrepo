import 'package:flutter/material.dart';
import 'package:getit/services/testService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class testScreen extends StatelessWidget {
  
  String aceesdata;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged:(val){
                this.aceesdata = val;
              }
            ),
            RaisedButton(
              child: Text("set"),
              onPressed: () async{
              SharedPreferences setData = await SharedPreferences.getInstance();
              setData.setString("key", "value");

            }),
             RaisedButton(
              child: Text("get"),
              onPressed: () async{
              SharedPreferences setData = await SharedPreferences.getInstance();
              print(setData.getString("patient phoneNum"));

            })
          ],
        ),     
    );
  }
}