import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'recipe_step_2.dart';

class RecipeStep1 extends StatefulWidget {
  @override
  _RecipeStep1State createState() => _RecipeStep1State();
}

const List<String> method = ['Bake', 'Boil', 'Fry', 'Multiple'];

const List<String> type = ['Savory', 'Dessert'];

const List<String> kitchenware = ['Pan', 'Microwave', 'Oven'];

const List<String> ingredients = [
  'Pork',
  'Beef',
  'Fish',
  'Bok Choi',
  'Lettuce',
  'Cabbage',
  'Basil',
  'Spinach',
  'Garlic'
];

class _RecipeStep1State extends State<RecipeStep1> {
  int _kitchenwareCount = 1;
  int _ingredientsCount = 1;
  void addNewKitchenware() {
    setState(() {
      _kitchenwareCount = _kitchenwareCount + 1;
      _selectedKitchenware.add('Select Kitchenware');
    });
  }

  void addNewIngredients() {
    setState(() {
      _ingredientsCount = _ingredientsCount + 1;
      _selectedIngredients.add('Select Ingredient');
      _selectedIngredientsCount.add(0);
    });
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
  List<String> _selectedKitchenware = ['Select Kitchenware'];
  List<String> _selectedIngredients = ['Select Ingredient'];
  List<int> _selectedIngredientsCount = [0];
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
                            color: Colors.white, shape: BoxShape.circle),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '2',
                              )
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Recipe')),
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
                            alignment: Alignment.centerLeft,
                            child: Text('Description')),
                        SizedBox(height: 10),
                        TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                hintText: 'Description',
                                fillColor: Colors.white)),
                        Row(children: <Widget>[
                          CupertinoButton(
                              child: Text('Select time:'),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          height: 200,
                                          color: Colors.white,
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: CupertinoPicker(
                                                      scrollController:
                                                          new FixedExtentScrollController(
                                                        initialItem:
                                                            _selectedHour,
                                                      ),
                                                      itemExtent: 32.0,
                                                      backgroundColor:
                                                          Colors.white,
                                                      onSelectedItemChanged:
                                                          (int index) {
                                                        setState(() {
                                                          _selectedHour = index;
                                                        });
                                                      },
                                                      children: new List<
                                                              Widget>.generate(
                                                          24, (int index) {
                                                        return new Center(
                                                          child: new Text(
                                                              '${index}'),
                                                        );
                                                      })),
                                                ),
                                                Expanded(
                                                  child: CupertinoPicker(
                                                      scrollController:
                                                          new FixedExtentScrollController(
                                                        initialItem:
                                                            _selectedMinute,
                                                      ),
                                                      itemExtent: 32.0,
                                                      backgroundColor:
                                                          Colors.white,
                                                      onSelectedItemChanged:
                                                          (int index) {
                                                        setState(() {
                                                          _selectedMinute =
                                                              index;
                                                        });
                                                      },
                                                      children: new List<
                                                              Widget>.generate(
                                                          60, (int index) {
                                                        return new Center(
                                                          child: new Text(
                                                              '${index}'),
                                                        );
                                                      })),
                                                ),
                                              ]));
                                    });
                              }),
                          Text(
                            '${_selectedHour}:${_selectedMinute}',
                            style: TextStyle(fontSize: 18.0),
                          )
                        ]),
                        Row(children: <Widget>[
                          CupertinoButton(
                              child: Text('Select method:'),
                              onPressed: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) => Container(
                                          width: double.infinity,
                                          height: 250,
                                          child: CupertinoPicker(
                                            backgroundColor: Colors.white,
                                            itemExtent: 30,
                                            children: getPickerItems(method),
                                            onSelectedItemChanged: (value) {
                                              setState(() {
                                                _selectedMethod = method[value];
                                              });
                                            },
                                          ),
                                        ));
                              }),
                          Text(
                            '${_selectedMethod}',
                            style: TextStyle(fontSize: 18.0),
                          )
                        ]),
                        Row(children: <Widget>[
                          CupertinoButton(
                              child: Text('Select type:'),
                              onPressed: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) => Container(
                                          width: double.infinity,
                                          height: 250,
                                          child: CupertinoPicker(
                                            backgroundColor: Colors.white,
                                            itemExtent: 30,
                                            children: getPickerItems(type),
                                            onSelectedItemChanged: (value) {
                                              setState(() {
                                                _selectedType = type[value];
                                              });
                                            },
                                          ),
                                        ));
                              }),
                          Text(
                            '${_selectedType}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ]),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Kitchenware')),
                        Column(children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _kitchenwareCount,
                            itemBuilder: (BuildContext context, int index) {
                              String currentKitchenWare =
                                  _selectedKitchenware[index];
                              return Column(children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => Container(
                                                width: double.infinity,
                                                height: 250,
                                                child: CupertinoPicker(
                                                  backgroundColor: Colors.white,
                                                  itemExtent: 30,
                                                  children: getPickerItems(
                                                      kitchenware),
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    setState(() {
                                                      _selectedKitchenware[
                                                              index] =
                                                          kitchenware[value];
                                                    });
                                                  },
                                                ),
                                              ));
                                    },
                                    child: Text(
                                      '$currentKitchenWare',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ]);
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                addNewKitchenware();
                              },
                              icon: Icon(Icons.add))
                        ]),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Ingredients')),
                        Column(children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _ingredientsCount,
                            itemBuilder: (BuildContext context, int index) {
                              String currentIngredients =
                                  _selectedIngredients[index];
                              int currentIngredientsCount =
                                  _selectedIngredientsCount[index];
                              return Column(children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => Container(
                                              height: 200,
                                              color: Colors.white,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                      child: CupertinoPicker(
                                                    scrollController:
                                                        new FixedExtentScrollController(),
                                                    itemExtent: 32,
                                                    backgroundColor:
                                                        Colors.white,
                                                    onSelectedItemChanged:
                                                        (value) {
                                                      setState(() {
                                                        _selectedIngredients[
                                                                index] =
                                                            ingredients[value];
                                                      });
                                                    },
                                                    children: getPickerItems(
                                                        ingredients),
                                                  )),
                                                  Expanded(
                                                      child: CupertinoPicker(
                                                          itemExtent: 32,
                                                          backgroundColor:
                                                              Colors.white,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            setState(() {
                                                              _selectedIngredientsCount[
                                                                      index] =
                                                                  value;
                                                            });
                                                          },
                                                          children: new List<
                                                                  Widget>.generate(
                                                              500, (int index) {
                                                            return new Center(
                                                              child: new Text(
                                                                  '${index}'),
                                                            );
                                                          })))
                                                ],
                                              )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '$currentIngredients',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '$currentIngredientsCount',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))
                              ]);
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                addNewIngredients();
                              },
                              icon: Icon(Icons.add))
                        ]),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Nutritions facts')),
                        SizedBox(height: 10),
                        TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                hintText: 'Calories',
                                fillColor: Colors.white)),
                        SizedBox(height: 10),
                        TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                hintText: 'Protein',
                                fillColor: Colors.white)),
                        SizedBox(height: 10),
                        TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                hintText: 'Carbohydrates',
                                fillColor: Colors.white)),
                        SizedBox(height: 10),
                        TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                filled: true,
                                hintText: 'Fat',
                                fillColor: Colors.white)),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: RecipeStep2(),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Next'),
                                      Icon(Icons.arrow_forward_ios),
                                      SizedBox(width: 10)
                                    ])))
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
