import 'dart:math';

import 'package:flutter/material.dart';

extension BlackThemeExtension on ThemeData {
  ThemeData get blackTheme {
    MaterialColor black = const MaterialColor(
      0xFF000000, // The primary color value
      <int, Color>{
        50: Color(0xFFE0E0E0), // 10% black
        100: Color(0xFFB0B0B0), // 20% black
        200: Color(0xFF808080), // 30% black
        300: Color(0xFF404040), // 40% black
        400: Color(0xFF202020), // 50% black
        500: Color(0xFF000000), // 100% black
        600: Color(0xFF000000), // You can adjust the shades as needed
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      },
    );

    return ThemeData(
      primarySwatch: black, // Use the custom black color
    );
  }
}

extension RandomColorExtension on List<Color> {
  Color getRandomColor() {
    final random = Random();
    return this[random.nextInt(length)];
  }
}

extension RandomExtension on Random {
  int nextIntInRange() {
    int min = 10;
    int max = 500;
    if (min >= max) {
      throw ArgumentError("min must be less than max");
    }
    return min + nextInt(max - min);
  }
}

extension NavigationExtension on BuildContext {
  void navigateToRoute(Widget route) {
    Navigator.push(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Start offscreen right
          const end = Offset.zero; // End at the top left corner
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
