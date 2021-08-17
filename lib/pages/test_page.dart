import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/localization/language_constants.dart';

import '../math_generator/math_generator.dart';
import '../math_generator/models/question.dart';
import '../math_generator/models/test.dart';

class TestPage extends StatefulWidget {
  MathGenerator generator = new MathGenerator();
  late Test test;
  late List<Question> listQuestions;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  var _value;

  @override
  void initState() {
    widget.test = widget.generator.createTest(2, 2);
    widget.listQuestions = widget.test.getListQuestions();
    _tabController = TabController(
        initialIndex: 0, length: widget.listQuestions.length, vsync: this);

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    switch (_tabController.index) {
      case 0:
        break;
      case 1:
        //_tabController.animateTo(5);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Column(
          children: [
            Text("Test page"),
          ],
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          unselectedLabelColor: Colors.green,
          labelColor: Colors.red,
          tabs: widget.listQuestions
              .asMap()
              .keys
              .map((question) => Tab(
                    text: "Question ${++question}",
                  ))
              .toList(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
        child: Column(
          children: [
            Expanded(
              flex: 93,
              child: TabBarView(
                controller: _tabController,
                children: widget.listQuestions
                    .map(
                      (question) => Center(
                        child: widgetTestQuestion(question),
                      ),
                    )
                    .toList(),
              ),
            ),
            // Visibility(
            //   child: Expanded(
            //     flex: 7,
            //     child: Container(
            //       margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
            //       child: ElevatedButton.icon(
            //         style: TextButton.styleFrom(
            //           backgroundColor: Theme.of(context).accentColor,
            //         ),
            //         onPressed: () {
            //
            //         },
            //         icon: Icon(Icons.add, size: 20),
            //         label: Text(getTranslated(context, "new_schedule")??" ",style: TextStyle(color: Theme.of(context).buttonColor),),
            //       ),
            //     ),
            //   ),
            //   visible: WorkerMainPage.isManagerStatus,
            // ),
          ],
        ),
      ),
    );
  }

