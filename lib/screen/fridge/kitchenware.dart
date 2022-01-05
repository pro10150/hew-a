import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hewa/config/palette.dart';

class Kitchenware extends StatefulWidget {
  static const routeName = '/';

  const Kitchenware({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KitchenwareState();
  }
}

void doNothing(BuildContext context) {}

class _KitchenwareState extends State<Kitchenware> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Container(width: 10),
                  CupertinoSwitch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      }),
                  Container(
                    width: 270,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add))
                ],
              ),
            ),
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: 4,
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
                                onPressed: doNothing,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.3,
                              width: double.infinity,
                              child: Card(
                                  color: Colors.white,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        color: Palette.roseBud,
                                        width: 10,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: InkWell(
                                            onTap: () {
                                              print('Yeet');
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Microwave')
                                              ],
                                            )),
                                      )
                                    ],
                                  ))),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
