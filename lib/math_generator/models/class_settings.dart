

import 'package:math_world/localization/language_constants.dart';

class ClassSettings {
 int classNumber ;
 String? imageString;
 List<ItemSettings> listItemsSettings = [
  ItemSettings(
      nameKey: "adding_and_subtracting",
   typeQuestion: QUESTION_TYPE_ADDING_AND_SUBTRACTING
  ),

  ItemSettings(
      nameKey: "insert_missing_numbers",
      typeQuestion: QUESTION_TYPE_INSERT_NUMBERS
  ),
  ItemSettings(
      nameKey: "comparing_numbers",
      typeQuestion: QUESTION_TYPE_COMPARISON_NUMBERS
  ),
 ];

 ClassSettings({required this.classNumber,this.imageString});
}



class ItemSettings{
 String nameKey;
 int typeQuestion;
 int amountQuestions = 1;
 bool active = false;

 ItemSettings({required this.nameKey,required this.typeQuestion});

}

const int QUESTION_TYPE_ADDING_AND_SUBTRACTING = 1;
const int QUESTION_TYPE_WORDS_AND_NUMBERS = 2;
const int QUESTION_TYPE_WORD_NUMBERS = 3;
const int QUESTION_TYPE_INSERT_NUMBERS = 4;
const int QUESTION_TYPE_COMPARISON_NUMBERS = 5;