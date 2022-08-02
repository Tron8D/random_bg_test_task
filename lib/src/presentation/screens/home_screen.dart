import 'package:flutter/material.dart';
import 'package:random_bg_test_task/src/utils/custom_color_changer.dart';
import 'package:random_bg_test_task/src/utils/enum.dart';

///Screen display the text "Hey there" in the middle of the screen and
///after tapping anywhere on the screen, a background color change to a
///randomly generated color.
///
///Tap - random background color
///Drag up\down - change hue range
///Long press - change color channel
class HomeScreen extends StatefulWidget {
  ///Constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

///Screen state
class _HomeScreenState extends State<HomeScreen> {
  final _hueList = [
    SelectedColor.red,
    SelectedColor.green,
    SelectedColor.blue,
  ];

  Color? _backgroundColor;
  int? _hueIndex;

  void _setBackgroundColor(Color? currentColor) {
    setState(() {
      _backgroundColor = currentColor;
    });
  }

  void _onTap() {
    _setBackgroundColor(CustomColorChanger.getRandomColor());
  }

  void _onLongPress() {
    setState(() {
      _hueIndex ??= 0;
      _hueIndex = (_hueIndex! + 1) % _hueList.length;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key('snackBarColorRange'),
          duration: const Duration(milliseconds: 600),
          content: Text(
            'Change ${_hueList[_hueIndex ?? 0].name} range.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _backgroundColor = CustomColorChanger.changeHue(
        _backgroundColor,
        _hueList[_hueIndex ?? 0],
        details.delta.dy.toInt(),
      );
    });
  }

  void _onPanEnd(DragEndDetails _) {
    final _hueRangeName = _hueList[_hueIndex ?? 0].name;
    String? _hueCurrentValue;
    switch (_hueList[_hueIndex ?? 0]) {
      case SelectedColor.red:
        _hueCurrentValue = _backgroundColor?.red.toString();
        break;
      case SelectedColor.green:
        _hueCurrentValue = _backgroundColor?.green.toString();
        break;
      case SelectedColor.blue:
        _hueCurrentValue = _backgroundColor?.blue.toString();
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: const Key('snackBarColorValue'),
        duration: const Duration(milliseconds: 600),
        content: Text(
          '$_hueRangeName: $_hueCurrentValue.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('scaffold'),
      backgroundColor: _backgroundColor,
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          const Center(child: Text('Hey there')),
          GestureDetector(
            onTap: _onTap,
            onPanUpdate: _onPanUpdate,
            onLongPress: _onLongPress,
            onPanEnd: _onPanEnd,
          ),
        ],
      ),
    );
  }
}
