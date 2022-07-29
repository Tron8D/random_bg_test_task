import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:random_bg_test_task/src/utils/enums.dart';

///
class CustomColorChanger {
  static const _maxColorRange = 255;

  ///
  static Color getRandomColor() {
    final _random = math.Random();
    final _hueList = [0, 0, 0]; //Red, Green, Blue
    const _opacity = 1.0;

    for (int i = 0; i < _hueList.length; i++) {
      _hueList[i] = _random.nextInt(_maxColorRange);
    }

    final _generatedColor = Color.fromRGBO(
      _hueList[0],
      _hueList[1],
      _hueList[2],
      _opacity,
    );

    return _generatedColor;
  }

  ///
  static Color changeHue(
    Color? currentColor,
    SelectedColor colorToChange,
    int offset,
  ) {
    int _currentHue;
    int _updatedHue;
    Color _colorWithNewHue;

    switch (colorToChange) {
      case SelectedColor.red:
        _currentHue = currentColor?.red ?? 0;
        debugPrint('red: $_currentHue');
        break;
      case SelectedColor.green:
        _currentHue = currentColor?.green ?? 0;
        debugPrint('green: $_currentHue');
        break;
      case SelectedColor.blue:
        _currentHue = currentColor?.blue ?? 0;
        debugPrint('blue: $_currentHue');
        break;
    }
    _updatedHue = _currentHue + offset;

    if (_updatedHue > _maxColorRange) {
      _updatedHue = _maxColorRange;
    } else if (_updatedHue.isNegative) {
      _updatedHue = 0;
    }

    switch (colorToChange) {
      case SelectedColor.red:
        _colorWithNewHue = currentColor?.withRed(_updatedHue) ??
            const Color(0x00000000).withRed(_updatedHue);
        debugPrint('${_colorWithNewHue.red}');
        break;
      case SelectedColor.green:
        _colorWithNewHue = currentColor?.withGreen(_updatedHue) ??
            const Color(0x00000000).withGreen(_updatedHue);
        debugPrint('${_colorWithNewHue.green}');
        break;
      case SelectedColor.blue:
        _colorWithNewHue = currentColor?.withBlue(_updatedHue) ??
            const Color(0x00000000).withBlue(_updatedHue);
        debugPrint('${_colorWithNewHue.blue}');
        break;
    }

    debugPrint('-----');

    return _colorWithNewHue;
  }
}
