import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor roseBud = const MaterialColor( 
    0xffffab91, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xffe69a83),//10% 
      100: const Color(0xffcc8974),//20% 
      200: const Color(0xffb37866),//30% 
      300: const Color(0xff996757),//40% 
      400: const Color(0xff805649),//50% 
      500: const Color(0xff66443a),//60% 
      600: const Color(0xff4c332b),//70% 
      700: const Color(0xff33221d),//80% 
      800: const Color(0xff19110e),//90% 
      900: const Color(0xffffffff),//100% 
    }, 
  ); 
} 