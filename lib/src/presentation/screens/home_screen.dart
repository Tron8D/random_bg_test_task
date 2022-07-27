import 'dart:math' as math;

import 'package:flutter/material.dart';

///Screen display the text "Hey there" in the middle of the screen and
///after tapping anywhere on the screen, a background color change to a
///randomly generated color
class HomeScreen extends StatefulWidget {
  ///Constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

///Screen state
class _HomeScreenState extends State<HomeScreen> {
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          const Center(child: Text('Hey there')),
          GestureDetector(
            onTap: () {
              setColor(randomColor());
            },
          ),
        ],
      ),
    );
  }

  void setColor(Color? currentColor){
    setState(() {
      backgroundColor = currentColor;
    });
  }

  Color randomColor() {
    final _random = math.Random();
    final _colorList = [0, 0, 0];
    const _maxColorRange = 255;
    const _opacity = 1.0;

    for (int i = 0; i < _colorList.length; i++) {
      _colorList[i] = _random.nextInt(_maxColorRange);
    }

    final _generatedColor =
      Color.fromRGBO(_colorList[0], _colorList[1], _colorList[2], _opacity,);

    return _generatedColor;
  }
}
