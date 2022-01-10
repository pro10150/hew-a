import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'regsrceen.dart';
import 'allergies.dart';

class Mealpre extends StatefulWidget {
  @override
  MealpreState createState() => MealpreState();
}

class MealpreState extends State<Mealpre> {
  // MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
  //   final getColor = (Set<MaterialState> states) {
  //     if (states.contains(MaterialState.pressed)) {
  //       return colorPressed;
  //     } else {
  //       return color;
  //     }
  //   };
  //   return MaterialStateProperty.resolveWith(getColor);
  // }
  // bool _flag = true;

  Widget buildmealBtn() {
    return RaisedButton(
      onPressed: () {},
      onLongPress: null,
      textColor: Colors.white,
      color: Colors.black,
      disabledColor: Colors.black,
      child: Text("Food"),
      // onPressed: () {},
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );

    // ElevatedButton(
    //   onPressed: () => setState(() => _flag = !_flag),
    //   child: Text("Meal"),
    //   style: ElevatedButton.styleFrom(
    //     onPrimary : Colors.teal, primary: _flag ? Colors.black,// This is what you need!
    //   ),
    // );

    //

    //   ElevatedButton(
    //   style: ButtonStyle(
    //     foregroundColor: getColor(Colors.white,Colors.black),
    //     backgroundColor: getColor(Colors.black,Colors.white),
    //   ),
    //     onPressed: () {},
    //     child: Text("Meal")
    // );
  }

  Widget buildnextBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: 320,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          var rount = new MaterialPageRoute(
              builder: (BuildContext context) => new Allergies());
          Navigator.of(context).push(rount);
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.black,
        child: Text(
          'Next',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xffffffff),
                    Color(0xffff8a65),
                    Color(0xffe69a83),
                  ],
                  center: Alignment.topRight,
                  radius: 3,
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(top: 50, right: 35.0, left: 33.0),
                    child: Text(
                      "Choose your preference",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildmealBtn(),
                          buildmealBtn(),
                          buildmealBtn(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildmealBtn(),
                          buildmealBtn(),
                          buildmealBtn(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildmealBtn(),
                          buildmealBtn(),
                          buildmealBtn(),
                        ],
                      ),
                      SizedBox(height: 250),
                      buildnextBtn(),
                    ],
                  ),
                ],
              ),
            ),

        ],
      ),
    );
  }
}
