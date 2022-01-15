import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hewa/config/palette.dart';
import 'package:hewa/utilities/kitch_helper.dart';
import 'package:hewa/utilities/db_helper.dart';

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

  Future<Null> readSQLite() async {
    var object = await KitchHelper().readlDataFromSQLite();
    print('object length ==> ${object.length}');
    if (object.length != 0) {
      if (kitchenware.length == 0) {
        for (var model in object) {
          kitchenware.add(model.nameKitc!);
        }
      }

      print(kitchenware);
    } else {
      print('found nothing');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // KitchHelper().deleteAlldata();
    // DBHelper().delteDatabase();
    // KitchHelper().initialInsert();
    //ใช้ initialInsert เพื่อinsert เครื่องครัว
    readSQLite();
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
                                            _kitchenwareList
                                                .add(_selectedKitchenware);
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
                    ? ListView.builder(
                        itemCount: _kitchenwareList.length,
                        itemBuilder: (context, index) {
                          String currentKitchenware = _kitchenwareList[index];
                          return Container(
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Slidable(
                                key: const ValueKey(0),

                                // The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  motion: DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        setState(() {
                                          _kitchenwareList.removeAt(index);
                                        });
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                          '$currentKitchenware')
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ))),
                              ));
                        },
                      )
                    : Text('You don\'t have any kitchenwares yet'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
