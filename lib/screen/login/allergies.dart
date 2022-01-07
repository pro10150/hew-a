import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'meal.dart';

class Allergies extends StatefulWidget {
  @override
  AllergiesState createState() => AllergiesState();
}

class AllergiesState extends State<Allergies> {
  Widget buildyesBtn() {
    return RaisedButton(
      onPressed: () {},
      // onPressed: () {
      //   var rount = new MaterialPageRoute(
      //       builder: (BuildContext context) => new Allergies());
      //   Navigator.of(context).push(rount);
      // },
      textColor: Colors.white,
      color: Colors.black,
      disabledColor: Colors.black,
      child: Text("Yes"),
      // onPressed: () {},
      padding: EdgeInsets.all(15),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  Widget buildnoBtn() {
    return RaisedButton(
      // onPressed: (){},
      onPressed: () {
        var rount = new MaterialPageRoute(
            builder: (BuildContext context) => new Mealpre());
        Navigator.of(context).push(rount);
      },
      textColor: Colors.black,
      color: Colors.white,
      disabledColor: Colors.white,
      child: Text("No"),
      // onPressed: () {},
      padding: EdgeInsets.all(15),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 1400,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/ee/a7/59/eea7597b2336cec27f04a875887bb2a6.jpg"),
                    fit: BoxFit.fill),
              ),
              child: null,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 250.0, left: 30.0, right: 30, bottom: 30),
                      child: Text(
                        "Did you have any allergies?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildnoBtn(),
                      buildyesBtn(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
