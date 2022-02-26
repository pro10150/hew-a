import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../menu_detail/menu_detail.dart';

class recipeDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: MenuDetail(), type: PageTransitionType.rightToLeft));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(MdiIcons.clockOutline, size: 25),
                  Text('30 min'),
                  Icon(MdiIcons.pigVariantOutline),
                  Text('Pork')
                ],
              ),
            ),
          ]),
    ));
  }
}
