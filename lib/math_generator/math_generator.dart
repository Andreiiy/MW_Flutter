


import 'models/generator_for_first_class.dart';
import 'models/test.dart';

class MathGenerator{

   Test createTest(int numberClass, int amountExercises){

      switch(numberClass){
         case 1 : {
            GeneratorForFirstClass generator = new GeneratorForFirstClass();
            return generator.generateTest(amountExercises);
         }

      }
      GeneratorForFirstClass generator = new GeneratorForFirstClass();
      return generator.generateTest(amountExercises);
   }
}