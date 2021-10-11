


import 'package:math_world/math_generator/models/class_settings.dart';
import 'package:math_world/math_generator/models/generator_for_second_class.dart';

import 'models/GeneratorForThirdClass.dart';
import 'models/generator_for_first_class.dart';
import 'models/test.dart';

class MathGenerator{

   Test createTest(ClassSettings classSettings){

      switch(classSettings.classNumber){
         case 1 : {
            GeneratorForFirstClass generator = new GeneratorForFirstClass();
            return generator.generateTest(classSettings);
         }
         case 2 : {
            GeneratorForSecondClass generator = new GeneratorForSecondClass();
            return generator.generateTest(classSettings);
         }
         case 3 : {
            GeneratorForThirdClass generator = new GeneratorForThirdClass();
            return generator.generateTest(classSettings);
         }
      }
      GeneratorForFirstClass generator = new GeneratorForFirstClass();
      return generator.generateTest(classSettings);
   }

   static var listStringNumbers =  {
      20 :"twenty",
      21 :"twenty_one",
      22 :"twenty_two",
      23 :"twenty_three",
      24 :"twenty_four",
      25 :"twenty_five",
      26 :"twenty_six",
      27 :"twenty_seven",
      28 :"twenty_eight",
      29 :"twenty_nine",
      30 :"thirty",
      31 :"thirty_one",
      32 :"thirty_two",
      33 :"thirty_three",
      34 :"thirty_four",
      35 :"thirty_five",
      36 :"thirty_six",
      37 :"thirty_seven",
      38 :"thirty_eight",
      39 :"thirty_nine",
      40 :"fourty",
      41 :"fourty_one",
      42 :"fourty_two",
      43 :"fourty_three",
      44 :"fourty_four",
      45 :"fourty_five",
      46 :"fourty_six",
      47 :"fourty_seven",
      48 :"fourty_eight",
      49 :"fourty_nine",
      50 :"fifty",
      51 :"fifty_one",
      52 :"fifty_two",
      53 :"fifty_three",
      54 :"fifty_four",
      55 :"fifty_five",
      56 :"fifty_six",
      57 :"fifty_seven",
      58 :"fifty_eight",
      59 :"fifty_nine",
      60 :"sixty",
      61 :"sixty_one",
      62 :"sixty_two",
      63 :"sixty_three",
      64 :"sixty_four",
      65 :"sixty_five",
      66 :"sixty_six",
      67 :"sixty_seven",
      68 :"sixty_eight",
      69 :"sixty_nine",
      70 :"seventy",
      71 :"seventy_one",
      72 :"seventy_two",
      73 :"seventy_three",
      74 :"seventy_four",
      75 :"seventy_five",
      76 :"seventy_six",
      77 :"seventy_seven",
      78 :"seventy_eight",
      79 :"seventy_nine",
      80 :"eighty",
      81 :"eighty_one",
      82 :"eighty_two",
      83 :"eighty_three",
      84 :"eighty_four",
      85 :"eighty_five",
      86 :"eighty_six",
      87 :"eighty_seven",
      88 :"eighty_eight",
      89 :"eighty_nine",
      90 :"ninety",
      91 :"ninety_one",
      92 :"ninety_two",
      93 :"ninety_three",
      94 :"ninety_four",
      95 :"ninety_five",
      96 :"ninety_six",
      97 :"ninety_seven",
      98 :"ninety_eight",
      99 :"ninety_nine",
      100 : "hundred",
       };
}