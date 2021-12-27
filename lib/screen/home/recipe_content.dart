import 'package:flutter/material.dart';

class recipeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image(
          image: AssetImage('assets/home/food.png'),
          fit: BoxFit.cover,
          height: 50,
          width: 40,
        ),
        // decoration:
        //     BoxDecoration(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
