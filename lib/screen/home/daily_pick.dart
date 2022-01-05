import 'package:flutter/material.dart';
import 'recipe_content.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class dailyPick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        // wrap in Expanded
        child: TikTokStyleFullPageScroller(
      contentSize: 2,
      swipePositionThreshold: 0.2,
      swipeVelocityThreshold: 1000,
      animationDuration: const Duration(milliseconds: 300),
      builder: (BuildContext context, int index) {
        return recipeContent();
      },
    ));
  }
}
