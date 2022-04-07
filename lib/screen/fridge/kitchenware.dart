import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/utilities/kitch_helper.dart';
import 'package:hewa/utilities/userKitch_helper.dart' as userKitchHelper;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hewa/models/userKitch_model.dart';
import 'package:hewa/utilities/user_helper.dart';
import 'package:hewa/models/user_model.dart';
import 'package:hewa/config/palette.dart';

List<String> kitchenware = [];

class Kitchenware extends StatefulWidget {
  static const routeName = '/';

  const Kitchenware({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _KitchenwareState();
  }
}

List<String> _kitchenwareList = [];
void doNothing(BuildContext context) {}

class _KitchenwareState extends State<Kitchenware> {
  bool isSwitched = false;
  String _selectedKitchenware = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? userModel;
  List<Widget> getPickerItems(List<String> list) {
    List<Widget> items = [];
    for (var i in list) {
      items.add(Text(i));
    }
    return items;
  }

  void deleteKitchenware(int index) {
    _kitchenwareList.removeAt(index);
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

  Future<Null> getUserKitchenware() async {
    var object = await userKitchHelper.UserKitchHelper()
        .readDataFromSQLiteWhereUser(_auth.currentUser!.uid);
    print('user kitchenware length ==> ${object.length}');
    setState(() {
      _kitchenwareList.clear();
      if (object.length != 0) {
        for (var model in object) {
          _kitchenwareList.add(model.kitchenware!);
          kitchenware.remove(model.kitchenware);
        }
      }
    });
  }

  Future<Null> getSwitch() async {
    var object =
        await UserHelper().readDataFromSQLiteWhereId(_auth.currentUser!.uid);
    if (object.length != 0) {
      for (var model in object) {
        userModel = model;
        userModel!.uid = model.uid;
        userModel!.username = model.username;
        if (model.kitchenwares == 1) {
          setState(() {
            isSwitched = true;
          });
        }
      }
    }
  }

  buildKitchenwareChip(int index) {
    return ActionChip(label: Text(_kitchenwareList[index]), onPressed: () {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KitchHelper().deleteAlldata();
    KitchHelper().initialInsert();
    //ใช้ initialInsert เพื่อinsert เครื่องครัว
    getKitchenware();
    getSwitch();
    getUserKitchenware();
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
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
                          userModel!.kitchenwares = ing;
                          UserHelper().updateDataToSQLite(userModel!);
                        });
                      }),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedKitchenware = kitchenware[0];
                        });
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
                                        },
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 5.0,
                                        ),
                                      ),
                                      CupertinoButton(
                                        child: Text('Confirm'),
                                        onPressed: () {
                                          setState(() {
                                            kitchenware
                                                .remove(_selectedKitchenware);
                                            _kitchenwareList
                                                .add(_selectedKitchenware);
                                          });
                                          var model = UserKitchenwareModel(
                                              uid: _auth.currentUser!.uid,
                                              kitchenware:
                                                  _selectedKitchenware);
                                          userKitchHelper.UserKitchHelper()
                                              .insertDataToSQLite(model);
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
                                  height: 320.0,
                                  color: Color(0xfff7f7f7),
                                  child: CupertinoPicker(
                                    itemExtent: 32,
                                    backgroundColor: Colors.white,
                                    onSelectedItemChanged: (int index) {
                                      setState(() {
                                        _selectedKitchenware =
                                            kitchenware[index];
                                        print(_selectedKitchenware);
                                      });
                                    },
                                    children: getPickerItems(kitchenware),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.add))
                ],
              ),
            ),
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height,
                child: _kitchenwareList.length != 0
                    ? Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children:
                            List.generate(_kitchenwareList.length, (index) {
                          return ActionChip(
                              label: Text(_kitchenwareList[index]),
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('Delete Kitchenware'),
                                        content: Text(
                                            'Do you want to delete ${_kitchenwareList[index]}?'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('cancel')),
                                          TextButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          Palette.roseBud),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          side: BorderSide(
                                                              color: Palette
                                                                  .roseBud)))),
                                              onPressed: () {
                                                userKitchHelper
                                                        .UserKitchHelper()
                                                    .deleteDataWhere(
                                                        _auth.currentUser!.uid,
                                                        _kitchenwareList[
                                                            index]);
                                                setState(() {
                                                  kitchenware.insert(0,
                                                      _kitchenwareList[index]);
                                                  _kitchenwareList
                                                      .removeAt(index);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                        ],
                                      )));
                        }))
                    // ListView.builder(
                    //     itemCount: _kitchenwareList.length,
                    //     itemBuilder: (context, index) {
                    //       String currentKitchenware = _kitchenwareList[index];
                    //       return buildKitchenwareChip(index);
                    // return Container(
                    //     height: MediaQuery.of(context).size.width * 0.3,
                    //     child: Slidable(
                    //       key: const ValueKey(0),

                    //       // The end action pane is the one at the right or the bottom side.
                    //       endActionPane: ActionPane(
                    //         motion: DrawerMotion(),
                    //         children: [
                    //           SlidableAction(
                    //             onPressed: (context) {
                    //               userKitchHelper.UserKitchHelper()
                    //                   .deleteDataWhere(
                    //                       _auth.currentUser!.uid,
                    //                       _kitchenwareList[index]);
                    //               setState(() {
                    //                 kitchenware
                    //                     .add(_kitchenwareList[index]);
                    //                 _kitchenwareList.removeAt(index);
                    //               });
                    //             },
                    //             backgroundColor: Colors.red,
                    //             foregroundColor: Colors.white,
                    //             icon: Icons.delete,
                    //             label: 'Delete',
                    //           ),
                    //         ],
                    //       ),
                    //       child: SizedBox(
                    //           height:
                    //               MediaQuery.of(context).size.width * 0.3,
                    //           width: double.infinity,
                    //           child: Card(
                    //               color: Colors.white,
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: <Widget>[
                    //                   Container(
                    //                     color: Palette.roseBud,
                    //                     width: 10,
                    //                   ),
                    //                   SizedBox(width: 10),
                    //                   Expanded(
                    //                     child: InkWell(
                    //                         onTap: () {
                    //                           print(_kitchenwareList[
                    //                               index]);
                    //                         },
                    //                         child: Column(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment
                    //                                   .center,
                    //                           crossAxisAlignment:
                    //                               CrossAxisAlignment
                    //                                   .start,
                    //                           children: <Widget>[
                    //                             Text(
                    //                                 '$currentKitchenware')
                    //                           ],
                    //                         )),
                    //                   )
                    //                 ],
                    //               ))),
                    //     ));
                    //   },
                    // )
                    : Text('You don\'t have any kitchenwares yet'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
