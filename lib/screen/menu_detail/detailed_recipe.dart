import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hewa/screen/fridge/ingredients.dart';
import 'package:hewa/screen/menu_detail/menu_detail.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hewa/config/palette.dart';
import 'dart:math' as math;
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/like_model.dart';
import 'package:hewa/models/reStep_model.dart';
import 'package:hewa/models/reIngred_model.dart';
import 'package:hewa/models/ingred_model.dart';
import 'package:hewa/models/reIngredIngred_model.dart';
import 'package:hewa/models/reImageStep_model.dart';
import 'package:hewa/models/userIngred_model.dart';
import 'package:hewa/utilities/like_helper.dart';
import 'package:hewa/utilities/reStep_helper.dart';
import 'package:hewa/utilities/reIngred_helper.dart';
import 'package:hewa/utilities/ingred_helper.dart';
import 'package:hewa/utilities/reIngredIngred_helper.dart';
import 'package:hewa/utilities/reImageStep_helper.dart';
import 'package:hewa/utilities/userIngred_helper.dart';

// ignore: must_be_immutable
class DetailedRecipe extends StatefulWidget {
  DetailedRecipe(this.tempMenuRecipeModel) {
    menuRecipeModel = tempMenuRecipeModel;
  }
  MenuRecipeModel tempMenuRecipeModel;
  @override
  _DetailedRecipeState createState() => _DetailedRecipeState();
}

var _auth = FirebaseAuth.instance;
MenuRecipeModel? menuRecipeModel;
List<ReIngredModel> reIngredModels = [];
List<ReIngredIngredModel> reIngredIngredModels = [];
List<double> _ingr = [];
List<IngredModel> ingredModels = [];
List<ReStepModel> reStepModels = [];
List<UserIngredModel> userIngredModels = [];
List<List<ReImageStepModel>> reImageStepModels = [];
List<List<String>> urls = [];

