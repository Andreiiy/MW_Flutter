import 'dart:math' as math;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class WidgetCheckBox extends StatelessWidget {
  WidgetCheckBox(
      {this.text,
      this.textAlign = TextAlign.left,
      this.style,
      this.margin = const EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
      this.padding,
      this.bulletSize = 7.0 * PdfPageFormat.mm,
      this.bulletMargin = const EdgeInsets.only(
        top: 1.5 * PdfPageFormat.mm,
        left: 5.0 * PdfPageFormat.mm,
        right: 2.0 * PdfPageFormat.mm,
      ),
      this.bulletShape = BoxShape.rectangle,
      this.bulletColor = PdfColors.white});

  final String? text;

  final TextAlign textAlign;

  final TextStyle? style;

  final EdgeInsets margin;

  final EdgeInsets? padding;

  final EdgeInsets bulletMargin;

  final double bulletSize;

  final BoxShape bulletShape;

  final PdfColor bulletColor;

  @override
  Widget build(Context context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: bulletSize,
            height: bulletSize,
            margin: bulletMargin,
            decoration: BoxDecoration(
                color: bulletColor,
                border: Border(
                  bottom: BorderSide(width: 1, color: PdfColors.black),
                  top: BorderSide(width: 1, color: PdfColors.black),
                  left: BorderSide(width: 1, color: PdfColors.black),
                  right: BorderSide(width: 1, color: PdfColors.black),
                )),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text!,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: 24,
                color: PdfColors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
