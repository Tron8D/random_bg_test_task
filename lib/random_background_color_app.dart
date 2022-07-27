import 'dart:math' as math;

import 'package:flutter/material.dart';

class RandomBackgroundColorApp extends StatefulWidget {
  Color backgroundColor = Color.fromRGBO(255, 255, 255, 1.0);

  RandomBackgroundColorApp({Key? key}) : super(key: key);

  @override
  State<RandomBackgroundColorApp> createState() =>
      _RandomBackgroundColorAppState();
}

class _RandomBackgroundColorAppState extends State<RandomBackgroundColorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Stack(
          children: [
            const Center(child: Text('Hey there')),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.backgroundColor = randomColor();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Color randomColor() {
    final _random = math.Random();
    final List<int> _colors = [0, 0, 0];
    const int _maxColorRange = 255;
    const double _opacity = 1.0;

    for (int i = 0; i < _colors.length; i++) {
      _colors[i] = _random.nextInt(_maxColorRange);
    }

    return Color.fromRGBO(_colors[0], _colors[1], _colors[2], _opacity);
  }
}
