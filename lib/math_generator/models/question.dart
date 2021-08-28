import 'dart:math';

import 'package:flutter/cupertino.dart';

class Question {
  String questionImage = "";

  int? type;
  String? exercise;
  String? answer;
  String? answerNotCorrect1;
  String? answerNotCorrect2;
  String? answerNotCorrect3;
  String? answerOfUser;
  bool? answerFromUserIsCorrect;
  bool? isAnswered;

  List<String>? listAnswers;

  List<int?>? insertNumbersExercise;
  List<String?>? answersInsertNumbersExercises;
  late List<TextEditingController> insertNumberControllers;

  bool isWordNumberQuestion = false;

  bool isWordsAndNumbersQuestion = false;

  void initControllers() {
    insertNumberControllers =
    [
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController()
    ];
  }

  bool checkInsertNumbersQuestionAnswers() {
    bool result = true;
    insertNumberControllers.forEach((element) {
    try{
    answersInsertNumbersExercises?.firstWhere((answer) => answer == element.text);
    } catch(Exeption){
      result = false;
    }
    });

    return result;
  }
  bool checkInsertNumbersQuestionIsAnswered() {
    bool result = true;
    insertNumberControllers.forEach((element) {
        if(element.text.toString() == "" ) {
          result = false;
        }

    });

    return result;
  }

  void saveListAnswers() {
    List<String> answers = [];
    if (answer != null) answers.add(answer!);
    if (answerNotCorrect1 != null) answers.add(answerNotCorrect1!);
    if (answerNotCorrect2 != null) answers.add(answerNotCorrect2!);
    if (answerNotCorrect3 != null) answers.add(answerNotCorrect3!);
    listAnswers = _mix(answers);
  }

  List<String> _mix(List<String> items) {
    var random = new Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }


}

const TYPE_EXERCISE = 1;
const TYPE_INSERT_NUMBERS = 2;
const TYPE_COMPARISON_NUMBERS = 3;
const TYPE_WORD_NUMBER = 4;
const TYPE_WORD_AND_NUMBER = 5;