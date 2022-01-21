import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'recipe_content.dart';

class discover extends StatelessWidget {
  void _handleCallbackEvent(ScrollEventType type, {required int currentIndex}) {
    print(
        "Scroll callback received with data: {type: $type, and index: $currentIndex}");
  }

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
