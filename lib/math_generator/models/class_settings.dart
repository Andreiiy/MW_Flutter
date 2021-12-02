

import 'package:math_world/localization/language_constants.dart';

class ClassSettings {
 int classNumber ;
 String? imageString;
 List<ItemSettings> _listItemsSettings = [];

 ClassSettings({required this.classNumber,this.imageString});

 List<ItemSettings> getListItemsSettings(){
  if(_listItemsSettings.length == 0) {
   _listItemsSettings = [
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
   if (classNumber > 1) {
    _listItemsSettings.addAll([
     ItemSettings(
         nameKey: "decimal_numbers",
         typeQuestion: QUESTION_TYPE_WORDS_AND_NUMBERS),
     ItemSettings(
         nameKey: "written_number",
         typeQuestion: QUESTION_TYPE_WORD_NUMBERS),
    ]);
    if (classNumber >= 2 )
     _listItemsSettings.add(ItemSettings(
         nameKey: "multiplication_table_exercises",
         typeQuestion: QUESTION_TYPE_FROM_MULTIPLICATION_TABLE));
    if (classNumber >= 3){
     _listItemsSettings.add(ItemSettings(
         nameKey: "exercises_with_fractions",
         typeQuestion: QUESTION_TYPE_FRACTIONS));

     _listItemsSettings.add(ItemSettings(
         nameKey: "exercises_with_multiplication_and_division_fractions",
         typeQuestion: QUESTION_TYPE__MULTIPLICATION_and_DIVISION_FRACTIONS));
    }

   }


   }

   return _listItemsSettings;
 }
}



class ItemSettings{
 String nameKey;
 int typeQuestion;
 int amountQuestions = 1;
 int multiTableSize = 5;
 bool active = false;

 ItemSettings({required this.nameKey,required this.typeQuestion});

}

const int QUESTION_TYPE_ADDING_AND_SUBTRACTING = 1;
const int QUESTION_TYPE_WORDS_AND_NUMBERS = 2;
const int QUESTION_TYPE_WORD_NUMBERS = 3;
const int QUESTION_TYPE_INSERT_NUMBERS = 4;
const int QUESTION_TYPE_COMPARISON_NUMBERS = 5;
const int QUESTION_TYPE_FROM_MULTIPLICATION_TABLE = 6;
const int QUESTION_TYPE_FRACTIONS = 7;
const int QUESTION_TYPE__MULTIPLICATION_and_DIVISION_FRACTIONS = 8;

