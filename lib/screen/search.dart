import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'search/searchmain.dart';

class Search extends StatefulWidget {
  static const routeName = '/';

  const Search({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const color = const Color(0xffffab91);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 130,
            padding: EdgeInsets.only(top: 50, right: 25, left: 30, bottom: 10),
            decoration: BoxDecoration(color: color),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 40.0),
                  padding:
                      EdgeInsets.only(top: 5, right: 25, left: 5, bottom: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onSubmitted: (_) {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: SearchContent(),
                              type: PageTransitionType.leftToRight));
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintText: "SearchWidget Menu",
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      CategoryCard(),
                      CategoryCard(),
                      CategoryCard(),
                      CategoryCard(),
                      CategoryCard(),
                      CategoryCard(),
                      CategoryCard(),
                      CategoryCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // appBar: AppBar(
      //   title: Text('SearchWidget'),
      // ),
      // body: Center(
      //     child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text('SearchWidget Screen'),
      //   ],
      // )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: <Widget>[
          //ใส่รูปจ้า ทำยังไง
          Text(
            "ผัดกะเพรา",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
