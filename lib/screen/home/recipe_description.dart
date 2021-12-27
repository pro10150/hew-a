import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class recipeDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.only(left: 10),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(8.0),
            //     child: Image(
            //       image: AssetImage('assets/home/food.png'),
            //       fit: BoxFit.cover,
            //       height: 450,
            //       width: 500,
            //     ),
            //     // decoration:
            //     //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 450),
              child: (Text(
                'คุณต้องซื้อวัตถุดิบเพิ่มเติม',
                style: TextStyle(fontSize: 14),
              )),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'ผัดกะเพราหมูสับ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Icon(MdiIcons.clockOutline, size: 25),
                  Text('30 min'),
                  Icon(MdiIcons.pigVariantOutline),
                  Text('Pork')
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, bottom: 40, left: 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: new Text(
                          'ผัดกะเพราหมูสับใส่บราวนี จะเขียนอะไรดีอ่าาาาาาาาาาาาาาาาาาาาา'))
                ],
              ),
            ),
          ]),
    );
  }
}
