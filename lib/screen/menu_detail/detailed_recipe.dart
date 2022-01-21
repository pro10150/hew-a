import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hewa/config/palette.dart';
import 'dart:math' as math;
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class DetailedRecipe extends StatefulWidget {
  @override
  _DetailedRecipeState createState() => _DetailedRecipeState();
}

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
  int _ingr = 240;
  AnimationController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
  }

  String get timerString {
    Duration duration = controller!.duration! * controller!.value;
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
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    controller!.addListener(() {
      if (controller!.value == 0) {
        FlutterRingtonePlayer.playRingtone();
      }
    });
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
              onPressed: () {
                if (controller!.isAnimating) {
                  controller!.reset();
                  controller!.reverse(from: controller!.value == 0.0 ? 1.0 : 0);
                } else {
                  controller!.reverse(from: controller!.value == 0.0 ? 1.0 : 0);
                }

                _openTimer(context, controller);
              },
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

  _openTimer(context, controller) {
    Alert(
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
                                        timerString,
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
                            child: Text('กะเพราหมูสับ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)))
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    _getRecipeStep(),
                    _getRecipeStep(),
                    _getRecipeStep(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
