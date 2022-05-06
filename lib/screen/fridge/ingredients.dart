import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/models/userIngred_model.dart';
import 'package:hewa/utilities/db_helper.dart';
import 'package:hewa/utilities/ingred_helper.dart';
import 'package:hewa/utilities/userIngred_helper.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/models/ingred_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:search_choices/search_choices.dart';

List<String> ingredients = [];
List<IngredModel> ingredModel = [];
List<UserIngredModel> userIngredModel = [];
List<String> units = ['-', 'g', 'kg', 'tbsp', 'cup', 'ml'];

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
  bool flagAdd = false;
  bool flagEdit = false;
  bool flagRemove = false;
  List<String> _ingredientsList = [];
  List<String> _unitList = [];
  List<double> _ingredientsAmountList = [];
  String _selectedIngredient = '';
  String _selectedUnit = '';
  double _selectedIngredientAmount = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? userModel;
  TextEditingController editAmountController = TextEditingController();

  List<Widget> getPickerItems(List<String> list) {
    List<Widget> items = [];
    for (var i in list) {
      items.add(Text(i));
    }
    return items;
  }

  Future<Null> getSwitch() async {
    var object =
        await UserHelper().readDataFromSQLiteWhereId(_auth.currentUser!.uid);
    if (object.length != 0) {
      for (var model in object) {
        userModel = model;
        userModel!.uid = model.uid;
        userModel!.username = model.username;
        // print(model.ingredients);
        if (model.ingredients == 1) {
          setState(() {
            isSwitched = true;
          });
        }
      }
    }
  }

  Future<Null> readSQLite() async {
    var object = await IngredHelper().readlDataFromSQLite();
    print('object length ==> ${object.length}');
    ingredients.clear();
    for (var model in object) {
      // print(model);
      ingredModel.add(model);
      ingredients.add(model.name!);
    }
  }

  Future<Null> getUserIngredients() async {
    var object = await UserIngredHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    print('user ingredient length ==> ${object.length}');
    userIngredModel.clear();
    for (var model in object) {
      userIngredModel.add(model);
      if (ingredients.contains(ingredModel
          .where((element) => element.id == model.ingredientId)
          .first
          .name)) {
        ingredients.remove(ingredModel
            .where((element) => element.id == model.ingredientId)
            .first
            .name);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // IngredHelper().deleteAlldata();
    // IngredHelper().initInsertToSQLite();
    readSQLite();
    getSwitch();
    getUserIngredients();
  }

  int _widgetId = 1;

  Widget _addIngredient() {
    flagAdd = false;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text('Add new ingredient'),
        content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
          Center(),
          _renderWidget(),
          _widgetId == 1
              ? TextButton(
                  onPressed: () {
                    print('$_selectedIngredient');
                    setState(() {
                      _updateWidget();
                    });
                  },
                  child: Text('Next'))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                      TextButton(
                          onPressed: () {
                            print('$_selectedIngredient');
                            setState(() {
                              _updateWidget();
                            });
                          },
                          child: Text('Back')),
                      TextButton(
                        onPressed: () {
                          print(_selectedIngredient);
                          print(_selectedIngredientAmount);
                          print(_selectedUnit);
                          flagAdd = true;
                          Navigator.pop(context);
                        },
                        child: Text('Add'),
                      )
                    ]),
        ])),
      );
    });
  }

  Widget _editIngredient(int index) {
    flagEdit = false;
    flagRemove = false;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text('Edit ingredient'),
        content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
          Center(),
          renderEditWidget(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      print('deleted');
                      flagRemove = true;
                      Navigator.pop(context);
                    },
                    child: Text('Delete')),
                TextButton(
                  onPressed: () {
                    print(_selectedUnit);
                    print(editAmountController.text);
                    flagEdit = true;
                    Navigator.pop(context);
                  },
                  child: Text('Done'),
                )
              ])
        ])),
      );
    });
  }

  Widget renderAutoComplete() {
    return StatefulBuilder(builder: (context, setState) {
      return Autocomplete<String>(onSelected: (String selection) {
        _selectedIngredient = selection;
      }, optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable.empty();
        }
        return ingredients.where(
          (element) {
            return element
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          },
        );
      });
    });
  }

  Widget renderEditWidget() {
    var ingredient = ingredModel
        .where((element) => element.name == _selectedIngredient)
        .toList();
    final ref = FirebaseStorage.instance
        .ref()
        .child('ingredients')
        .child(ingredient[0].image.toString() + '.jpg');
    var url = ref.getDownloadURL();
    return StatefulBuilder(builder: (context, setState) {
      return FutureBuilder(
          future: url,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      snapshot.data!,
                    )),
                Center(
                    child: ActionChip(
                  label: Text(_selectedIngredient),
                  onPressed: () {},
                )),
                TextField(
                  controller: editAmountController,
                  decoration: InputDecoration(hintText: 'Amount'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                CupertinoButton(
                    child: Text(
                        _selectedUnit != '' ? _selectedUnit : 'Select unit'),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => Column(
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
                                          child: Text('Close'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 320.0,
                                    color: Color(0xfff7f7f7),
                                    child: CupertinoPicker(
                                      itemExtent: 32,
                                      backgroundColor: Colors.white,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedUnit = units[index];
                                        });
                                      },
                                      children: getPickerItems(units),
                                    ),
                                  )
                                ],
                              ));
                    })
              ];
            } else {
              children = <Widget>[CircularProgressIndicator()];
            }
            return Column(
              children: children,
            );
          });
    });
  }

  Widget renderIngredientChip() {
    var ingredient = ingredModel
        .where((element) => element.name == _selectedIngredient)
        .toList();
    final ref = FirebaseStorage.instance
        .ref()
        .child('ingredients')
        .child(ingredient[0].image.toString() + '.jpg');
    var url = ref.getDownloadURL();
    return StatefulBuilder(builder: (context, setState) {
      return FutureBuilder(
          future: url,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      snapshot.data!,
                    )),
                Center(
                    child: ActionChip(
                  label: Text(_selectedIngredient),
                  onPressed: () {},
                )),
                TextField(
                  onChanged: (value) {
                    _selectedIngredientAmount = double.parse(value);
                  },
                  decoration: InputDecoration(hintText: 'Amount'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                CupertinoButton(
                    child: Text(
                        _selectedUnit != '' ? _selectedUnit : 'Select unit'),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => Column(
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
                                          child: Text('Close'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 5.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 320.0,
                                    color: Color(0xfff7f7f7),
                                    child: CupertinoPicker(
                                      itemExtent: 32,
                                      backgroundColor: Colors.white,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedUnit = units[index];
                                        });
                                      },
                                      children: getPickerItems(units),
                                    ),
                                  )
                                ],
                              ));
                    })
              ];
            } else {
              children = <Widget>[CircularProgressIndicator()];
            }
            return Column(
              children: children,
            );
          });
    });
  }

  void _updateWidget() {
    setState(() {
      _widgetId = _widgetId == 1 ? 2 : 1;
    });
  }

  Widget _renderWidget() {
    return _widgetId == 1 ? renderAutoComplete() : renderIngredientChip();
  }

  buildAddWidget() {
    showDialog(
            context: context,
            builder: (BuildContext context) => _addIngredient())
        .then((value) => setState(() {
              if (flagAdd == true) {
                ingredients.remove(_selectedIngredient);
                _ingredientsList.add(_selectedIngredient);
                _ingredientsAmountList.add((_selectedIngredientAmount));
                _unitList.add(_selectedUnit);
                UserIngredModel userIngred = UserIngredModel(
                    uid: _auth.currentUser!.uid,
                    ingredientId: ingredModel
                        .where((element) => element.name == _selectedIngredient)
                        .first
                        .id,
                    amount: _selectedIngredientAmount,
                    unit: _selectedUnit == '-' ? '' : _selectedUnit);
                UserIngredHelper().insertDataToSQLite(userIngred);
                userIngredModel.insert(0, userIngred);
              }
            }));
  }

  buildEditWidget(int index) {
    setState(() {
      editAmountController.text = userIngredModel[index].amount!.toString();
    });
    showDialog(
            context: context,
            builder: (BuildContext context) => _editIngredient(index))
        .then((value) => setState(() {
              if (flagEdit == true) {
                userIngredModel[index].unit = _selectedUnit;
                userIngredModel[index].amount =
                    double.parse(editAmountController.text);
                UserIngredHelper().updateDataToSQLite(userIngredModel[index]);
              }
              if (flagRemove == true) {
                UserIngredHelper().deleteDataWhere(_auth.currentUser!.uid,
                    userIngredModel[index].ingredientId.toString());
                setState(() {
                  userIngredModel.removeAt(index);
                });
              }
            }));
  }

  Widget buildmealBtn(int index) {
    var ingredient = ingredModel
        .where((element) => element.id == userIngredModel[index].ingredientId)
        .toList();
    final ref = FirebaseStorage.instance
        .ref()
        .child('ingredients')
        .child(ingredient[0].image.toString() + '.jpg');
    var url = ref.getDownloadURL();
    String format(double n) {
      return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
    }

    String amount = format(userIngredModel[index].amount!);

    return FutureBuilder<String>(
      future: url,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Stack(children: <Widget>[
              GestureDetector(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(snapshot.data!),
                ),
                onTap: () {
                  _selectedUnit = userIngredModel[index].unit!;
                  _selectedIngredient = ingredModel
                      .where((element) =>
                          element.id == userIngredModel[index].ingredientId)
                      .first
                      .name!;
                  flagEdit = false;
                  flagRemove = false;
                  buildEditWidget(index);
                },
              )
            ]),
            Text(
              ingredient[0].name!,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              double.parse(amount) == 0
                  ? ''
                  : amount + ' ' + userIngredModel[index].unit!,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            )
          ];
        } else {
          children = <Widget>[CircularProgressIndicator()];
        }
        return Column(children: children);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 10,
                      ),
                      CupertinoSwitch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            var ing;
                            if (isSwitched == true) {
                              ing = 1;
                            } else {
                              ing = 0;
                            }
                            userModel!.ingredients = ing;
                            UserHelper().updateDataToSQLite(userModel!);
                          });
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedIngredient = ingredients[0];
                              _selectedIngredientAmount = 0;
                              _selectedUnit = '';
                              _widgetId = 1;
                            });
                            print(_ingredientsAmountList);
                            buildAddWidget();
                            // showCupertinoModalPopup(
                            //     context: context,
                            //     builder: (context) {
                            //       return Column(
                            //         mainAxisAlignment: MainAxisAlignment.end,
                            //         children: <Widget>[
                            //           Container(
                            //             decoration: BoxDecoration(
                            //               color: Color(0xffffffff),
                            //               border: Border(
                            //                 bottom: BorderSide(
                            //                   color: Color(0xff999999),
                            //                   width: 0.0,
                            //                 ),
                            //               ),
                            //             ),
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: <Widget>[
                            //                 CupertinoButton(
                            //                     child: Text('Cancel'),
                            //                     onPressed: () {
                            //                       Navigator.pop(context);
                            //                     }),
                            //                 CupertinoButton(
                            //                   child: Text('Add'),
                            //                   onPressed: () {
                            //                     setState(() {
                            //                       ingredients.remove(
                            //                           _selectedIngredient);
                            //                       _ingredientsList
                            //                           .add(_selectedIngredient);
                            //                       _ingredientsAmountList.add(
                            //                           (_selectedIngredientAmount));
                            //                       _unitList.add(_selectedUnit);
                            //                     });
                            //                     Navigator.pop(context);
                            //                   },
                            //                   padding: const EdgeInsets.symmetric(
                            //                     horizontal: 16.0,
                            //                     vertical: 5.0,
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //           Container(
                            //             height: 320,
                            //             color: Colors.white,
                            //             child: Row(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: <Widget>[
                            //                 Expanded(
                            //                     child: CupertinoPicker(
                            //                   itemExtent: 32,
                            //                   backgroundColor: Colors.white,
                            //                   onSelectedItemChanged: (value) {
                            //                     setState(() {
                            //                       _selectedIngredient =
                            //                           ingredients[value];
                            //                     });
                            //                   },
                            //                   children:
                            //                       getPickerItems(ingredients),
                            //                 )),
                            //                 Expanded(
                            //                   child: CupertinoPicker(
                            //                     itemExtent: 32,
                            //                     backgroundColor: Colors.white,
                            //                     onSelectedItemChanged: (value) {
                            //                       setState(() {
                            //                         _selectedIngredientAmount =
                            //                             value;
                            //                       });
                            //                     },
                            //                     children:
                            //                         new List<Widget>.generate(
                            //                             1000, (int index) {
                            //                       var amount;
                            //                       if (index > 0) {
                            //                         amount = index;
                            //                       } else {
                            //                         amount = '-';
                            //                       }
                            //                       return new Center(
                            //                         child: new Text('${amount}'),
                            //                       );
                            //                     }),
                            //                   ),
                            //                 ),
                            //                 Expanded(
                            //                   child: CupertinoPicker(
                            //                     itemExtent: 32,
                            //                     backgroundColor: Colors.white,
                            //                     onSelectedItemChanged: (value) {
                            //                       setState(() {
                            //                         _selectedUnit = units[value];
                            //                       });
                            //                     },
                            //                     children: getPickerItems(units),
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           )
                            //         ],
                            //       );
                            //     });
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                ),
                Container(height: 20)
              ]),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: MediaQuery.of(context).size.height,
                  child: userIngredModel.length != 0
                      ? MediaQuery.removePadding(
                          context: context,
                          child: GridView.builder(
                              padding:
                                  EdgeInsets.only(top: 30, left: 10, right: 10),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300.0,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 20.0,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: userIngredModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                return buildmealBtn(index);
                              }))
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
