import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const List<String> ingredients = [
  'Pork',
  'Beef',
  'Fish',
  'Bok Choi',
  'Lettuce',
  'Cabbage',
  'Basil',
  'Spinach',
  'Garlic',
  'Egg'
];

class Ingredients extends StatefulWidget {
  static const routeName = '/';

  const Ingredients({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IngredientsState();
  }
}

void doNothing(BuildContext context) {}

class _IngredientsState extends State<Ingredients> {
  List<int> text = [1, 2, 3, 4];
  bool isSwitched = false;
  List<String> _ingredientsList = [];
  List<int> _ingredientsAmountList = [];
  String _selectedIngredient = '';
  int _selectedIngredientAmount = 0;

  List<Widget> getPickerItems(List<String> list) {
    List<Widget> items = [];
    for (var i in list) {
      items.add(Text(i));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Column(children: <Widget>[
                Container(height: 20),
                Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                    ),
                    CupertinoSwitch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    Container(
                      width: 270,
                    ),
                    IconButton(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                _ingredientsList
                                                    .add(_selectedIngredient);
                                                _ingredientsAmountList.add(
                                                    (_selectedIngredientAmount +
                                                            1) *
                                                        5);
                                              });
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                              child: CupertinoPicker(
                                            itemExtent: 32,
                                            backgroundColor: Colors.white,
                                            onSelectedItemChanged: (value) {
                                              setState(() {
                                                _selectedIngredient =
                                                    ingredients[value];
                                              });
                                            },
                                            children:
                                                getPickerItems(ingredients),
                                          )),
                                          Expanded(
                                            child: CupertinoPicker(
                                              itemExtent: 32,
                                              backgroundColor: Colors.white,
                                              onSelectedItemChanged: (value) {
                                                setState(() {
                                                  _selectedIngredientAmount =
                                                      value;
                                                });
                                              },
                                              children:
                                                  new List<Widget>.generate(20,
                                                      (int index) {
                                                int amount = (index + 1) * 5;
                                                return new Center(
                                                  child: new Text('${amount}'),
                                                );
                                              }),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                Container(height: 20)
              ]),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: MediaQuery.of(context).size.height,
                  child: _ingredientsList.length != 0
                      ? ListView.builder(
                          itemCount: _ingredientsList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: MediaQuery.of(context).size.width * 0.3,
                                child: Slidable(
                                    key: const ValueKey(0),

                                    // The end action pane is the one at the right or the bottom side.
                                    endActionPane: ActionPane(
                                      motion: DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          // An action can be bigger than the others.
                                          onPressed: doNothing,
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          label: 'Edit',
                                        ),
                                        SlidableAction(
                                          onPressed: doNothing,
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      child: Card(
                                        color: Colors.white,
                                        child: Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image(
                                              image: AssetImage(
                                                  'lib/assets/fridge/egg.jpeg'),
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                            ),
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: _ingredientsList[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                strutStyle: StrutStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Flexible(
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    text:
                                                        _ingredientsAmountList[
                                                                index]
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  strutStyle: StrutStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                      ),
                                    )));
                          },
                        )
                      : Text('You don\'t have any ingredients yet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
