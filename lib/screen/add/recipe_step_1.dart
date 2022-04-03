import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hewa/models/Recipe_model.dart';
import 'package:hewa/models/menu_model.dart';
import 'package:hewa/models/reImageStep_model.dart';
import 'package:hewa/models/reKitchenware_model.dart';
import 'package:hewa/models/reStep_model.dart';
import 'package:hewa/utilities/menu.helper.dart';
import 'package:hewa/utilities/reImageStep_helper.dart';
import 'package:hewa/utilities/reIngred_helper.dart';
import 'package:hewa/utilities/reKitchenware_helper.dart';
import 'package:hewa/utilities/reStep_helper.dart';
import 'package:hewa/utilities/recipe_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;
import 'dart:io' as io;
import '../../config/palette.dart';
import 'recipe_step_2.dart';
import 'package:hewa/utilities/ingred_helper.dart';
import 'package:hewa/models/kitch_model.dart';
import 'package:hewa/utilities/kitch_helper.dart';
import 'package:hewa/models/ingred_model.dart';
import 'package:hewa/utilities/reIngred_helper.dart';
import 'package:hewa/models/reIngred_model.dart';
import 'package:hewa/models/step_model.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hewa/screen/launcher.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:hewa/screen/add/DynamicWidget.dart';

class RecipeStep1 extends StatefulWidget {

  MenuModel menuModel;

  RecipeStep1(this.menuModel);


  @override
  _RecipeStep1State createState() => _RecipeStep1State(menuModel);
}

const List<String> method = ['Bake', 'Boil', 'Fry', 'Multiple'];

const List<String> type = ['Savory', 'Dessert'];

List<String> kitchenware = [];
List<KitchenwareModel> kitchenwareModel = [];

List<String> ingredients = [];
List<ReIngredModel> reingredModel = [];
List<ReStepModel> reStepModel = [];
List<IngredModel> ingredModel = [];
List<String> units = ['-', 'g', 'kg', 'ml', 'l', 'bottles'];

int _selectedMinute = 0;
var minute = 0;

