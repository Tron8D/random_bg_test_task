import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_bg_test_task/random_background_color_app.dart';
import 'package:random_bg_test_task/src/utils/enum.dart';

///Main test function
void main() {
  //Test screen specification
  const _height = 900.0;
  const _width = 900.0;
  const _pixelRatio = 1.0;

  //Widget keys
  const _scaffoldKey = Key('scaffold');
  const _snackBarColorRangeKey = Key('snackBarColorRange');
  const _snackBarColorValueKey = Key('snackBarColorValue');

  ///Random double with only positive value or with positive and negative value
  double _getRandomDouble(double max, bool withNegative) {
    final _random = math.Random();
    final _randomDouble = _random.nextDouble() * max;
    double resultDouble;

    if (withNegative) {
      final _positive = _random.nextBool();
      resultDouble = _positive ? _randomDouble : -_randomDouble;
    } else {
      resultDouble = _randomDouble;
    }

    return resultDouble;
  }

  ///Random offset with only positive value or with positive and negative value
  Offset _getRandomOffset(double dxMax, double dyMax, bool withNegative) {
    final _dx = _getRandomDouble(dxMax, withNegative);
    final _dy = _getRandomDouble(dyMax, withNegative);

    return Offset(_dx, _dy);
  }

  setUp(() async {
    final _binding = TestWidgetsFlutterBinding.ensureInitialized();

    //set test screen size
    _binding.window.physicalSizeTestValue = const Size(
      _width,
      _height,
    );

    //set test screen pixels ratio
    _binding.window.devicePixelRatioTestValue = _pixelRatio;
  });

  tearDown(() async {
    final _binding = TestWidgetsFlutterBinding.ensureInitialized();

    //clear test screen size after test
    _binding.window.clearPhysicalSizeTestValue();
  });

  testWidgets('Find text.', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const RandomBackgroundColorApp());

    final _findText = find.text('Hey there');

    widgetTester.printToConsole(
      'Found text widget:\n    $_findText',
    );
    expect(_findText, findsOneWidget);
  });

  testWidgets('Tap test.', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const RandomBackgroundColorApp());

    const _testLoops = 10; //number of test cycles
    final _findScaffold = find.byKey(_scaffoldKey);
    Scaffold _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
    Color? _startColor = _scaffold.backgroundColor;
    Color? _changedColor;

    widgetTester.printToConsole(
      'Color on start app: ${_scaffold.backgroundColor}',
    );
    expect(_startColor, null);

    for (int i = 0; i < _testLoops; i++) {
      final _location = _getRandomOffset(_width - 1, _height - 1, false);
      await widgetTester.tapAt(_location);
      await widgetTester.pump();
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after ${i + 1} tap/s: ${_scaffold.backgroundColor}',
      );
      expect(_changedColor, isNot(_startColor));

      _startColor = _changedColor;
    }
  });

  group('Long press test.', () {
    testWidgets('SnackBar view test.', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const RandomBackgroundColorApp());

      final _findSnackBar = find.byKey(_snackBarColorRangeKey);

      widgetTester.printToConsole(
        'Found SnackBar before a long press: \n    $_findSnackBar',
      );
      expect(_findSnackBar, findsNothing);

      final _findScaffold = find.byKey(_scaffoldKey);
      await widgetTester.longPress(_findScaffold);

      widgetTester.printToConsole(
        'Found SnackBar after a long press: \n    $_findSnackBar',
      );
      expect(_findSnackBar, findsOneWidget);
    });

    testWidgets('Testing text in SnackBar.', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const RandomBackgroundColorApp());

      final _hueList = [
        SelectedColor.green,
        SelectedColor.blue,
        SelectedColor.red,
      ];
      String _snackBarText;

      for (int i = 0; i < _hueList.length; i++) {
        _snackBarText = 'Change ${_hueList[i].name} range.';
        final _findSnackBar = find.text(_snackBarText);

        widgetTester.printToConsole(
          'Found text in SnackBar before a long press:\n    $_findSnackBar',
        );
        expect(_findSnackBar, findsNothing);

        final _findScaffold = find.byKey(_scaffoldKey);
        await widgetTester.longPress(_findScaffold);
        await widgetTester.pumpAndSettle();

        widgetTester.printToConsole(
          'Found text in SnackBar after ${i + 1} long press:'
          '\n    $_findSnackBar\n\n',
        );
        expect(_findSnackBar, findsOneWidget);
      }
    });
  });

  testWidgets('First drag test.', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const RandomBackgroundColorApp());

    final _location = _getRandomOffset(_width - 1, _height - 1, false);
    final _offset = _getRandomOffset(_width - 1, _height - 1, true);
    final _findSnackBar = find.byKey(_snackBarColorValueKey);
    final _findScaffold = find.byKey(_scaffoldKey);
    Scaffold _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
    final _startColor = _scaffold.backgroundColor;
    Color? _changedColor;

    widgetTester.printToConsole(
      'Color on start app: $_startColor',
    );
    expect(_startColor, null);
    expect(_findSnackBar, findsNothing);

    await widgetTester.dragFrom(
      _location,
      _offset,
    );
    await widgetTester.pumpAndSettle();
    _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
    _changedColor = _scaffold.backgroundColor;

    widgetTester.printToConsole(
      'Color after drag: $_changedColor',
    );
    expect(_changedColor, isNot(_startColor));
    expect(_findSnackBar, findsOneWidget);
  });

  group('Change hue value and view SnackBar after tap', () {
    testWidgets('Red range test.', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const RandomBackgroundColorApp());

      final _location = _getRandomOffset(_width - 1, _height - 1, false);
      final _offset = _getRandomOffset(_width - 1, _height - 1, true);
      final _findSnackBar = find.byKey(_snackBarColorValueKey);
      final _findScaffold = find.byKey(_scaffoldKey);
      Scaffold _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      Color? _startColor = _scaffold.backgroundColor;
      Color? _changedColor;
      widgetTester.printToConsole(
        'Color on start app: $_startColor',
      );
      expect(_startColor, null);
      expect(_findSnackBar, findsNothing);

      await widgetTester.tap(_findScaffold);
      await widgetTester.pump();
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after 1 tap: $_changedColor',
      );
      expect(_changedColor, isNot(null));
      expect(_findSnackBar, findsNothing);

      _startColor = _changedColor;
      await widgetTester.dragFrom(
        _location,
        _offset,
      );
      await widgetTester.pumpAndSettle(const Duration(milliseconds: 600));
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after drag: $_changedColor',
      );
      expect(_changedColor?.red, isNot(_startColor?.red));
      expect(_changedColor?.green, _startColor?.green);
      expect(_changedColor?.blue, _startColor?.blue);
      expect(_findSnackBar, findsOneWidget);
    });

    testWidgets('Green range test.', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const RandomBackgroundColorApp());

      final _location = _getRandomOffset(_width - 1, _height - 1, false);
      final _offset = _getRandomOffset(_width - 1, _height - 1, true);
      final _findSnackBar = find.byKey(_snackBarColorValueKey);
      final _findScaffold = find.byKey(_scaffoldKey);
      Scaffold _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      Color? _startColor = _scaffold.backgroundColor;
      Color? _changedColor;

      widgetTester.printToConsole(
        'Color on start app: $_startColor',
      );
      expect(_startColor, null);
      expect(_findSnackBar, findsNothing);

      await widgetTester.tap(_findScaffold);
      await widgetTester.pump();
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after 1 tap: $_changedColor',
      );
      expect(_changedColor, isNot(null));
      expect(_findSnackBar, findsNothing);

      _startColor = _changedColor;
      await widgetTester.longPress(_findScaffold);
      await widgetTester.pumpAndSettle();
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after 1 long press: $_changedColor',
      );
      expect(_changedColor, _startColor);
      expect(_findSnackBar, findsNothing);

      await widgetTester.dragFrom(
        _location,
        _offset,
      );
      await widgetTester.pumpAndSettle(const Duration(milliseconds: 600));
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after drag: $_changedColor',
      );
      expect(_changedColor?.red, _startColor?.red);
      expect(_changedColor?.green, isNot(_startColor?.green));
      expect(_changedColor?.blue, _startColor?.blue);
      expect(_findSnackBar, findsOneWidget);
    });

    testWidgets('Blue range test.', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const RandomBackgroundColorApp());

      final _location = _getRandomOffset(_width - 1, _height - 1, false);
      final _offset = _getRandomOffset(_width - 1, _height - 1, true);
      final _findSnackBar = find.byKey(_snackBarColorValueKey);
      final _findScaffold = find.byKey(_scaffoldKey);
      Scaffold _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      Color? _startColor = _scaffold.backgroundColor;
      Color? _changedColor;

      widgetTester.printToConsole(
        'Color on start app: $_startColor',
      );
      expect(_startColor, null);
      expect(_findSnackBar, findsNothing);

      await widgetTester.tap(_findScaffold);
      await widgetTester.pump();
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after 1 tap: $_changedColor',
      );
      expect(_changedColor, isNot(null));
      expect(_findSnackBar, findsNothing);

      _startColor = _changedColor;

      for (int i = 0; i < 2; i++) {
        await widgetTester.longPress(_findScaffold);
        await widgetTester.pumpAndSettle();
        _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
        _changedColor = _scaffold.backgroundColor;

        widgetTester.printToConsole(
          'Color after ${i + 1} long press: $_changedColor',
        );
        expect(_changedColor, _startColor);
        expect(_findSnackBar, findsNothing);
      }

      await widgetTester.dragFrom(
        _location,
        _offset,
      );
      await widgetTester.pumpAndSettle(const Duration(milliseconds: 600));
      _scaffold = widgetTester.widget(_findScaffold) as Scaffold;
      _changedColor = _scaffold.backgroundColor;

      widgetTester.printToConsole(
        'Color after drag: $_changedColor',
      );
      expect(_changedColor?.red, _startColor?.red);
      expect(_changedColor?.green, _startColor?.green);
      expect(_changedColor?.blue, isNot(_startColor?.blue));
      expect(_findSnackBar, findsOneWidget);
    });
  });
}
