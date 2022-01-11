import 'package:flutter/material.dart';
import 'package:hewa/screen/fridge/ingredients.dart';
import 'package:hewa/screen/fridge/kitchenware.dart';

class Fridge extends StatefulWidget {
  static const routeName = '/';

  const Fridge({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FridgeState();
  }
}

class _FridgeState extends State<Fridge> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Ingredients'),
              Tab(
                text: 'Kitchenwares',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [Ingredients(), Kitchenware()],
        ),
      ),
    );
  }
}
