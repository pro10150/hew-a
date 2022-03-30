import 'package:flutter/material.dart';
import 'report_detail.dart';

class userReport extends StatefulWidget {
  const userReport({Key? key}) : super(key: key);

  @override
  _userReportState createState() => _userReportState();
}

class _userReportState extends State<userReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            TextButton(
              child: Text(
                "Logout",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () => print("logout"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Recipe Report",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xffffab91),
        elevation: 4.0,
      ),
      body: Container(
        height: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "13 report alert",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _buildListReport(context),
            ),
          ],
        ),
      ),
      //ข้างล่าง
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffffab91),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: Colors.white,
            ),
            label: "User",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: Colors.white,
            ),
            label: "Recipe",
          ),
        ],
      ),
    );
  }

  Widget _buildListReport(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: Text("iwanttosleep10hrchallenge"),
            subtitle: Text("somethinpullfromDB"),
            leading: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://pyxis.nymag.com/v1/imgs/f22/cee/18a5c624814d1fee69692841d2f92e89ad-21-homer-bushes-lede.rhorizontal.w700.jpg")),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => reportDetail()));
            },
          ),
        );
      },
    );
  }
}
