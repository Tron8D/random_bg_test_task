import 'package:flutter/material.dart';

import 'package:random_bg_test_task/src/presentation/screens/home_screen.dart';

///General app class
class RandomBackgroundColorApp extends StatelessWidget{
  ///Constructor
  const RandomBackgroundColorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),);
  }
}
