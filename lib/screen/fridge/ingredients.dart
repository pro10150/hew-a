import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Ingredients extends StatefulWidget {
  static const routeName = '/';

  const Ingredients({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IngredientsState();
  }
}

class _IngredientsState extends State<Ingredients> {
  List<int> text = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          color: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 8,
                          child: Container(
                            child: Center(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
