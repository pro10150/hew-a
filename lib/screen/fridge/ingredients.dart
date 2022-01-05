import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                    IconButton(onPressed: () {}, icon: Icon(Icons.add))
                  ],
                ),
                Container(height: 20)
              ]),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          child: Slidable(
                              key: const ValueKey(0),

                              // The end action pane is the one at the right or the bottom side.
                              endActionPane: const ActionPane(
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
                                height: MediaQuery.of(context).size.width * 0.3,
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
                                            text: 'Egg',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          strutStyle: StrutStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: '5',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
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
