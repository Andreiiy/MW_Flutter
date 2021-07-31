import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    widget.test = widget.generator.createTest(1, 2);
    widget.listQuestions = widget.test.getListQuestions();
    _tabController = TabController(
        initialIndex: 0, length: widget.listQuestions.length, vsync: this);

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          break;
        case 1:
          break;
      }
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
                image: AssetImage("assets/images/board.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(flex: 7, child: getQuestionWidget(question)),
        SizedBox(height: 10),
        // Expanded(
        //   flex: 7,
        //   child: Row(children:[Text(getTranslated(context, "shifts")??" ",style: TextStyle(fontSize:28,color: Colors.deepOrange),)]),
        // ),
        //
        // Expanded(
        //   flex: 7,
        //   child: Row(children: getColumnNames(schedule.getShifts())),
        // ),
        // Expanded(
        //   flex: 88,
        //   child: Row(children: getColumnLists(schedule.getShifts())),
        // ),
      ],
    );
  }

  Widget getQuestionWidget(Question question) {
    if (question.exercise != null) {
      var answers = question.listAnswers ?? [];
      if (widget.test.numberClass == 1)
        return getQuestionWidgetForFirstClass(question);
      else
        return Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(question.exercise!),
                for (int i = 0; i <= answers.length - 1; i++)
                  ListTile(
                    title: Text(
                      answers[i],
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: i == 5 ? Colors.black38 : Colors.black),
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
              ],
            ));
    }
    return Container();
  }

  Widget getQuestionWidgetForFirstClass(Question question) {
    var answers = question.listAnswers ?? [];
    var indexOperand1 = int.parse(question.exercise!.split(' ')[0]) - 1;
    var operator = question.exercise!.split(' ')[1];
    var indexOperand2 = int.parse(question.exercise!.split(' ')[2]) - 1;

    if (question.type == 1 &&
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
                              child: Text(operator,style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  color: Colors.black,
                                  fontSize: 36),),
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
              Text(question.exercise!,style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.black,
                  fontSize: 36),),
              for (int i = 0; i <= answers.length - 1; i++)
               Expanded(child: ListTile(
                 title: Text(
                   answers[i],
                   style: Theme.of(context).textTheme.subtitle1!.copyWith(
                       color: i == 5 ? Colors.black38 : Colors.black,
                   fontSize: 24),
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
               ),)
            ],
          ));
    }
  }
}
