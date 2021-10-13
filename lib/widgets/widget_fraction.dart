import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FractionWidget extends StatelessWidget {
  final String operand;
  final String? operand2;
  final String? operator;
  final Color textColor;
  final int textSize;

  List<String> arrayOfOperand = [];
  List<String> arrayOfOperand2 = [];

  FractionWidget(
      {required this.operand,
      this.operand2,
      this.operator,
      this.textSize = 12,
      this.textColor = Colors.black}) {
    arrayOfOperand = this.operand.split("/");
    if (this.operand2 != null) arrayOfOperand2 = this.operand2!.split("/");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          children: [
            arrayOfOperand.length == 3?
            getFractionView(arrayOfOperand[0],arrayOfOperand[1],arrayOfOperand[2]):
            operand2 != null ?
              getFractionView(null, arrayOfOperand[0], arrayOfOperand[1])

            :Container(),
          ]),
    );
  }


  Widget getFractionView(String? integer,String numerator,String denominator){
    return Container(
      child: Row(
        children: [
          Visibility(child: Text(integer??"",style: TextStyle(fontSize: textSize.toDouble(), color: textColor)),
            visible: integer != null,
          ),
          Container(
            child: Column(
              children: [
                Text(numerator,style: TextStyle(fontSize: textSize.toDouble(), color: textColor),),
                Divider(height: 10,color: textColor),
                Text(denominator,style: TextStyle(fontSize: textSize.toDouble(), color: textColor),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
