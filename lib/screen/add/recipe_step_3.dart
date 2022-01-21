import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hewa/screen/launcher.dart';

class RecipeStep3 extends StatefulWidget {
  @override
  _RecipeStep3State createState() => _RecipeStep3State();
}

const List<String> method = ['Bake', 'Boil', 'Fry', 'Multiple'];

const List<String> type = ['Savory', 'Dessert'];

class _RecipeStep3State extends State<RecipeStep3> {
  int _n = 1;
  int _ingr = 240;

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 1) _n--;
    });
  }

  Widget _getIngredients() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Icon(MdiIcons.pigVariantOutline),
          Row(children: <Widget>[
            Text(
              'Pork',
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              (_ingr * _n).toStringAsFixed(0),
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              'g',
              style: TextStyle(fontSize: 10),
            )
          ]),
          Text(
            'คุณมีไม่พอ',
            style: TextStyle(color: Colors.red, fontSize: 10),
          )
        ],
      ),
    );
  }

  Widget _getIngredientsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _getIngredients(),
        _getIngredients(),
        _getIngredients(),
        _getIngredients()
      ],
    );
  }

  Widget _getRecipeStep() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 9,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.all(20),
          child: Column(children: <Widget>[
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'Step 1',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 20,
                  ),
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        text:
                            'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      strutStyle: StrutStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            GFButton(
              onPressed: () {},
              text: '5 min',
              textColor: Colors.black,
              shape: GFButtonShape.pills,
              type: GFButtonType.outline2x,
              color: Colors.black,
            )
          ]),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 9,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image(
              image: AssetImage('lib/assets/menu_detail/recipe.png'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  List<Widget> getPickerItems(List<String> list) {
    List<Widget> items = [];
    for (var i in list) {
      items.add(Text(i));
    }
    return items;
  }

  int _selectedHour = 0, _selectedMinute = 0;
  String _selectedMethod = 'Select method';
  String _selectedType = 'Select type';
  @override
  Widget build(BuildContext context) {
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
                            color: Colors.black, shape: BoxShape.circle),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('3', style: TextStyle(color: Colors.white))
                            ]),
                      ),
                    ]),
                SingleChildScrollView(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: double.infinity,
                      color: Color(0xffF4F6F6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40)),
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
                            margin: EdgeInsets.all(20),
                            child: Column(children: <Widget>[
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'You need',
                                      style: TextStyle(fontSize: 24),
                                    )),
                              ),
                              _getIngredientsRow(),
                              _getIngredientsRow()
                            ]),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 170,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40)),
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
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 30),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Nutrition Facts',
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            '*per serving',
                                            style: TextStyle(fontSize: 10),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(children: <Widget>[
                                          Text('Calories'),
                                          Text('260')
                                        ]),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Protein'),
                                            Text('15 g')
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(children: <Widget>[
                                          Text('Fat'),
                                          Text('9 g')
                                        ]),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Carbs'),
                                            Text('15 g')
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40)),
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
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 30),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            'Estimated time',
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        Icon(
                                          MdiIcons.clockOutline,
                                          size: 60,
                                        ),
                                        SizedBox(height: 10),
                                        Text('30 min')
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text('Recipe detail',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))),
                          _getRecipeStep(),
                          _getRecipeStep(),
                          _getRecipeStep(),
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Launcher()));
                                      },
                                      child: Text('Done'))))
                        ],
                      ),
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    ));
  }
}