class _RecipeStep1State extends State<RecipeStep1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = new GlobalKey<FormState>();

  final recipeController = TextEditingController();
  final desc1Controller = TextEditingController();
  final calController = TextEditingController();
  final proteinController = TextEditingController();
  final carboController = TextEditingController();
  final fatController = TextEditingController();
  final desc2Controller = TextEditingController();
  final nameKitcController = TextEditingController();
  final ingreController = TextEditingController();
  final descstepController = TextEditingController();
  final _amountController = TextEditingController();


  RecipeHelper? recipeHelper;
  RecipeModel? recipeModel;

  StepModel? stepModel;

  ReStepModel? reStepModel;
  ReStepHelper? reStepHelper;

  ReKitchenwareModel? reKitchenwareModel;
  ReKitchenwareHelper? reKitchenwareHelper;


  ReIngredModel? reIngredModel;

  MenuHelper? menuHelper;
  MenuModel menuModel;
  _RecipeStep1State(this.menuModel);


  int _kitchenwareCount = 1;
  int _ingredientsCount = 1;


  createRecipes() async {
    String recipemenu = recipeController.text;
    String desc1menu = desc1Controller.text;
    double calmenu = double.parse(calController.text);
    double proteinmenu = double.parse(proteinController.text);
    double carbomenu = double.parse(carboController.text);
    double fatmenu = double.parse(fatController.text);
    // String desc2menu = desc2Controller.text;

     recipeModel = RecipeModel(
        recipeUid: _auth.currentUser!.uid,
        recipeName: recipemenu,
        description: desc1menu,
        menuId: menuModel.id,
        timeMinute: _selectedHour * 60 + _selectedMinute,
        method: _selectedMethod,
        type: _selectedType,
        calories: calmenu,
        protein: proteinmenu,
        carb: carbomenu,
        fat: fatmenu);
    int resultrec;
    resultrec = await RecipeHelper().insert(recipeModel!);

    if (resultrec != 0) {
      print('Success');
    } else {
      print('Failed');
    }
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => RecipeStep1()));
  }

  createKits() async {

    print(kitchenwareModel.length);
    
    var object = await RecipeHelper().readDataFromSQLiteRecipe(recipeModel!);
    print(object.first.id);


      for (var i = 0; i < _selectedKitchenware.length; i++) {
        ReKitchenwareModel reKitchenwareModel = ReKitchenwareModel(
            recipeId: object.first.id.toString(),
            kitchenwareId: kitchenwareModel
                .where((element) => element.nameKitc == _selectedKitchenware[i])
                .first
                .id);
        int resultkitc;
        resultkitc = await ReKitchenwareHelper().insert(reKitchenwareModel);


        if (resultkitc != 0) {
          print('Success');
        } else {
          print('Failed');
        }
      }
  }

  createIngres() async {
    double _amount = double.parse(_amountController.text);

    for (var i = 0; i < _selectedIngredients.length; i++) {
      ReIngredModel reIngredModel = ReIngredModel(
          recipeId: null,
          ingredientId: ingredModel
              .where((element) => element.name == _selectedIngredients[i])
              .first
              .id,
          amount: _amount,
          unit: _selectedIngredientsUnit[i]);
      int resultIngre;
      resultIngre = await ReIngredHelper().insert(reIngredModel);

      if (resultIngre != 0) {
        print('Success');
      } else {
        print('Failed');
      }
    }
  }

  bool flagAdd = false;

  // String _Ingredient = '';
  // String _Unit = '';
  // double _IngredientCount = 0;

  String _selectedIngredient = '';
  String _selectedUnit = '';
  double _selectedIngredientAmount = 0;

  int _widgetId = 1;
  bool flagEdit = false;
  bool flagRemove = false;
  final editAmountController = TextEditingController();


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
                        setState(() {
                          print(_selectedIngredient);
                          print(_selectedIngredientAmount);
                          print(_selectedUnit);
                          flagAdd = true;

                          ingredients.remove(_selectedIngredient);
                          _selectedIngredients.add(_selectedIngredient);
                          _selectedIngredientsCount.add((_selectedIngredientAmount));
                          _selectedIngredientsUnit.add(_selectedUnit);
                        });

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
        .then((value) => setState(() async {
      if (flagAdd == true) {
        // ingredients.remove(_selectedIngredient);
        // _selectedIngredients.add(_selectedIngredient);
        // _selectedIngredientsCount.add((_selectedIngredientAmount));
        // _selectedIngredientsUnit.add(_selectedUnit);

        var object = await RecipeHelper().readDataFromSQLiteRecipe(recipeModel!);
        print(object.first.id);

        ReIngredModel reIngred = ReIngredModel(
            ingredientId: ingredModel
                .where((element) => element.name == _selectedIngredient)
                .first
                .id,
            amount: _selectedIngredientAmount,
            unit: _selectedUnit == '-' ? '' : _selectedUnit,
            recipeId: object.first.id);

        int resultIngred;
        resultIngred = await ReIngredHelper().insert(reIngred);

        setState(() {
          reingredModel.add(reIngred);
        });


        if (resultIngred != 0) {
          print('Success');
        } else {
          print('Failed');
        }

      }
    }));
  }

  buildEditWidget(int index) {
    setState(() {
      editAmountController.text = reingredModel[index].amount!.toString();
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => _editIngredient(index))
        .then((value) => setState(() {
      if (flagEdit == true) {
        reingredModel[index].unit = _selectedUnit;
        reingredModel[index].amount =
            double.parse(editAmountController.text);

        setState(() {
          _selectedIngredientsCount[index] = double.parse(editAmountController.text);
          _selectedIngredientsUnit[index] = _selectedUnit;
        });


        ReIngredHelper().updateDataToSQLite(reingredModel[index]);
      }
      if (flagRemove == true) {
        ReIngredHelper().deleteDataWhere(_auth.currentUser!.uid,
            reingredModel[index].ingredientId.toString());
        setState(() {
          reingredModel.removeAt(index);
        });
      }
    }));
  }

  List<TextEditingController> _descStepControllers = [];
  List<TextEditingController> _timeStepControllers = [];

  buildRestep(int index) {
    return Container(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Step ${index+1}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          SizedBox(height: 10),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          SizedBox(height: 20),
          TextField(
              controller: _descStepControllers[index],
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  hintText: 'Description',
                  fillColor: Colors.white)),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              getImage(index);
            },
            child: _Stepimage[index] != null
                ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.white,
                  child: Image.file(_Stepimage[index]),
                ))
                : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.white,
                  child: Icon(Icons.add),
                )),
          ),
          SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Time',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 20),
              Container(
                width: 100,
                child: TextField(
                  controller: _timeStepControllers[index],
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '-',
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text('Minute',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),

          SizedBox(height: 60),
        ],
      ),
    );
  }

  addReStep() async {

    var object = await RecipeHelper().readDataFromSQLiteRecipe(recipeModel!);
    print(object.first.id);

    for( int i = 0; i < _count;i++) {


      String descStep = _descStepControllers[i].value.text;
      int? timeStep = int.tryParse(_timeStepControllers[i].value.text);

      ReStepModel reStepModel = ReStepModel(
          recipeId: object.first.id.toString(),
          step: i + 1,
          description: descStep,
          minute: timeStep);

      int result;
      result = await ReStepHelper().insert(reStepModel);

      if (result != 0) {
        setState(() {
          steps.add(reStepModel);
        });
        print(descStep);
        print(timeStep);
        print('Success');
      } else {
        print('Failed');
      }
    }
    uploadImageToFirebase(context);
  }


  List<ReStepModel> steps = [];
  List<ReImageStepModel> reimages = [];

  Future uploadImageToFirebase(BuildContext context) async {
    for (int i=0; i < _count; i++) {
      if(_Stepimage[i] != null)  {
        String fileName = p.basename(_Stepimage[i].path);
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('steps')
            .child('/$fileName');

        final metadata = firebase_storage.SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {'picked-file-path': fileName});
        firebase_storage.UploadTask uploadTask;
        uploadTask = ref.putFile(io.File(_Stepimage[i].path), metadata);

        var object = await RecipeHelper().readDataFromSQLiteRecipe(recipeModel!);
        print(object.first.id);

        var objects = await ReStepHelper().readDataFromSQLiteRestep(steps[i]);
        ReStepModel targetReStep = objects.first;
        ReImageStepModel reImageStepModel = ReImageStepModel(
            recipeId: object.first.id,
            stepId: targetReStep.id,
            name: fileName);

        ReImageStepHelper().insertDataToSQLite(reImageStepModel);

        firebase_storage.UploadTask task = await Future.value(uploadTask);
        Future.value(uploadTask)
            .then((value) => {print("Upload file path ${value.ref.fullPath}")})
            .onError((error, stackTrace) =>
        {print("Upload file path error ${error.toString()} ")});

        print(fileName);
      }
    }
  }


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
      _selectedIngredientsUnit.add('Unit');
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
  List<String> _selectedIngredients = [];
  List<String> _selectedIngredientsUnit = [];
  List<double> _selectedIngredientsCount = [];

  Future<Null> readSQLite() async {
    var object = await IngredHelper().readlDataFromSQLite();
    print('object length ==> ${object.length}');
    ingredients.clear();
    for (var model in object) {
      print(model);
      ingredModel.add(model);
      ingredients.add(model.name!);
    }
  }

  Future<Null> readSQLiteMenu() async {
    var object = await MenuHelper().readDataFromSQLiteMenu(menuModel);
    print('object length ==> ${object.length}');
    setState(() {
      menuModel = object.first;
      print(object.first.id);
    });
  }

  Future<Null> readSQLiteRecipe() async {
    var object = await RecipeHelper().readDataFromSQLiteRecipe(recipeModel!);
    print('object length ==> ${object.length}');
    setState(() {
      recipeModel = object.first;
      print(object.first.id);
    });
  }



  Future<Null> readSQLiteKitch() async {
    var object = await KitchHelper().readlDataFromSQLite();
    print('object length ==> ${object.length}');
    kitchenware.clear();
    for (var model in object) {
      print(model);
      kitchenwareModel.add(model);
      kitchenware.add(model.nameKitc!);
    }
  }

  void getKitchenware() {
    KitchHelper().readlDataFromSQLite().then((value) {
      if (value.length != 0) {
        for (var model in value) {
          kitchenware.add(model.nameKitc!);
        }
      }
    });
    setState(() {});
  }


  static const color = const Color(0xffffab91);

  int _count = 0;

  void _addNewStepColumn() {
    setState(() {
      _count = _count + 1;
      print(_count);
    });
  }

  List<dynamic> _Stepimage = [];

  File? _image = null;
  final picker = ImagePicker();

  Future getImage(int index) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile);
        _Stepimage[index] = File(pickedFile.path);
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

  Widget builddoneBtn() {
    return RaisedButton(
      // onPressed: () {},
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Launcher()));
      },
      textColor: Colors.white,
      color: Colors.black,
      disabledColor: Colors.black,
      child: Text("DONE"),
      // onPressed: () {},
      padding: EdgeInsets.all(10),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  Widget _getIngredients() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Icon(MdiIcons.pigVariantOutline),
          Row(children: <Widget>[
            Text(
              '$_selectedIngredients',
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              // '$amountController',
              (_ingr * _n).toStringAsFixed(0),
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '$_selectedIngredientsUnit',
              style: TextStyle(fontSize: 10),
            )
          ]),
          // Text(
          //   'คุณมีไม่พอ',
          //   style: TextStyle(color: Colors.red, fontSize: 10),
          // )
        ],
      ),
    );
  }

  Widget _getIngredientsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _getIngredients(),
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
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 9,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.all(15),
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
              margin: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 20,
                  ),
                  Flexible(
                    // child: RichText(
                    //   overflow: TextOverflow.visible,
                    //   text: TextSpan(
                    //     text:
                    //     'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    //   strutStyle: StrutStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    child: Text('${desc2Controller.text}'),
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
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
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
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: AssetImage('lib/assets/menu_detail/recipe.png'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  buildIngredChip(int index) {
    return ActionChip(label: Text(_selectedIngredients[index]), onPressed: () {});
  }

  List<DynamicWidget> listDynamic = [];

  addDynamic(int index) {
    listDynamic.add(DynamicWidget(index, recipeModel!));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getKitchenware();
    readSQLite();
    readSQLiteKitch();
    readSQLiteMenu();
    readSQLiteRecipe();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: color,
            toolbarHeight: 60,
            title: Text('',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ),
        ],
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: color,
          )),
          child: Stepper(
            type: StepperType.horizontal,
            controlsBuilder: (context, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // if (_index != 0)
                  _index == 0
                      ? RaisedButton(
                          onPressed: () {
                            if (_index <= 1) {
                              setState(() {
                                _index += 1;
                              });
                            }
                            createRecipes();
                          },
                          textColor: Colors.white,
                          color: Colors.black,
                          disabledColor: Colors.black,
                          child: Text("NEXT"),
                          // onPressed: () {},
                          padding: EdgeInsets.all(10),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        )
                  : _index == 1
                  ? Container(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (_index > 0) {
                              setState(() {
                                _index -= 1;
                              });
                            }
                          },
                          child: const Text('BACK'),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_index <= 1) {
                              setState(() {
                                _index += 1;
                              });
                            }
                            createKits();
                          },
                          textColor: Colors.white,
                          color: Colors.black,
                          disabledColor: Colors.black,
                          child: Text("NEXT"),
                          // onPressed: () {},
                          padding: EdgeInsets.all(10),
                          shape: new RoundedRectangleBorder(
                            borderRadius:
                            new BorderRadius.circular(30.0),
                          ),
                        )
                      ],
                    ),
                  )
                      : _index == 2
                          ? Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (_index > 0) {
                                        setState(() {
                                          _index -= 1;
                                        });
                                      }
                                    },
                                    child: const Text('BACK'),
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      if (_index <= 2) {
                                        setState(() {
                                          _index += 1;
                                        });
                                      }
                                      // DynamicWidget(_count, recipeModel!).method();
                                      addReStep();
                                      // submitStep();
                                    },
                                    textColor: Colors.white,
                                    color: Colors.black,
                                    disabledColor: Colors.black,
                                    child: Text("NEXT"),
                                    // onPressed: () {},
                                    padding: EdgeInsets.all(10),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : _index >= 3
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          if (_index > 0) {
                                            setState(() {
                                              _index -= 1;
                                            });
                                          }
                                        },
                                        child: const Text('BACK'),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Launcher()));
                                        },
                                        textColor: Colors.white,
                                        color: Colors.black,
                                        disabledColor: Colors.black,
                                        child: Text("DONE"),
                                        // onPressed: () {},
                                        padding: EdgeInsets.all(10),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    if (_index > 0) {
                                      setState(() {
                                        _index -= 1;
                                      });
                                    }
                                  },
                                  child: const Text('BACK'),
                                ),
                ],
              );
            },
            currentStep: _index,
            onStepCancel: () {
              if (_index > 0) {
                setState(() {
                  _index -= 1;
                });
              }
            },
            onStepContinue: () {
              if (_index <= 2) {
                setState(() {
                  _index += 1;
                });
              }
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            steps: <Step>[
              Step(
                isActive: _index >= 0,
                title: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Container(
                        // margin: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Recipe',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                            SizedBox(height: 10),
                            TextField(
                                key: _formKey,
                                controller: recipeController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    hintText: 'Recipe',
                                    fillColor: Colors.white)),
                            SizedBox(height: 35),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Description',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            SizedBox(height: 10),
                            TextField(
                                controller: desc1Controller,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    hintText: 'Description',
                                    fillColor: Colors.white)),
                            SizedBox(height: 10),
                            Row(children: <Widget>[
                              CupertinoButton(
                                  child: Text('Select time:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
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
                                                              _selectedHour =
                                                                  index;
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
                                style: TextStyle(fontSize: 16.0),
                              )
                            ]),
                            Row(children: <Widget>[
                              CupertinoButton(
                                  child: Text('Select method:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  onPressed: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (_) => Container(
                                              width: double.infinity,
                                              height: 250,
                                              child: CupertinoPicker(
                                                backgroundColor: Colors.white,
                                                itemExtent: 30,
                                                children:
                                                    getPickerItems(method),
                                                onSelectedItemChanged: (value) {
                                                  setState(() {
                                                    _selectedMethod =
                                                        method[value];
                                                  });
                                                },
                                              ),
                                            ));
                                  }),
                              Text(
                                '${_selectedMethod}',
                                style: TextStyle(fontSize: 16.0),
                              )
                            ]),
                            Row(children: <Widget>[
                              CupertinoButton(
                                  child: Text('Select type:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
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
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ]),
                            SizedBox(height: 35),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Nutritions facts',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            SizedBox(height: 20),
                            TextField(
                                controller: calController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    hintText: 'Calories',
                                    fillColor: Colors.white)),
                            SizedBox(height: 10),
                            TextField(
                                controller: proteinController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    hintText: 'Protein',
                                    fillColor: Colors.white)),
                            SizedBox(height: 10),
                            TextField(
                                controller: carboController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    hintText: 'Carbohydrates',
                                    fillColor: Colors.white)),
                            SizedBox(height: 10),
                            TextField(
                                controller: fatController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    hintText: 'Fat',
                                    fillColor: Colors.white)),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )),
              ),
              Step(
                isActive: _index >= 1,
                  title: Text(
                    '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  content: Container(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Kitchenware',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        Column(children: <Widget>[
                          SizedBox(height: 15),
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
                                      setState(() {
                                        if (currentKitchenWare !=
                                            'Select Kitchenware') {
                                          if (kitchenware.contains(
                                              currentKitchenWare) ==
                                              false) {
                                            kitchenware.insert(
                                                0, currentKitchenWare);
                                          } else {
                                            kitchenware
                                                .remove(currentKitchenWare);
                                            kitchenware.insert(
                                                0, currentKitchenWare);
                                          }
                                        }
                                      });
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                      Color(0xff999999),
                                                      width: 0.0,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    CupertinoButton(
                                                      child: Text('Cancel',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize:
                                                              20)),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 5.0,
                                                      ),
                                                    ),
                                                    CupertinoButton(
                                                      child: Text('Confirm',
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize:
                                                              20)),
                                                      onPressed: () {
                                                        setState(() {
                                                          kitchenware.remove(
                                                              currentKitchenWare);
                                                          _selectedKitchenware[
                                                          index] =
                                                              currentKitchenWare;
                                                        });
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 5.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 320.0,
                                                color: Color(0xfff7f7f7),
                                                child: CupertinoPicker(
                                                  itemExtent: 32,
                                                  backgroundColor:
                                                  Colors.white,
                                                  onSelectedItemChanged:
                                                      (int index) {
                                                    setState(() {
                                                      currentKitchenWare =
                                                      kitchenware[
                                                      index];
                                                      print(
                                                          currentKitchenWare);
                                                    });
                                                  },
                                                  children: getPickerItems(
                                                      kitchenware),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
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
                              icon: Icon(Icons.add)),
                        ]),
                        SizedBox(height: 35),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Ingredients',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        Column(
                          children: <Widget>[
                            SizedBox(height: 35),
                            Container(
                              child: Container(
                                height: 300,
                                child: _selectedIngredients.length != 0
                                    ? Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children:
                                    List.generate(_selectedIngredients.length, (index) {
                                      return ActionChip(
                                          label:
                                          Text('${_selectedIngredients[index]}  ${_selectedIngredientsCount[index]}  ${_selectedIngredientsUnit[index]}'),
                                          onPressed: () {
                                            buildEditWidget(index);
                                          });
                                    }))

                                    : Text('Select Ingredient',
                                style: TextStyle(color: color),),
                              ),
                            ),

                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIngredient = ingredients[0];
                                    _selectedIngredientAmount = 0;
                                    _selectedUnit = '';
                                    _widgetId = 1;
                                  });
                                  print(_selectedIngredientsCount);
                                  buildAddWidget();
                                },
                                icon: Icon(Icons.add)),
                          ],
                        ),
                      ],
                    ),
                  )
              ),
              Step(
                isActive: _index >= 2,
                title: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                content: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _count,
                      itemBuilder: (context, int index) {
                        return buildRestep(index);
                      },
                      shrinkWrap: true,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // addDynamic(_count);
                          _count++;
                          print(_count);
                          _descStepControllers.add(TextEditingController());
                          _timeStepControllers.add(TextEditingController());
                          _Stepimage.add(null);
                        });
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 50,
                        child: Icon(Icons.add),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                )),
              ),
              Step(
                isActive: _index >= 3,
                title: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                    // SizedBox(height: 25),
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
                    SizedBox(height: 25),
                    SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          // margin: EdgeInsets.all(15),
                          width: double.infinity,
                          // color: Color(0xffF4F6F6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
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
                                margin: EdgeInsets.all(5),
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
                                  // _getIngredientsRow(),
                                  _getIngredientsRow()
                                ]),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 170,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.all(10),
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
                                              Text('${calController.text}')
                                            ]),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text('Protein'),
                                                Text(
                                                    '${proteinController.text}')
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
                                              Text('${fatController.text}')
                                            ]),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text('Carbs'),
                                                Text('${carboController.text}')
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 9,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    // margin: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 25),
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
                              SizedBox(height: 15),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text('Recipe detail',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))),
                              _getRecipeStep(),
                              SizedBox(height: 15),
                              // Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: <Widget>[
                              //       builddoneBtn(),
                              //     ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //     ),
    //   ),
    // ),
  }
}

