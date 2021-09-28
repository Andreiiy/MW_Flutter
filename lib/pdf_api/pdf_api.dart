import 'dart:io';

import 'package:flutter/services.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/models/question.dart';
import 'package:math_world/math_generator/models/test.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'widgetCheckBox.dart';

class PdfApi {
  static Future<File> generateCenteredText(String text) async {
    final pdf = Document();

    pdf.addPage(Page(
      build: (context) => Center(
        child: Text(text, style: TextStyle(fontSize: 48)),
      ),
    ));

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<File> createPDFTest(
      Test test, List<String> listTranslatedHeaders) async {
    final pdf = Document();

    final imageJpg = (await rootBundle.load('assets/images/bg_pdf.png'))
        .buffer
        .asUint8List();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      textDirection: getCurrentLanguageCode == 'he'
          ? TextDirection.rtl
          : TextDirection.ltr,
      buildBackground: (context) {
        if (context.pageNumber == 1) {
          return FullPage(
            ignoreMargins: true,
            child: Image(MemoryImage(imageJpg), fit: BoxFit.cover),
          );
        } else {
          return Container();
        }
      },
    );

    pdf.addPage(
      MultiPage(
          pageTheme: pageTheme,
          build: (context) => [
                SizedBox(height: 300),
                Center(
                  child: Text("Class ${test.numberClass}",
                      style: TextStyle(fontSize: 48)),
                ),
                SizedBox(height: 350),
                Column(
                    children: createPDFTestList(test, listTranslatedHeaders)),
              ],
          footer: (context) {
            final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
            return Container(
              alignment: Alignment.center,
              //margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              child: Text(
                text,
                style: TextStyle(color: PdfColors.black),
              ),
            );
          }),
    );

    return saveDocument(
        name: "class${test.numberClass}_${DateTime.now().toString()}.pdf",
        pdf: pdf);
  }

  static List<Widget> createPDFTestList(
      Test test, List<String> listTranslatedHeaders) {
    List<Widget> list = [];
    // getTranslated(context, "adding_and_subtracting")??"",
    // getTranslated(context, "insert_missing_numbers")??"",
    // getTranslated(context, "comparing_numbers")??"",
    // getTranslated(context, "written_number")??"",
    // getTranslated(context, "decimal_numbers")??"",
    if (test.exercises?.isNotEmpty == true) {
      list.add(Center(
          child: Text("1. ${listTranslatedHeaders.first.toString()}",
              style: TextStyle(fontSize: 28,color: PdfColors.red500,))));
      list.add(SizedBox(height: 10));
      test.exercises?.forEach((element) {
        list.add(getWidgetQuestion(test.exercises!.indexOf(element), element));
      });
    }
    if (test.insertNumbersExercises?.isNotEmpty == true) {
      list.add(Center(
          child: Text("2. ${listTranslatedHeaders[1].toString()}",
              style: TextStyle(fontSize: 28))));
      list.add(SizedBox(height: 10));
      test.exercises?.forEach((element) {
        list.add(getWidgetInsertNumbersQuestion(
            test.insertNumbersExercises!.indexOf(element), element));
      });
    }
    return list;
  }

  static Widget getWidgetQuestion(int questionNumber, Question question) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${questionNumber + 1}.                  ${question.exercise ?? ""}",
            style: TextStyle(
              fontSize: 28,
              color: PdfColors.black,
            ),
          ),
          SizedBox(height: 10),
          WidgetCheckBox(text: question.listAnswers![0]),
          SizedBox(height: 5),
          WidgetCheckBox(text: question.listAnswers![1]),
          SizedBox(height: 5),
          WidgetCheckBox(text: question.listAnswers![2]),
          SizedBox(height: 5),
          WidgetCheckBox(text: question.listAnswers![3]),
          Divider(color: PdfColors.black),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  static Widget getWidgetInsertNumbersQuestion(
      int questionNumber, Question question) {
    List<Widget> rows = getListToTable(question);
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${questionNumber + 1}.",
              style: TextStyle(
                fontSize: 30,
                color: PdfColors.black,
              ),
            ),
            SizedBox(height: 10),
            rows[0],
            rows[1],
            rows[2],
            rows[3],
            rows[4],
            Divider(color: PdfColors.black),
          ]),
    );
  }

  static  List<Widget> getListToTable(Question question) {
    List<Widget> resalt = [];
    int temp = 0;
    for (int i = 0; i < 5; i++) {
      resalt.add(Row(
         children: [
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString()),
       Text((question.insertNumbersExercise![temp++] ?? "__").toString())
      ]));
    }
    return resalt;
  }

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'My Third Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: PdfColors.red),
      );
}
