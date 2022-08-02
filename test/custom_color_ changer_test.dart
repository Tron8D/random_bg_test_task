// ignore_for_file: file_names

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:random_bg_test_task/src/utils/custom_color_changer.dart';
import 'package:random_bg_test_task/src/utils/enum.dart';

void main() {
  const _whiteColor = Color.fromRGBO(255, 255, 255, 1);
  const _blackColor = Color.fromRGBO(0, 0, 0, 1);
  final _random = math.Random();
  final _offsetInRange = _random.nextInt(255);
  final _offsetOverRange = _random.nextInt(255) + 255;

  test('Test getRandomColor func.', () {
    const _testLoops = 10;
    Color _colorOne = CustomColorChanger.getRandomColor();
    Color _colorTwo;
    Color _colorThree;

    for (int i = 0; i < _testLoops; i++) {
      _colorTwo = CustomColorChanger.getRandomColor();
      _colorThree = CustomColorChanger.getRandomColor();

      expect(
        _colorOne,
        isNot(_colorTwo),
      );
      expect(
        _colorOne,
        isNot(_colorThree),
      );
      expect(
        _colorTwo,
        isNot(_colorThree),
      );

      _colorOne = _colorThree;
    }
  });

  group('Test change changeHue func.', () {
    group('Red channel test', () {
      test('Positive offset', () {
        const _startBackgroundColor = _whiteColor;
        const _colorToChange = SelectedColor.red;
        final _expectedHueValue = _startBackgroundColor.red - _offsetInRange;
        Color _changedColor;
        int _funcOutValue;

        _changedColor = CustomColorChanger.changeHue(
          _startBackgroundColor,
          _colorToChange,
          _offsetInRange,
        );
        _funcOutValue = _changedColor.red;

        expect(
          _expectedHueValue,
          _funcOutValue,
        );
        expect(
          _startBackgroundColor.green,
          _changedColor.green,
        );
        expect(
          _startBackgroundColor.blue,
          _changedColor.blue,
        );
        expect(
          _startBackgroundColor.opacity,
          _changedColor.opacity,
        );
      });

      test('Negative offset', () {
        const _startBackgroundColor = _blackColor;
        const _colorToChange = SelectedColor.red;
        final _expectedHueValue = _startBackgroundColor.red + _offsetInRange;
        late Color _changedColor;
        int _funcOutValue;

        _changedColor = CustomColorChanger.changeHue(
          _startBackgroundColor,
          _colorToChange,
          -_offsetInRange,
        );
        _funcOutValue = _changedColor.red;

        expect(
          _expectedHueValue,
          _funcOutValue,
        );
        expect(
          _startBackgroundColor.green,
          _changedColor.green,
        );
        expect(
          _startBackgroundColor.blue,
          _changedColor.blue,
        );
        expect(
          _startBackgroundColor.opacity,
          _changedColor.opacity,
        );
      });

      group('Out of range.', () {
        test('Less than 0.', () {
          const _startBackgroundColor = _whiteColor;
          const _colorToChange = SelectedColor.red;
          const _expectedHueValue = 0;
          late Color _changedColor;
          int _funcOutValue;

          _changedColor = CustomColorChanger.changeHue(
            _startBackgroundColor,
            _colorToChange,
            _offsetOverRange,
          );
          _funcOutValue = _changedColor.red;

          expect(
            _expectedHueValue,
            _funcOutValue,
          );
          expect(
            _startBackgroundColor.green,
            _changedColor.green,
          );
          expect(
            _startBackgroundColor.blue,
            _changedColor.blue,
          );
          expect(
            _startBackgroundColor.opacity,
            _changedColor.opacity,
          );
        });

        test('Over than 255.', () {
          const _startBackgroundColor = _blackColor;
          const _colorToChange = SelectedColor.red;
          const _expectedHueValue = 255;
          late Color _changedColor;
          int _funcOutValue;

          _changedColor = CustomColorChanger.changeHue(
            _startBackgroundColor,
            _colorToChange,
            -_offsetOverRange,
          );
          _funcOutValue = _changedColor.red;

          expect(
            _expectedHueValue,
            _funcOutValue,
          );
          expect(
            _startBackgroundColor.green,
            _changedColor.green,
          );
          expect(
            _startBackgroundColor.blue,
            _changedColor.blue,
          );
          expect(
            _startBackgroundColor.opacity,
            _changedColor.opacity,
          );
        });
      });
    });

    group('Green channel test', () {
      test('Positive offset', () {
        const _startBackgroundColor = _whiteColor;
        const _colorToChange = SelectedColor.green;
        final _expectedHueValue = _startBackgroundColor.green - _offsetInRange;
        late Color _changedColor;
        int _funcOutValue;

        _changedColor = CustomColorChanger.changeHue(
          _startBackgroundColor,
          _colorToChange,
          _offsetInRange,
        );
        _funcOutValue = _changedColor.green;

        expect(
          _startBackgroundColor.red,
          _changedColor.red,
        );
        expect(
          _expectedHueValue,
          _funcOutValue,
        );
        expect(
          _startBackgroundColor.blue,
          _changedColor.blue,
        );
        expect(
          _startBackgroundColor.opacity,
          _changedColor.opacity,
        );
      });

      test('Negative offset', () {
        const _startBackgroundColor = _blackColor;
        const _colorToChange = SelectedColor.green;
        final _expectedHueValue = _startBackgroundColor.green + _offsetInRange;
        late Color _changedColor;
        int _funcOutValue;

        _changedColor = CustomColorChanger.changeHue(
          _startBackgroundColor,
          _colorToChange,
          -_offsetInRange,
        );
        _funcOutValue = _changedColor.green;

        expect(
          _startBackgroundColor.red,
          _changedColor.red,
        );
        expect(
          _expectedHueValue,
          _funcOutValue,
        );
        expect(
          _startBackgroundColor.blue,
          _changedColor.blue,
        );
        expect(
          _startBackgroundColor.opacity,
          _changedColor.opacity,
        );
      });

      group('Out of range.', () {
        test('Less than 0.', () {
          const _startBackgroundColor = _whiteColor;
          const _colorToChange = SelectedColor.green;
          const _expectedHueValue = 0;
          late Color _changedColor;
          int _funcOutValue;

          _changedColor = CustomColorChanger.changeHue(
            _startBackgroundColor,
            _colorToChange,
            _offsetOverRange,
          );
          _funcOutValue = _changedColor.green;

          expect(
            _startBackgroundColor.red,
            _changedColor.red,
          );
          expect(
            _expectedHueValue,
            _funcOutValue,
          );
          expect(
            _startBackgroundColor.blue,
            _changedColor.blue,
          );
          expect(
            _startBackgroundColor.opacity,
            _changedColor.opacity,
          );
        });

        test('Over than 255.', () {
          const _startBackgroundColor = _blackColor;
          const _colorToChange = SelectedColor.green;
          const _expectedHueValue = 255;
          late Color _changedColor;
          int _funcOutValue;

          _changedColor = CustomColorChanger.changeHue(
            _startBackgroundColor,
            _colorToChange,
            -_offsetOverRange,
          );
          _funcOutValue = _changedColor.green;

          expect(
            _startBackgroundColor.red,
            _changedColor.red,
          );
          expect(
            _expectedHueValue,
            _funcOutValue,
          );
          expect(
            _startBackgroundColor.blue,
            _changedColor.blue,
          );
          expect(
            _startBackgroundColor.opacity,
            _changedColor.opacity,
          );
        });
      });
    });

    group('Blue channel test', () {
      test('Positive offset', () {
        const _startBackgroundColor = _whiteColor;
        const _colorToChange = SelectedColor.blue;
        final _expectedHueValue = _startBackgroundColor.blue - _offsetInRange;
        late Color _changedColor;
        int _funcOutValue;

        _changedColor = CustomColorChanger.changeHue(
          _startBackgroundColor,
          _colorToChange,
          _offsetInRange,
        );
        _funcOutValue = _changedColor.blue;

        expect(
          _startBackgroundColor.red,
          _changedColor.red,
        );
        expect(
          _startBackgroundColor.green,
          _changedColor.green,
        );
        expect(
          _expectedHueValue,
          _funcOutValue,
        );
        expect(
          _startBackgroundColor.opacity,
          _changedColor.opacity,
        );
      });

      test('Negative offset', () {
        const _startBackgroundColor = _blackColor;
        const _colorToChange = SelectedColor.blue;
        final _expectedHueValue = _startBackgroundColor.blue + _offsetInRange;
        late Color _changedColor;
        int _funcOutValue;

        _changedColor = CustomColorChanger.changeHue(
          _startBackgroundColor,
          _colorToChange,
          -_offsetInRange,
        );
        _funcOutValue = _changedColor.blue;

        expect(
          _startBackgroundColor.red,
          _changedColor.red,
        );
        expect(
          _startBackgroundColor.green,
          _changedColor.green,
        );
        expect(
          _expectedHueValue,
          _funcOutValue,
        );
        expect(
          _startBackgroundColor.opacity,
          _changedColor.opacity,
        );
      });

      group('Out of range.', () {
        test('Less than 0.', () {
          const _startBackgroundColor = _whiteColor;
          const _colorToChange = SelectedColor.blue;
          const _expectedHueValue = 0;
          late Color _changedColor;
          int _funcOutValue;

          _changedColor = CustomColorChanger.changeHue(
            _startBackgroundColor,
            _colorToChange,
            _offsetOverRange,
          );
          _funcOutValue = _changedColor.blue;

          expect(
            _startBackgroundColor.red,
            _changedColor.red,
          );
          expect(
            _startBackgroundColor.green,
            _changedColor.green,
          );
          expect(
            _expectedHueValue,
            _funcOutValue,
          );
          expect(
            _startBackgroundColor.opacity,
            _changedColor.opacity,
          );
        });

        test('Over than 255.', () {
          const _startBackgroundColor = _blackColor;
          const _colorToChange = SelectedColor.blue;
          const _expectedHueValue = 255;
          late Color _changedColor;
          int _funcOutValue;

          _changedColor = CustomColorChanger.changeHue(
            _startBackgroundColor,
            _colorToChange,
            -_offsetOverRange,
          );
          _funcOutValue = _changedColor.blue;

          expect(
            _startBackgroundColor.red,
            _changedColor.red,
          );
          expect(
            _startBackgroundColor.green,
            _changedColor.green,
          );
          expect(
            _expectedHueValue,
            _funcOutValue,
          );
          expect(
            _startBackgroundColor.opacity,
            _changedColor.opacity,
          );
        });
      });
    });
  });
}
