import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/models/class_settings.dart';
import 'package:math_world/widgets/custom_radio_widget.dart';

import '../math_generator/math_generator.dart';
import '../math_generator/models/question.dart';
import '../math_generator/models/test.dart';

class TestPage extends StatefulWidget {
  MathGenerator generator = new MathGenerator();
  late Test test;
  List<Question> listQuestions = [];
  bool buttonVisibility = false;
  bool isCheckTest = false;
  ClassSettings classSettings;

  TestPage({required this.classSettings});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    var now = new DateTime.now();
    Random rnd = new Random(now.millisecondsSinceEpoch);
    widget.test = widget.generator.createTest(widget.classSettings);
    widget.listQuestions = widget.test.getListQuestions();
    widget.listQuestions.forEach((element) {
      element.questionImage =
          "assets/images/il_images/il${rnd.nextInt(9) + 1}.png";
    });
    _tabController = TabController(
        initialIndex: 0, length: widget.listQuestions.length + 1, vsync: this);

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.index == (widget.listQuestions.length))
      setState(() {
        widget.buttonVisibility = true;
      });
    if (_tabController.index != (widget.listQuestions.length) &&
        widget.buttonVisibility == true)
      setState(() {
        widget.buttonVisibility = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff256E59),
        title: Row(
          children: [
            Text(
              widget.isCheckTest == true
                  ? getTranslated(context, "correct_answer") ??
                      "" +
                          "s ${widget.listQuestions.where((q) => q.answerFromUserIsCorrect == true).toList().length}"
                  : "Answered ${widget.listQuestions.where((q) => q.isAnswered == true).toList().length} from ${widget.listQuestions.length}",
              style: GoogleFonts.courgette(color: Colors.white),
            ),
            //Text("${widget.listQuestions.length}"),
          ],
        ),
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            unselectedLabelColor: Colors.green,
            labelColor: Colors.red,
            tabs: getTabs()),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Expanded(
                flex: 90,
                child: TabBarView(
                    controller: _tabController, children: getQuestionWidgets()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetTestQuestion(Question question) {
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
                image: AssetImage(question.questionImage),
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
          case TYPE_FROM_MULTIPLICATION_TABLE:
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
                    color: widget.isCheckTest &&
                            question.answerFromUserIsCorrect == false
                        ? Colors.red
                        : Colors.white
                    // fontWeight: FontWeight.w700,
                    //fontStyle: FontStyle.italic,
                    )),
            for (int i = 0; i <= answers.length - 1; i++)
              Expanded(
                  child: ListTile(
                title: Text(
                  widget.isCheckTest == true
                      ? answers[i] == question.answer
                          ? answers[i] +
                              "    ${getTranslated(context, "correct_answer") ?? ""}"
                          : answers[i]
                      : answers[i],
                  style: GoogleFonts.courgette(
                      fontSize: 30,
                      color: getColorForAnswer(question, answers[i])),
                ),
                leading: CustomRadioWidget(
                  value: answers[i],
                  groupValue: question.answerOfUser,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      question.answerOfUser = value as String?;
                      if (question.answer == value)
                        question.answerFromUserIsCorrect = true;
                      question.isAnswered = true;
                    });
                  },
                ),
              )),
          ],
        ));
  }

  Widget getWidgetWordNumberQuestion(Question question) {
    var answers = question.listAnswers ?? [];
    var wordTranslation =
        MathGenerator.listStringNumbers[int.parse(question.exercise!)] ?? "";
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(getTranslated(context, wordTranslation) ?? "",
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
                  widget.isCheckTest == true
                      ? answers[i] == question.answer
                          ? answers[i] +
                              "    ${getTranslated(context, "correct_answer") ?? ""}"
                          : answers[i]
                      : answers[i],
                  style: GoogleFonts.courgette(
                      //textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 30,
                      color: getColorForAnswer(question, answers[i])
                      // fontWeight: FontWeight.w700,
                      //fontStyle: FontStyle.italic,
                      ),
                ),
                leading: CustomRadioWidget(
                  value: answers[i],
                  groupValue: question.answerOfUser,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      question.answerOfUser = value as String?;
                      if (question.answer == value)
                        question.answerFromUserIsCorrect = true;
                      question.isAnswered = true;
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
              Expanded(
                  child: ListTile(
                title: Text(
                  widget.isCheckTest == true
                      ? answers[i] == question.answer
                          ? answers[i] +
                              "    ${getTranslated(context, "correct_answer") ?? ""}"
                          : answers[i]
                      : answers[i],
                  style: GoogleFonts.courgette(
                      //textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 30,
                      color: getColorForAnswer(question, answers[i])
                      // fontWeight: FontWeight.w700,
                      //fontStyle: FontStyle.italic,
                      ),
                ),
                leading: CustomRadioWidget(
                  value: answers[i],
                  groupValue: question.answerOfUser,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      question.answerOfUser = value as String?;
                      if (question.answer == value)
                        question.answerFromUserIsCorrect = true;
                      question.isAnswered = true;
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
    int indexControllers = 0;
    List<Widget> rows = [];
    for (int i = 0; i < 10; i++) {
      var listToRow = [
        question.insertNumbersExercise![temp++],
        question.insertNumbersExercise![temp++],
        question.insertNumbersExercise![temp++],
        question.insertNumbersExercise![temp++],
        question.insertNumbersExercise![temp++]
      ];

      rows.add(
        Expanded(
            child: Container(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Row(
              children: getQuestionRaw(listToRow, question, indexControllers)),
        )),
      );
      listToRow.forEach((element) {
        if (element == null) indexControllers++;
      });
    }
    return rows;
  }

  Widget getQuestionWidgetForFirstClass(Question question) {
    var answers = question.listAnswers ?? [];
    var indexOperand1 = int.parse(question.exercise!.split(' ')[0]) - 1;
    var operator = question.exercise!.split(' ')[1];
    var indexOperand2 = int.parse(question.exercise!.split(' ')[2]) - 1;

    // if (question.type == TYPE_EXERCISE &&
    //     int.parse(question.answer!) <= 10 &&
    //     int.parse(question.answerNotCorrect1!) <= 10 &&
    //     int.parse(question.answerNotCorrect2!) <= 10 &&
    //     int.parse(question.answerNotCorrect3!) <= 10 &&
    //     (indexOperand1 + 1) <= 9 &&
    //     (indexOperand1 + 1) > 0 &&
    //     (indexOperand2 + 1) <= 9 &&
    //     (indexOperand2 + 1) > 0) {
    //   return Container(
    //       alignment: Alignment.center,
    //       child: Column(
    //         children: <Widget>[
    //           Expanded(
    //               flex: 2,
    //               child: Container(
    //                   margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
    //                   child: Row(
    //                     children: [
    //                       Expanded(
    //                         child: Container(
    //                           decoration: BoxDecoration(
    //                             image: DecorationImage(
    //                               image: AssetImage(
    //                                   widget.test.listStringsImagesQuestions[
    //                                       indexOperand1]),
    //                               fit: BoxFit.fitHeight,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Container(
    //                           alignment: Alignment.center,
    //                           child: Text(
    //                             operator,
    //                             style: GoogleFonts.courgette(
    //                                 //textStyle: Theme.of(context).textTheme.headline4,
    //                                 fontSize: 30,
    //                                 color: Colors.white
    //                                 // fontWeight: FontWeight.w700,
    //                                 //fontStyle: FontStyle.italic,
    //                                 ),
    //                           ),
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Container(
    //                           decoration: BoxDecoration(
    //                             image: DecorationImage(
    //                               image: AssetImage(
    //                                   widget.test.listStringsImagesQuestions[
    //                                       indexOperand2]),
    //                               fit: BoxFit.fitHeight,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ))),
    //           //////////////////////////////////////////////////////////////////
    //           Expanded(
    //               flex: 8,
    //               child: Column(
    //                 children: [
    //                   for (int i = 0; i <= answers.length - 1; i++)
    //                     Expanded(
    //                       child: Padding(
    //                         padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
    //                         child: ListTile(
    //                           title: Expanded(
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                 image: DecorationImage(
    //                                   image: AssetImage(
    //                                       widget.test.listStringsImagesAnswers[
    //                                           int.parse(answers[i])]),
    //                                   fit: BoxFit.fitHeight,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           leading: Radio(
    //                             value: answers[i],
    //                             groupValue: question.answerOfUser,
    //                             activeColor: Colors.red,
    //                             hoverColor: Colors.white,
    //                             onChanged: (value) {
    //                               setState(() {
    //                                 question.answerOfUser = value as String?;
    //                                 if (question.answer == value)
    //                                   question.answerFromUserIsCorrect = true;
    //                                 question.isAnswered = true;
    //                               });
    //                             },
    //                           ),
    //                         ),
    //                       ),
    //                     )
    //                 ],
    //               ))
    //         ],
    //       ));
    // } else {
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
                  leading: CustomRadioWidget(
                    value: answers[i],
                    groupValue: question.answerOfUser,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        question.answerOfUser = value as String?;
                        if (question.answer == value)
                          question.answerFromUserIsCorrect = true;
                        question.isAnswered = true;
                      });
                    },
                  ),
                ),
              )
          ],
        ));
    //  }
  }

  List<Widget> getQuestionRaw(
      List<int?> list, Question question, int indexControllers) {
    List<Widget> rowNames = [];
    list.forEach((element) {
      rowNames.add(Expanded(
          child: Container(
              alignment: Alignment.center,
              child: element == null
                  ? TextField(
                      controller:
                          question.insertNumberControllers[indexControllers++],
                      onChanged: (value) {
                        setState(() {
                          question.answerFromUserIsCorrect =
                              question.checkInsertNumbersQuestionAnswers();
                          question.isAnswered =
                              question.checkInsertNumbersQuestionIsAnswered();
                        });
                      },
                      style: GoogleFonts.courgette(
                          color: getColorTextForInsertNumberTextField(
                              question,
                              question
                                  .insertNumberControllers[
                                      (indexControllers - 1)]
                                  .text)),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Text(element.toString(),
                      style: GoogleFonts.courgette(color: Colors.white)))));
    });
    return rowNames;
  }

  List<Tab> getTabs() {
    var listTabs = widget.listQuestions
        .asMap()
        .keys
        .map((question) => Tab(
              text: "${getTranslated(context, "question") ?? ""} ${++question}",
            ))
        .toList();

    listTabs.add(Tab(
      text: getTranslated(context, "finish_test"),
    ));
    return listTabs;
  }

  getQuestionWidgets() {
    var listWidgets = widget.listQuestions
        .map((question) => Center(
              child: widgetTestQuestion(question),
            ))
        .toList();
    listWidgets.add(getFinishTestWidget());

    return listWidgets;
  }

  Center getFinishTestWidget() {
    return Center(
        child: Expanded(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/finish.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                          getTranslated(context, "congratulations") ?? "",
                          style: GoogleFonts.courgette(
                              color: Colors.deepOrange, fontSize: 36)),
                    ),
                    Text(
                        widget.isCheckTest == true
                            ? getTranslated(context, "well_done") ?? ""
                            : getTranslated(context, "end_of_the_test") ?? "",
                        style: GoogleFonts.courgette(
                            color: Colors.orange, fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          Text(getTranslated(context, "your_points") ?? "",
                              style: GoogleFonts.courgette(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 30)),
                          Expanded(child: Container())
                        ],
                      ),
                      visible: widget.isCheckTest,
                    ),
                    Visibility(
                      child: Text(getResultPoints(),
                          style: GoogleFonts.courgette(
                              color: Colors.pink, fontSize: 70)),
                      visible: widget.isCheckTest,
                    ),
                    Expanded(child: Container()),
                    Column(
                      children: [
                        Visibility(
                          child: FloatingActionButton.extended(
                            backgroundColor: Colors.deepOrange,
                            onPressed: () {
                              setState(() {
                                widget.isCheckTest = true;
                              });
                              //Navigator.pushNamed(context, createMessagePage);
                            },
                            label: Text(
                              getTranslated(context, "exit") ?? " ",
                              style: GoogleFonts.courgette(
                                  color: Colors.white, fontSize: 26),
                            ),
                          ),
                          visible: widget.isCheckTest,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          child: FloatingActionButton.extended(
                            backgroundColor: Colors.amber,
                            onPressed: () {
                              setState(() {
                                _tabController.animateTo(0);
                              });
                              //Navigator.pushNamed(context, createMessagePage);
                            },
                            label: Text(
                              getTranslated(context, "check_answers") ?? " ",
                              style: GoogleFonts.courgette(
                                  color: Colors.white, fontSize: 26),
                            ),
                          ),
                          visible: widget.isCheckTest,
                        ),
                        Visibility(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: FloatingActionButton.extended(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                setState(() {});
                                //Navigator.pushNamed(context, createMessagePage);
                              },
                              label: Text(
                                getTranslated(context, "start_new_test") ?? " ",
                                style: GoogleFonts.courgette(
                                    color: Colors.white, fontSize: 26),
                              ),
                            ),
                          ),
                          visible: widget.isCheckTest,
                        ),
                        Visibility(
                          child: FloatingActionButton.extended(
                            backgroundColor: Colors.deepOrange,
                            onPressed: () {
                              setState(() {
                                widget.isCheckTest = true;
                              });
                              //Navigator.pushNamed(context, createMessagePage);
                            },
                            label: Text(
                              getTranslated(context, "finish_test") ?? " ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          visible: widget.isCheckTest == false,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ],
                ))));
  }

  String getResultPoints() {
    int sizeQuestions = widget.test.getListQuestions().length;
    int amountQuestionsIsCorrect = widget.test
        .getListQuestions()
        .where((e) => e.answerFromUserIsCorrect == true)
        .length;
    return ((100 / sizeQuestions) * amountQuestionsIsCorrect)
        .toInt()
        .toString();
  }

  getColorForAnswer(Question question, String answer) {
    if (widget.isCheckTest == true) {
      if (question.answerFromUserIsCorrect == true)
        return question.answerOfUser == answer ? Colors.amber : Colors.white;
      else {
        if (answer == question.answerOfUser)
          return Colors.red;
        else if (answer == question.answer)
          return Colors.amber;
        else
          return Colors.white;
      }
    }
    return Colors.white;
  }

  getColorTextForInsertNumberTextField(Question question, String answer) {
    if (widget.isCheckTest == true) {
      if (question.answerFromUserIsCorrect == true)
        return Colors.amber;
      else {
        try {
          question.answersInsertNumbersExercises
              ?.firstWhere((element) => element == answer);
          return Colors.amber;
        } catch (Exeption) {
          return Colors.red;
        }
      }
    }
    return Colors.white;
  }
}
