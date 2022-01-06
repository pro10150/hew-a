import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  int number = 0;
  @override
  Widget build(BuildContext context) {
    final urlImage =
        "https://i.pinimg.com/564x/ee/a7/59/eea7597b2336cec27f04a875887bb2a6.jpg";
    return Scaffold(
      body: Container(
        height: 800,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(urlImage), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 500,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          fit: StackFit.expand,
                          overflow: Overflow.visible,
                          children: [
                            Positioned(
                              height: 100,
                              width: 100,
                              top: -50,
                              right: -120,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(urlImage),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: -120,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: Colors.white)),
                                  color: Colors.white,
                                  onPressed: () {},
                                  child: Icon(Icons.camera),
                                ),
                              ),
                            ),
                          ],
                        )),
                    //SizedBox(height: 120,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            "User Info",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                              decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            labelText: 'Nickname',
                            hintText: 'Nickname',
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                              decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            labelText: 'Birthday:DD/MM/YY',
                            hintText: '01/01/2021',
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                          SizedBox(
                            height: 40,
                          ),
                          RaisedButton(
                            color: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 120, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Next",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {},
                          ),
                          TextButton(
                            child: Text("Skip>>",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onPressed: () {},
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
