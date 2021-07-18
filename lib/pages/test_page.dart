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
    widget.test = widget.generator.createTest(1, 10);
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
        backgroundColor: Colors.grey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
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
            )));
  }

  Widget widgetTestQuestion(Question question) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/board.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          flex: 8,
          child:getQuestionWidget(question)
        ),
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

    if(question.exercise != null) {
      var answers = question.listAnswers ?? [];
      return Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(question.exercise!),
              for (int i = 0; i <= answers.length - 1; i++)
                ListTile(
                  title: Text(
                    answers[i],
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(
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
}


