class Fraction {
  int? integer;
  int numerator;
  int denominator;

  Fraction({this.integer,required this.numerator, required this.denominator});

  bool checkOtherFractionGreater(Fraction otherFraction){
    Fraction myFraction = Fraction(numerator: numerator, denominator: denominator);
    if(integer != null && integer! > 0){
      myFraction = Fraction(numerator:(integer! * denominator + numerator), denominator: denominator);
    }
    Fraction checkFraction = Fraction(numerator: otherFraction.numerator, denominator: otherFraction.denominator);
    if(otherFraction.integer != null && otherFraction.integer! > 0){
      checkFraction = Fraction(numerator:(otherFraction.integer! * otherFraction.denominator + otherFraction.numerator), denominator: otherFraction.denominator);
    }
    _reduceToCommonDenominator(myFraction, checkFraction);


    if(myFraction.numerator < checkFraction.numerator)
      return true;


    return false;

  }

static Fraction calculateFractions(String operator,Fraction operand1, Fraction operand2){
  Fraction fraction1 = Fraction(numerator: operand1.numerator, denominator: operand1.denominator);
  if(operand1.integer != null && operand1.integer! > 0){
    fraction1 = Fraction(numerator:(operand1.integer! * operand1.denominator + operand1.numerator), denominator: operand1.denominator);
  }
  Fraction fraction2 = Fraction(numerator: operand2.numerator, denominator: operand2.denominator);
  if(operand2.integer != null && operand2.integer! > 0){
    fraction2 = Fraction(numerator:(operand2.integer! * operand2.denominator + operand2.numerator), denominator: operand2.denominator);
  }
  _reduceToCommonDenominator(fraction1, fraction2);
    switch(operator){
      case "+" :{ return _add(fraction1,fraction2);}
      case "-" :{return _sub(fraction1,fraction2);}
      case "*" :{return _mult(fraction1,fraction2);}
      case "/" :{return _div(fraction1,fraction2);}
      break;
    }
    return _add(operand1,operand2);
}
 static void _reduceToCommonDenominator(Fraction operand1, Fraction operand2){
    if(operand1.denominator != operand2.denominator){
      operand1.numerator *= operand2.denominator;
      operand2.numerator *= operand1.denominator;
      operand1.denominator *= operand2.denominator;
      operand2.denominator = operand1.denominator;
    }
  }
static Fraction reduceFraction(Fraction fraction){
    Fraction reduceFraction = fraction;
    if(fraction.numerator > fraction.denominator) {
      reduceFraction = Fraction(integer: (fraction.integer ?? 0) +
          fraction.numerator ~/ fraction.denominator,
          numerator:fraction.numerator % fraction.denominator == 0? 1 : fraction.numerator % fraction.denominator,
          denominator: fraction.denominator);
    }
    for( int i = 10 ; i > 1; i-- ){
      int numberDenominator = i;
      while(reduceFraction.numerator % numberDenominator == 0 && reduceFraction.denominator % numberDenominator == 0){
        reduceFraction.numerator = reduceFraction.numerator ~/ numberDenominator;
        reduceFraction.denominator =reduceFraction.denominator ~/ numberDenominator;
      }
    }

  return reduceFraction;
}
static Fraction _add(Fraction operand1, Fraction operand2){
  return reduceFraction(Fraction(numerator: operand1.numerator + operand2.numerator, denominator: operand1.denominator));
}
static Fraction _sub(Fraction operand1, Fraction operand2){
  return reduceFraction(Fraction(numerator: operand1.numerator - operand2.numerator, denominator: operand1.denominator));
}
  static Fraction _mult(Fraction operand1, Fraction operand2){
    return reduceFraction(Fraction(numerator: operand1.numerator * operand2.numerator, denominator: operand1.denominator * operand2.denominator));
  }
  static Fraction _div(Fraction operand1, Fraction operand2){
    return reduceFraction(Fraction(numerator: operand1.numerator * operand2.denominator, denominator: operand1.denominator * operand2.numerator));
  }
  String getFractionString() {
    String fractionString = numerator.toString() +"/"+denominator.toString();
    if(integer != null && integer! > 0)
      fractionString = integer.toString()+"/"+numerator.toString() +"/"+denominator.toString();
    if(numerator == 0 || denominator == 0)
      fractionString = "0";
    return fractionString;
  }


}
