import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'actions_toolbar.dart';
import 'recipe_description.dart';
import '../menu_detail/menu_detail.dart';
import 'package:hewa/models/menuRecipe_model.dart';
import 'package:hewa/models/user_model.dart';

class RecipeContent extends StatefulWidget {
  RecipeContent(this.menuRecipeModel, this.url, this.userModel);
  MenuRecipeModel menuRecipeModel;
  var url;
  UserModel userModel;
  @override
  _RecipeContentState createState() =>
      _RecipeContentState(menuRecipeModel, url, userModel);
}

class _RecipeContentState extends State<RecipeContent> {
  _RecipeContentState(this.menuRecipeModel, this.url, this.userModel);
  MenuRecipeModel menuRecipeModel;
  var likes;
  var url;
  UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: MenuDetail(menuRecipeModel),
                        type: PageTransitionType.leftToRight));
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FutureBuilder<String>(
                      future: url,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        List<Widget> children = [];
                        if (snapshot.hasData) {
                          children = <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                  height: 430,
                                  width: 350,
                                ),
                                // decoration:
                                //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                              ),
                            )
                          ];
                        } else {
                          children = <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator())
                                  // decoration:
                                  //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                  ),
                            )
                          ];
                        }
                        return Column(children: children);
                      }),
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
                ),
              )),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RecipeDescription(menuRecipeModel),
              ActionsToolbar(menuRecipeModel, userModel)
            ],
          )
        ],
      ),
    );
  }

// class RecipeContent extends StatefulWidget {
//   RecipeContent(this.object, this.testRef) {
//     menuRecipeModel = object;
//     ref = testRef;
//   }
//   var testRef;
//   MenuRecipeModel object;
//   @override
//   _RecipeContentState createState() => _RecipeContentState();
// }

// MenuRecipeModel? menuRecipeModel;
// Reference? ref;
// var url;

// class _RecipeContentState extends State<RecipeContent> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       url = ref!.getDownloadURL();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: <Widget>[
//           GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     PageTransition(
//                         child: MenuDetail(),
//                         type: PageTransitionType.leftToRight));
//               },
//               child: Container(
//                 margin: EdgeInsets.only(left: 10),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: FutureBuilder<String>(
//                       future: url,
//                       builder: (BuildContext context,
//                           AsyncSnapshot<String> snapshot) {
//                         List<Widget> children = [];
//                         if (snapshot.hasData) {
//                           children = <Widget>[
//                             Container(
//                               margin: EdgeInsets.only(left: 10),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: Image.network(
//                                   snapshot.data!,
//                                   fit: BoxFit.cover,
//                                   height: 430,
//                                   width: 350,
//                                 ),
//                                 // decoration:
//                                 //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                               ),
//                             )
//                           ];
//                         } else {
//                           children = <Widget>[
//                             Container(
//                               margin: EdgeInsets.only(left: 10),
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   child: Align(
//                                       alignment: Alignment.center,
//                                       child: CircularProgressIndicator())
//                                   // decoration:
//                                   //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                                   ),
//                             )
//                           ];
//                         }
//                         return Column(children: children);
//                       }),
//                   // decoration:
//                   //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                 ),
//               )),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               RecipeDescription(menuRecipeModel!),
//               ActionsToolbar(menuRecipeModel!)
//             ],
//           )
//         ],
//       ),
//     );
//   }
}
