import 'package:flutter/material.dart';
import 'package:random_bg_test_task/src/presentation/model/custom_color_changer.dart';
import 'package:random_bg_test_task/src/utils/enums.dart';

///Screen display the text "Hey there" in the middle of the screen and
///after tapping anywhere on the screen, a background color change to a
///randomly generated color
class HomeScreen extends StatefulWidget {
  int _index = 0;

  ///Constructor
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

///Screen state
class _HomeScreenState extends State<HomeScreen> {
  final List<SelectedColor> _hueList = [
    SelectedColor.red,
    SelectedColor.green,
    SelectedColor.blue,
  ];
  Color? _backgroundColor;
  // late int _hueIndex;

  void setColor(Color? currentColor) {
    setState(() {
      _backgroundColor = currentColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          const Center(child: Text('Hey there')),
          GestureDetector(
            onTap: () {
              setColor(CustomColorChanger.getRandomColor());
            },
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                _backgroundColor = CustomColorChanger.changeHue(
                  _backgroundColor,
                  _hueList[widget._index],
                  details.delta.dy.toInt(),
                );
              });
            },
            onDoubleTap: () {
              setState(() {
                widget._index = (widget._index + 1) % _hueList.length;
                debugPrint(widget._index.toString());
              });
            },
          ),
        ],
      ),
    );
  }
}
