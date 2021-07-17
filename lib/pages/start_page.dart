

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_world/math_generator/math_generator.dart';
import 'package:math_world/math_generator/models/generator_for_first_class.dart';

class StartPage extends StatefulWidget {

  MathGenerator generator = new MathGenerator();

  StartPage();

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Container(),
    );
  }

  @override
  void initState() {
    var test = widget.generator.createTest(1,10);
     test = widget.generator.createTest(1,10);
  }
}
