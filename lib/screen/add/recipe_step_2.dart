import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'recipe_step_3.dart';
import 'package:image_picker/image_picker.dart';

class RecipeStep2 extends StatefulWidget {
  @override
  _RecipeStep2State createState() => _RecipeStep2State();
}

const List<String> method = ['Bake', 'Boil', 'Fry', 'Multiple'];

const List<String> type = ['Savory', 'Dessert'];

int _selectedMinute = 0;
var minute = 0;

class _RecipeStep2State extends State<RecipeStep2> {
  int _count = 1;
  void _addNewStepColumn() {
    setState(() {
      _count = _count + 1;
      print(_count);
    });
  }

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile);
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  buildTimer(BuildContext context) {
    return TextButton(
        onPressed: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xff999999),
                            width: 0.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CupertinoButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          CupertinoButton(
                            child: Text('Add'),
                            onPressed: () {
                              setState(() {
                                minute = _selectedMinute;
                                print(minute);
                              });
                              Navigator.pop(context);
                            },
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 5.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 320,
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: CupertinoPicker(
                              itemExtent: 32,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  _selectedMinute = value;
                                });
                              },
                              children:
                                  new List<Widget>.generate(500, (int index) {
                                var amount;
                                if (index > 0) {
                                  amount = index;
                                } else {
                                  amount = '-';
                                }
                                return new Center(
                                  child: new Text('${amount}'),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
        },
        child: minute != 0 ? Text('${minute}') : Text('-'));
  }

  List<Widget> extractedChildren = <Widget>[
    new Align(alignment: Alignment.centerLeft, child: Text('Recipe')),
    new SizedBox(height: 10),
    new TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            filled: true,
            hintText: 'Recipe',
            fillColor: Colors.white)),
    new SizedBox(height: 10),
    new Align(alignment: Alignment.centerLeft, child: Text('Description')),
    new SizedBox(height: 10),
    new TextField(
        maxLines: 5,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            filled: true,
            hintText: 'Description',
            fillColor: Colors.white))
  ];
  List<Widget> getPickerItems(List<String> list) {
    List<Widget> items = [];
    for (var i in list) {
      items.add(Text(i));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos = new List.generate(_count, (int i) => StepColumn());
    return Scaffold(
        body: SingleChildScrollView(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          color: Color(0xffF4F6F6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft, child: BackButton()),
                  Align(
                      alignment: Alignment.center,
                      child: Text('ไข่เจียว',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      image: AssetImage('lib/assets/home/food.png'),
                      fit: BoxFit.cover,
                      height: 300,
                      width: 300,
                    ),
                    // decoration:
                    //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('1', style: TextStyle(color: Colors.white))
                            ]),
                      ),
                      Container(
                        width: 50,
                        height: 2,
                        color: Colors.black,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('2', style: TextStyle(color: Colors.white))
                            ]),
                      ),
                      Container(
                        width: 50,
                        height: 2,
                        color: Colors.black,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '3',
                              )
                            ]),
                      ),
                    ]),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _count,
                          itemBuilder: (BuildContext context, int index) {
                            int count = index + 1;
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Step $count',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Description')),
                                  SizedBox(height: 10),
                                  TextField(
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          filled: true,
                                          hintText: 'Description',
                                          fillColor: Colors.white)),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: _image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Image.file(_image!),
                                                ))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Icon(Icons.add),
                                                )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: _image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Image.file(_image!),
                                                ))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Icon(Icons.add),
                                                )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: _image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Image.file(_image!),
                                                ))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Icon(Icons.add),
                                                )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: _image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Image.file(_image!),
                                                ))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.white,
                                                  child: Icon(Icons.add),
                                                )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Timer'),
                                        buildTimer(context),
                                        Text('minute')
                                      ])
                                ]);
                          },
                          shrinkWrap: true,
                        ),
                        InkWell(
                          onTap: () {
                            _addNewStepColumn();
                            print(_count);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 9,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: double.infinity,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: RecipeStep3(),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 40),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text('Next'),
                                        Icon(Icons.arrow_forward_ios),
                                        SizedBox(width: 10)
                                      ]),
                                )))
                      ],
                    )),
              ])
            ],
          ),
        ),
      ),
    ));
  }
}

class StepColumn extends StatefulWidget {
  @override
  _StepColumnState createState() => _StepColumnState();
}

class _StepColumnState extends State<StepColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: Text('Recipe')),
              SizedBox(height: 10),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      hintText: 'Recipe',
                      fillColor: Colors.white)),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerLeft, child: Text('Description')),
              SizedBox(height: 10),
              TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      hintText: 'Description',
                      fillColor: Colors.white))
            ]));
  }
}
