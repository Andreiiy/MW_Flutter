import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: const EdgeInsets.all(5.0),
      child: Row(children: [
        arrayOfOperand.length == 3
            ? getFractionView(arrayOfOperand[0], arrayOfOperand[1], arrayOfOperand[2])
            : arrayOfOperand.length == 1
                ? getFractionView(arrayOfOperand[0], null, null)
                : getFractionView(null, arrayOfOperand[0], arrayOfOperand[1]),
        Visibility(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              operator ?? "",
              style: TextStyle(color: textColor),
            ),
          ),
          visible: operator != null,
        ),
        Visibility(
          child: arrayOfOperand2.length == 3
              ? getFractionView(
                  arrayOfOperand2[0], arrayOfOperand2[1], arrayOfOperand2[2])
              : operand2 != null
                  ? getFractionView(
                      null, arrayOfOperand2[0], arrayOfOperand2[1])
                  : Container(),
          visible: arrayOfOperand2.length > 0,
        ),
      ]),
    );
  }

  Widget getFractionView(
      String? integer, String? numerator, String? denominator) {
    return Container(
      child: Row(
        children: [
          Visibility(
            child: Text(
              integer ?? "",
              style: GoogleFonts.courgette(
                  fontSize: textSize.toDouble(), color: textColor),
            ),
            visible: integer != null,
          ),
          SizedBox(width: 5,),
          Visibility(
            child: Container(
              child: Column(
                children: [
                  Text(
                    numerator ?? "",
                    style: GoogleFonts.courgette(
                        fontSize: textSize.toDouble(), color: textColor),
                  ),
                  Container(height: 2, width: 20, color: textColor),
                  Text(
                    denominator ?? "",
                    style: GoogleFonts.courgette(
                        fontSize: textSize.toDouble(), color: textColor),
                  )
                ],
              ),
            ),
            visible: numerator != null,
          ),
        ],
      ),
    );
  }
}
