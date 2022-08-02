import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:random_bg_test_task/src/utils/enum.dart';

///Class to help change color
class CustomColorChanger {
  static const _maxColorRange = 255;

  ///Get random color with opacity 1
  static Color getRandomColor() {
    final _random = math.Random();
    final _hueList = [0, 0, 0]; //Red, Green, Blue
    const _opacity = 1.0;

    for (int i = 0; i < _hueList.length; i++) {
      _hueList[i] = _random.nextInt(_maxColorRange);
    }

    final _generatedColor = Color.fromRGBO(
      _hueList[0], // ignore: prefer-first
      _hueList[1],
      _hueList[2],
      _opacity,
    );

    return _generatedColor;
  }

  ///Change color hue to offset
  static Color changeHue(
    Color? currentColor,
    SelectedColor colorToChange,
    int offset,
  ) {
    int _currentHueValue;
    int _updatedHueValue;
    Color _colorWithNewHue;

    if (currentColor == null) return Colors.white;

    switch (colorToChange) {
      case SelectedColor.red:
        _currentHueValue = currentColor.red;
        break;
      case SelectedColor.green:
        _currentHueValue = currentColor.green;
        break;
      case SelectedColor.blue:
        _currentHueValue = currentColor.blue;
        break;
    }

    _updatedHueValue = _currentHueValue - offset;

    if (_updatedHueValue > _maxColorRange) {
      _updatedHueValue = _maxColorRange;
    } else if (_updatedHueValue.isNegative) {
      _updatedHueValue = 0;
    }

    switch (colorToChange) {
      case SelectedColor.red:
        _colorWithNewHue = currentColor.withRed(_updatedHueValue);
        break;
      case SelectedColor.green:
        _colorWithNewHue = currentColor.withGreen(_updatedHueValue);
        break;
      case SelectedColor.blue:
        _colorWithNewHue = currentColor.withBlue(_updatedHueValue);
        break;
    }

    return _colorWithNewHue;
  }
}
