import 'dart:math';

class Question {
   int? type;
   String? exercise;
   String? answer;
   String? answerNotCorrect1;
   String? answerNotCorrect2;
   String? answerNotCorrect3;
   bool? answerFromUserIsCorrect;

   List<String>? listAnswers;

   List<int?>? insertNumbersExercise;
   List<String?>? answersInsertNumbersExercises;

  bool isWordNumberQuestion = false;

  bool isWordsAndNumbersQuestion = false;

  void saveListAnswers() {
    List<String> answers = [];
    if(answer != null)answers.add(answer!);
    if(answerNotCorrect1 != null)answers.add(answerNotCorrect1!);
    if(answerNotCorrect2 != null)answers.add(answerNotCorrect2!);
    if(answerNotCorrect3 != null)answers.add(answerNotCorrect3!);
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