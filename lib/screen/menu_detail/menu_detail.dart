import 'package:flutter/material.dart';
import 'package:hewa/config/palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:getwidget/getwidget.dart';

class MenuDetail extends StatefulWidget {
  static const routeName = '/';
  const MenuDetail({Key? key}) : super(key: key);
  @override
  _MenuDetailState createState() => _MenuDetailState();
}

Widget _getRecipePicture({required String pictureUrl}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image(
      image: AssetImage(pictureUrl),
      fit: BoxFit.cover,
      height: 300,
      width: 300,
    ),
  );
}

Widget _getKitchenware({required String kitchenWare}) {
  return GFButton(
    onPressed: () {},
    text: kitchenWare,
    shape: GFButtonShape.pills,
    color: Colors.black,
  );
}

class _MenuDetailState extends State<MenuDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ปลากู๊ด'),
      ),
      backgroundColor: Palette.roseBud,
      body: Container(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      _getRecipePicture(
                          pictureUrl: 'lib/assets/menu_detail/food.png'),
                      SizedBox(width: 20),
                      _getRecipePicture(
                          pictureUrl: 'lib/assets/menu_detail/food2.png'),
                      SizedBox(width: 20),
                      _getRecipePicture(
                          pictureUrl: 'lib/assets/menu_detail/food3.png'),
                    ],
                  ),
                )),
            Container(
              height: 30,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  height: 370,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 40,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            Icon(MdiIcons.clockOutline),
                            Container(
                              width: 5,
                            ),
                            Text('30 min', style: TextStyle(fontSize: 18))
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            Text(
                              'กะเพราหมูสับ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            )
                          ],
                        ),
                        Container(height: 10),
                        Row(
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
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            Text(
                              'Kitchenware',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            )
                          ],
                        ),
                        Container(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 20,
                            ),
                            _getKitchenware(kitchenWare: 'Pan'),
                            Container(
                              width: 10,
                            ),
                            _getKitchenware(kitchenWare: 'Microwave')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GFButton(
                              onPressed: () {},
                              text: 'ViewStep',
                              textColor: Colors.black,
                              shape: GFButtonShape.pills,
                              type: GFButtonType.outline2x,
                              color: Colors.black,
                            ),
                            Container(
                              width: 10,
                            )
                          ],
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
