import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:getwidget/getwidget.dart';

class RecipePost extends StatefulWidget {
  @override
  _RecipePostState createState() => _RecipePostState();
}

class _RecipePostState extends State<RecipePost> {
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

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.44,
        minChildSize: 0.20,
        // expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                width: double.infinity,
                color: Color(0xffF4F6F6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: BackButton()),
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
                  ],
                ),
              ),
            ),
          );
        });
  }
}
