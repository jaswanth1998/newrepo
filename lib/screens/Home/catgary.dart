import 'package:flutter/material.dart';
import 'package:getit/screens/Home/seeDoctotr.dart';

// import 'package:getit/screens/doctormain/seeDoctotr.dart';

class Catgagery extends StatefulWidget {
  String userid;
  String userName;
  String sarchCity;

  Catgagery({this.userid, this.userName, this.sarchCity});

  @override
  _CatgageryState createState() => _CatgageryState(
      userid: this.userid, userName: this.userName, sarchCity: this.sarchCity);
}

class _CatgageryState extends State<Catgagery> {
  String userid;
  String userName;
  String sarchCity;

  _CatgageryState({this.userid, this.userName, this.sarchCity});

  List<String> user = ["hi", "hello", "working"];
  List<String> catgary = [
    "General",
    "Diabetes",
    "ENT",
    "Nephrology",
    "Neurology",
    "Oncology",
    "Pediatrician",
    "Psychology",
    "Cardiology",
    "Physiology",
    "Dentist",
"Dermotology",
"Homeopathy"
  ];
  // List<Color> useColor = [Colors.red,Colors.blue];
  String dropdownValue = 'Kadapa';
  String serachCity = 'Kadapa';
  bool checkSerachCity = false;
  
  @override
  Widget build(BuildContext context) {
    
    // print(this.userid+"iam from cat");
    // print(this.userName + "iam cat");
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Text("Select City"),
        DropdownButton<String>(
          value:checkSerachCity?dropdownValue:serachCity,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String newValue) {
            this.setState(() {
              this.dropdownValue = newValue;
              this.checkSerachCity = true;
              this.serachCity = newValue;
            });
          },
          items: <String>['Kadapa', 'Mydukur', 'proddatur']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Expanded(
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.

            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 2 / 1,

            // Generate 100 widgets that display their index in the List.
            children: List.generate(catgary.length, (index) {
              return Container(
                child: Center(
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          color: Colors.redAccent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeDoctor(
                                  userid: this.userid,
                                  searchcat: catgary[index],
                                  searchCity: this.serachCity,
                                ),
                                settings: RouteSettings(
                                  arguments: [catgary[index], this.userid],
                                ),
                              ),
                            );
                            print("i am here");
                          },
                          child: Text(
                            catgary[index],
                            style: TextStyle(
                                // color: useColor[index]
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