class TimerPainter extends CustomPainter {
  TimerPainter(
      {required this.animation,
      required this.backgroundColor,
      required this.color})
      : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant TimerPainter old) {
    // TODO: implement shouldRepaint
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class _DetailedRecipeState extends State<DetailedRecipe>
    with TickerProviderStateMixin {
  int _n = 1;
  List<dynamic> controllers = [];
  List<dynamic> timerStrings = [];

  getUserIngred() async {
    var objects = await UserIngredHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    for (var object in objects) {
      setState(() {
        userIngredModels.add(object);
      });
    }
  }

  getRecipeSteps() async {
    setState(() {
      urls = [];
      reStepModels = [];
      reImageStepModels = [];
    });
    var objects = await ReStepHelper()
        .readDataFromSQLiteWhereRecipe(menuRecipeModel!.id.toString());
    for (var object in objects) {
      if (object.minute != null) {
        setState(() {
          var controller = AnimationController(
              vsync: this, duration: Duration(minutes: object.minute!));
          controllers.add(controller);
          Duration duration = controller.duration!;
          String timerString =
              '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
          timerStrings.add(timerString);
        });
      } else {
        setState(() {
          controllers.add(null);
          timerStrings.add(null);
        });
      }

      var images = await ReImageStepHelper().readDataFromSQLiteWhereStep(
          int.parse(object.recipeId!), object.recipeId);
      List<String> tempUrls = [];
      for (var image in images) {
        var ref =
            FirebaseStorage.instance.ref().child('steps').child(image.name!);
        String tempURL = await ref.getDownloadURL();
        tempUrls.add(tempURL);
      }
      setState(() {
        if (tempUrls.length > 0) {
          urls.add(tempUrls);
        } else {
          urls.add([]);
        }
        if (images.length > 0) {
          reImageStepModels.add(images);
        } else {
          reImageStepModels.add([]);
        }
        reStepModels.add(object);
      });
    }
  }

  getRecipeIngred() async {
    setState(() {
      reIngredIngredModels = [];
    });
    var objects = await ReIngredIngredHelper()
        .readDataFromSQLiteWhereRecipeId(menuRecipeModel!.id.toString());
    for (var object in objects) {
      setState(() {
        reIngredIngredModels.add(object);
        if (object.amount != null) {
          _ingr.add(object.amount!);
        } else {
          _ingr.add(0);
        }
      });
    }
  }

  getController() {
    for (var reStepModel in reStepModels) {
      setState(() {
        var controller = AnimationController(
            vsync: this, duration: Duration(minutes: reStepModel.minute!));
        controllers.add(controller);
        Duration duration = controller.duration! * controller.value;
        String timerString =
            '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
        timerStrings.add(timerString);
        print(timerString);
      });
    }
    print(controllers.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipeSteps();
    getRecipeIngred();
    getUserIngred();
    // getController();
    // controller = AnimationController(
    //     vsync: this, duration: Duration(minutes: menuRecipeModel!.timeMinute!));
  }

  String timerString(AnimationController controller) {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

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

  bool compareUnit(ReIngredIngredModel reIngred, UserIngredModel userIngred) {
    bool isEnough = false;
    if (reIngred.unit == "cup") {
      if (userIngred.unit == "cup") {
        if (reIngred.amount! * _n <= userIngred.amount!) {
          isEnough = true;
        }
      } else if (userIngred.unit == "tbsp") {
        var reAmount = reIngred.amount! * 16;
        if (reAmount * _n <= userIngred.amount!) {
          isEnough = true;
        } else {
          isEnough = false;
        }
      }
    } else if (reIngred.unit == "tbsp") {
      if (userIngred.unit == "cup") {
        var reAmount = reIngred.amount! * 0.0625;
        if (reAmount * _n <= userIngred.amount!) {
          isEnough = true;
        }
      }
    } else if (reIngred.unit == "g") {
      if (userIngred.unit == "kg") {
        var reAmount = reIngred.amount! * 100;
        if (reAmount * _n <= userIngred.amount!) {
          isEnough = true;
        }
      }
    } else if (reIngred.unit == "kg") {
      if (userIngred.unit == "g") {
        var reAmount = reIngred.amount! * 0.001;
        if (reAmount * _n <= userIngred.amount!) {
          isEnough = true;
        }
      }
    }
    if (userIngred.unit == reIngred.unit) {
      if (reIngred.amount! * _n <= userIngred.amount!) {
        isEnough = true;
      } else if (reIngred.amount! * _n > userIngred.amount!) {
        isEnough = false;
      }
    }
    return isEnough;
  }

  Widget _getIngredients(
      ReIngredIngredModel reIngredIngredModel, double amount) {
    bool isHave = false;
    bool isEnough = false;
    bool isDiffType = false;
    if (userModel!.ingredients == 1) {
      for (var userIngredModel in userIngredModels) {
        if (reIngredIngredModel.id == userIngredModel.ingredientId) {
          isHave = true;
          if (reIngredIngredModel.amount != null ||
              userIngredModel.amount != null) {
            if (reIngredIngredModel.amount != null &&
                userIngredModel.amount != null) {
              if (reIngredIngredModel.unit != null &&
                  userIngredModel.unit != null) {
                isEnough = compareUnit(reIngredIngredModel, userIngredModel);
              } else if (reIngredIngredModel.amount! * _n <=
                  userIngredModel.amount!) {
                isEnough = true;
              }
            } else {
              isEnough = true;
            }
          } else {
            isEnough = true;
          }
        }
      }
    } else {
      isHave = true;
      isEnough = true;
      isDiffType = true;
    }

    return Container(
      width: 100,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Flexible(
                child: Text(
              reIngredIngredModel.name!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            )),
            SizedBox(
              width: 2,
            ),
          ]),
          amount > 0
              ? Text(
                  (amount * _n).toString(),
                  style: TextStyle(fontSize: 10),
                )
              : Container(),
          SizedBox(
            width: 2,
          ),
          reIngredIngredModel.unit != null
              ? Text(
                  reIngredIngredModel.unit!,
                  style: TextStyle(fontSize: 10),
                )
              : Container(),
          isHave == false
              ? Text(
                  'คุณไม่มี',
                  style: TextStyle(
                      color: reIngredIngredModel.isPrimary == 1
                          ? Colors.red
                          : Colors.orange[400],
                      fontSize: 10),
                )
              : isEnough == false
                  ? Text(
                      'คุณมีไม่พอ',
                      style: TextStyle(
                          color: reIngredIngredModel.isPrimary == 1
                              ? Colors.red
                              : Colors.orange[400],
                          fontSize: 10),
                    )
                  : Container()
        ],
      ),
    );
  }

  Widget _getIngredientsRow() {
    return Wrap(
      children: <Widget>[
        GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100.0,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reIngredIngredModels.length,
            itemBuilder: (context, index) {
              return _getIngredients(reIngredIngredModels[index], _ingr[index]);
            })
      ],
    );
  }

  bool isMoving = false;

  Widget _getRecipeStep(ReStepModel reStepModel, int index,
      List<ReImageStepModel> images, List<String> imageUrls) {
    // controllers[index] = AnimationController(
    //     vsync: this, duration: Duration(minutes: reStepModel.minute!));
    if (controllers[index] != null) {
      controllers[index].addListener(() {
        if (controllers[index].value == 0 && isMoving == true) {
          FlutterRingtonePlayer.playRingtone();
          setState(() {
            isMoving = false;
          });
        }
      });
    }

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
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'Step ' + reStepModel.step.toString(),
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
                        text: reStepModel.description,
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
            reStepModel.minute != null
                ? GFButton(
                    onPressed: () {
                      if (controllers[index].isAnimating) {
                        controllers[index].reset();
                        controllers[index].reverse(
                            from: controllers[index].value == 0.0 ? 1.0 : 0);
                      } else {
                        controllers[index].reverse(
                            from: controllers[index].value == 0.0 ? 1.0 : 0);
                      }

                      _openTimer(context, controllers[index], index);
                      Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          isMoving = true;
                        });
                      });
                    },
                    text: reStepModel.minute.toString() + ' min',
                    textColor: Colors.black,
                    shape: GFButtonShape.pills,
                    type: GFButtonType.outline2x,
                    color: Colors.black,
                  )
                : Container()
          ]),
        ),
        images.length > 0
            ? GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Container(
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
                        image: NetworkImage(imageUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })
            : Container()
      ],
    );
  }

  _openTimer(context, controller, int index) {
    Alert(
        closeFunction: () {
          setState(() {
            isMoving = false;
            Navigator.pop(context);
          });
        },
        context: context,
        title: "Timer",
        content: Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.only(top: 10),
            child: Column(children: <Widget>[
              Expanded(
                  child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: AnimatedBuilder(
                                animation: controller!,
                                builder: (BuildContext context, Widget? child) {
                                  return new CustomPaint(
                                    painter: TimerPainter(
                                        animation: controller!,
                                        backgroundColor: Colors.white,
                                        color: Palette.roseBud),
                                  );
                                })),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedBuilder(
                                    animation: controller,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return new Text(
                                        timerString(controller),
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      );
                                    })
                              ]),
                        )
                      ],
                    )),
              )),
            ])),
        buttons: [
          DialogButton(
              color: Palette.roseBud,
              child: Text("Stop"),
              onPressed: () {
                setState(() {
                  isMoving = false;
                });
                Navigator.pop(context);
              })
        ]).show();
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
              borderRadius: BorderRadius.circular(30),
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
                            child: menuRecipeModel!.recipeName != null
                                ? Text(menuRecipeModel!.recipeName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))
                                : Text(menuRecipeModel!.nameMenu!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20),
                        Text('Servings', style: TextStyle(fontSize: 24))
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new FloatingActionButton(
                            onPressed: minus,
                            child: new Icon(
                              MdiIcons.minus,
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          new Text('$_n', style: new TextStyle(fontSize: 36.0)),
                          new FloatingActionButton(
                            onPressed: add,
                            child: new Icon(Icons.add, color: Colors.black),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
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
                      margin: EdgeInsets.all(20),
                      child: Wrap(children: <Widget>[
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: EdgeInsets.only(left: 10, top: 20),
                              child: Text(
                                'You need',
                                style: TextStyle(fontSize: 24),
                              )),
                        ),
                        _getIngredientsRow(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02,
                                bottom:
                                    MediaQuery.of(context).size.width * 0.01,
                              ),
                              child: Text(
                                '*Red text means you needs it to make this while orange represent something you can be ignored',
                                style: TextStyle(fontSize: 10),
                              )),
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Text('Calories'),
                                    Text(menuRecipeModel!.calories.toString())
                                  ]),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Protein'),
                                      Text(menuRecipeModel!.protein.toString() +
                                          ' g')
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Text('Fat'),
                                    Text(menuRecipeModel!.fat.toString() + ' g')
                                  ]),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Carbs'),
                                      Text(menuRecipeModel!.carb.toString() +
                                          ' g')
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      'Estimated time',
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  Icon(
                                    MdiIcons.clockOutline,
                                    size: 60,
                                  ),
                                  SizedBox(height: 10),
                                  menuRecipeModel!.timeMinute != null
                                      ? Text(menuRecipeModel!.timeMinute
                                              .toString() +
                                          ' min')
                                      : Text('N/A')
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
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    ListView.builder(
                        itemCount: reStepModels.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _getRecipeStep(reStepModels[index], index,
                              reImageStepModels[index], urls[index]);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
