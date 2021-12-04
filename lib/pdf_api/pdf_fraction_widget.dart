
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfFractionWidget extends StatelessWidget {
  final String operand;
  final String? operand2;
  final String? operator;
  final PdfColor textColor;
  final int textSize;

  List<String> arrayOfOperand = [];
  List<String> arrayOfOperand2 = [];

  PdfFractionWidget(
      {required this.operand,
        this.operand2,
        this.operator,
        this.textSize = 12,
        this.textColor = PdfColors.black}) {
    arrayOfOperand = this.operand.split("/");
    if (this.operand2 != null) arrayOfOperand2 = this.operand2!.split("/");
  }

  @override
  Widget build(Context context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(children: [
        arrayOfOperand.length == 3
            ? getFractionView(arrayOfOperand[0], arrayOfOperand[1], arrayOfOperand[2])
            : arrayOfOperand.length == 1
            ? getFractionView(arrayOfOperand[0], null, null)
            : getFractionView(null, arrayOfOperand[0], arrayOfOperand[1]),
    operator != null? Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              operator ?? "",
              style: TextStyle(color: textColor),
            ),
          ):Container(),

    arrayOfOperand2.length > 0? arrayOfOperand2.length == 3
              ? getFractionView(
              arrayOfOperand2[0], arrayOfOperand2[1], arrayOfOperand2[2])
              : operand2 != null
              ? getFractionView(
              null, arrayOfOperand2[0], arrayOfOperand2[1])
              : Container()
        : Container(),

      ]),
    );
  }

  Widget getFractionView(
      String? integer, String? numerator, String? denominator) {
    return Container(
      child: Row(
        children: [
      integer != null? Text(
              integer ?? "",
              style: TextStyle(
                  fontSize: textSize.toDouble(), color: textColor),
            ):Text(""),
          integer != null? SizedBox(width: 5):SizedBox(width: 0),
       numerator != null? Container(
              child: Column(
                children: [
                  Text(
                    numerator,
                    style: TextStyle(
                        fontSize: textSize.toDouble(), color: textColor),
                  ),
                  Container(height: 2, width: 20, color: textColor),
                  Text(
                    denominator ?? "",
                    style: TextStyle(
                        fontSize: textSize.toDouble(), color: textColor),
                  )
                ],
              ),
            ):Container()
        ],
      ),
    );
  }
}
