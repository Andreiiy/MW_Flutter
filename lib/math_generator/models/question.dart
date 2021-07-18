import 'dart:math';

class Question {
   String? exercise;
   String? answer;
   String? answerNotCorrect1;
   String? answerNotCorrect2;
   String? answerNotCorrect3;

   List<String>? listAnswers;

  late List<String?> insertNumbersExercise;
  late List<String?> answersInsertNumbersExercises;

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
