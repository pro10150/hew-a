import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hewa/models/report_model.dart';
import 'package:hewa/utilities/report_helper.dart';

class reportDetail extends StatefulWidget {


  @override
  _reportDetailState createState() => _reportDetailState();
}

class _reportDetailState extends State<reportDetail> {



  ReportModel? reportModel;
  ReportHelper? reportHelper;

  List<ReportModel> userReport = [];

  getReport() async {
    var objects = await ReportHelper().readlDataFromSQLite();
    for (var object in objects) {
      setState(() {
        userReport.add(object);
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(75.0),
          child: Text(
            'ลุงตู้ผู้พิชิต',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xffffab91),
        elevation: 0,
      ),
      backgroundColor: Color(0xffffab91),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  "https://pyxis.nymag.com/v1/imgs/f22/cee/18a5c624814d1fee69692841d2f92e89ad-21-homer-bushes-lede.rhorizontal.w700.jpg")),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Report about:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 35,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                      BorderRadius.circular(50)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "คัดลอกสูตรอาหารคนอื่น",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "คำอธิบายเพิ่มเติม :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "รายละเอียด",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "รูปภาพเพิ่มเติม :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "รายละเอียด",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(50)),
                                  child: Text(
                                    "Dissmiss report",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 70,
                                ),
                                RaisedButton(
                                  color: Colors.red[400],
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(50)),
                                  child: Text(
                                    "Block account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              content: Container(),
                                              actions: <Widget>[
                                                RaisedButton(
                                                  color: Colors.grey[200],
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          50)),
                                                  child: Text(
                                                    "Dissmiss report",
                                                    style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ]);
                                        });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