  Widget widgetTestQuestion(Question question) {
    var now = new DateTime.now();
    Random rnd = new Random(now.millisecondsSinceEpoch);
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/il_images/il${rnd.nextInt(9) + 1}.png"),
                //image: AssetImage("assets/images/il_images/il9.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(flex: 7, child: getQuestionWidget(question)),
        SizedBox(height: 10),
      ],
    );
  }

  Widget getQuestionWidget(Question question) {
    if (question.exercise != null) {
      if (widget.test.numberClass == 1)
        return getQuestionWidgetForFirstClass(question);
      else {
        switch (question.type) {
          case TYPE_EXERCISE:
            {
              return getWidgetQuestion(question);
            }

          case TYPE_COMPARISON_NUMBERS:
            {
              return getWidgetQuestion(question);
            }

          case TYPE_WORD_NUMBER:
            {
              return getWidgetWordNumberQuestion(question);
            }

          case TYPE_WORD_AND_NUMBER:
            {
              return getWidgetWordsAndNumbersQuestion(question);
            }
        }
      }
    }
    return getWidgetQuestionInsertNumbers(question);
  }

  Widget getWidgetQuestion(Question question) {
    var answers = question.listAnswers ?? [];
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(question.exercise!,
                style: GoogleFonts.courgette(
                  //textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 30,
                  color: Colors.white
                  // fontWeight: FontWeight.w700,
                  //fontStyle: FontStyle.italic,
                )),
            for (int i = 0; i <= answers.length - 1; i++)
              Expanded(
                  child: ListTile(
                title: Text(
                  answers[i],
                  style: GoogleFonts.courgette(
                    //textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 30,
                      color: Colors.white
                    // fontWeight: FontWeight.w700,
                    //fontStyle: FontStyle.italic,
                  ),
                ),
                leading: Radio(
                  value: answers[i],
                  groupValue: _value,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              )),
          ],
        ));
  }

  Widget getWidgetWordNumberQuestion(Question question) {
    var answers = question.listAnswers ?? [];
   var wordTranslation = MathGenerator.listStringNumbers[int.parse(question.exercise!)]??"";
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              getTranslated(context, wordTranslation)??"",
                style: GoogleFonts.courgette(
                  //textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 30,
                    color: Colors.white
                  // fontWeight: FontWeight.w700,
                  //fontStyle: FontStyle.italic,
                )
            ),
            for (int i = 0; i <= answers.length - 1; i++)
              Expanded(
                  child: ListTile(
                title: Text(
                  answers[i],
                    style: GoogleFonts.courgette(
                      //textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 30,
                        color: Colors.white
                      // fontWeight: FontWeight.w700,
                      //fontStyle: FontStyle.italic,
                    )
                ),
                leading: Radio(
                  value: answers[i],
                  groupValue: _value,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              )),
          ],
        ));
  }

  Widget getWidgetWordsAndNumbersQuestion(Question question) {
    var answers = question.listAnswers ?? [];
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                getStringWordsAndNumbersQuestion(question.exercise),
                style: GoogleFonts.courgette(
                  //textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 30,
                    color: Colors.white
                  // fontWeight: FontWeight.w700,
                  //fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            for (int i = 0; i <= answers.length - 1; i++)
              Expanded(child: ListTile(
                title: Text(answers[i],
                    style: GoogleFonts.courgette(
                      //textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 30,
                        color: Colors.white
                      // fontWeight: FontWeight.w700,
                      //fontStyle: FontStyle.italic,
                    )),
                leading: Radio(
                  value: answers[i],
                  groupValue: _value,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              )),
          ],
        ));
  }

  String getStringWordsAndNumbersQuestion(String? exercise) {
    String result = "";
    if ((exercise?.length ?? 0 > 3) == true) {
      result = " ${(int.parse(exercise!) / 1000)} " +
          (getTranslated(context, "thousand") ?? "");
    }
    if (exercise!.length >= 3) {
      result = result +
          " ${exercise[(exercise.length - 3)]} " +
          (getTranslated(context, "hundreds") ?? "");
    }

    result = result +
        " ${exercise[(exercise.length - 2)]} " +
        (getTranslated(context, "tens") ?? "");
    result = result +
        " ${exercise[(exercise.length - 1)]} " +
        (getTranslated(context, "units") ?? "");
    return result;
  }

  Widget getWidgetQuestionInsertNumbers(Question question) {
    return Container(
      child: Scrollbar(
        child: Column(
          children: getRows(question),
        ),
      ),
    );
  }

  List<Widget> getRows(Question question) {
    int temp = 0;
    List<Widget> rows = [];
    for (int i = 0; i < 10; i++) {
      rows.add(
        Expanded(
            child: Container(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Row(
              children: getQuestionRaw([
            question.insertNumbersExercise![temp++],
            question.insertNumbersExercise![temp++],
            question.insertNumbersExercise![temp++],
            question.insertNumbersExercise![temp++],
            question.insertNumbersExercise![temp++]
          ])),
        )),
      );
    }
    return rows;
  }

  Widget getQuestionWidgetForFirstClass(Question question) {
    var answers = question.listAnswers ?? [];
    var indexOperand1 = int.parse(question.exercise!.split(' ')[0]) - 1;
    var operator = question.exercise!.split(' ')[1];
    var indexOperand2 = int.parse(question.exercise!.split(' ')[2]) - 1;

    if (question.type == TYPE_EXERCISE &&
        int.parse(question.answer!) <= 10 &&
        int.parse(question.answerNotCorrect1!) <= 10 &&
        int.parse(question.answerNotCorrect2!) <= 10 &&
        int.parse(question.answerNotCorrect3!) <= 10 &&
        (indexOperand1 + 1) <= 9 &&
        (indexOperand1 + 1) > 0 &&
        (indexOperand2 + 1) <= 9 &&
        (indexOperand2 + 1) > 0) {
      return Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      widget.test.listStringsImagesQuestions[
                                          indexOperand1]),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                operator,
                                style: GoogleFonts.courgette(
                                  //textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 30,
                                    color: Colors.white
                                  // fontWeight: FontWeight.w700,
                                  //fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      widget.test.listStringsImagesQuestions[
                                          indexOperand2]),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))),
              //////////////////////////////////////////////////////////////////
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      for (int i = 0; i <= answers.length - 1; i++)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: ListTile(
                              title: Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          widget.test.listStringsImagesAnswers[
                                              int.parse(answers[i])]),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              leading: Radio(
                                value: answers[i],
                                groupValue: _value,
                                activeColor: Colors.red,
                                hoverColor: Colors.white,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                    ],
                  ))
            ],
          ));
    } else {
      return Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                question.exercise!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white, fontSize: 36),
              ),
              for (int i = 0; i <= answers.length - 1; i++)
                Expanded(
                  child: ListTile(
                    title: Text(
                      answers[i],
                      style: GoogleFonts.courgette(
                        //textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30,
                          color: Colors.white
                        // fontWeight: FontWeight.w700,
                        //fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading: Radio(
                      value: answers[i],
                      groupValue: _value,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                )
            ],
          ));
    }
  }

  List<Widget> getQuestionRaw(List<int?> list) {
    List<Widget> rowNames = [];
    list.forEach((element) {
      rowNames.add(Expanded(
          child: Container(
              alignment: Alignment.center,
              child: element == null
                  ? TextField(
                      // controller: nameController,
                style: GoogleFonts.courgette(
                  //textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 30,
                    color: Colors.white
                  // fontWeight: FontWeight.w700,
                  //fontStyle: FontStyle.italic,
                ) ,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Text(element.toString(),style: GoogleFonts.courgette(
                //textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 30,
                  color: Colors.white
                // fontWeight: FontWeight.w700,
                //fontStyle: FontStyle.italic,
              )))));
    });
    return rowNames;
  }
}

//   }
// }
