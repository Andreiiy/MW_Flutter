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
    int sectionNumber = 1;
    // getTranslated(context, "adding_and_subtracting")??"",
    // getTranslated(context, "insert_missing_numbers")??"",
    // getTranslated(context, "comparing_numbers")??"",
    // getTranslated(context, "written_number")??"",
    // getTranslated(context, "decimal_numbers")??"",
    if (test.exercises?.isNotEmpty == true) {
      list.add(Center(
          child: Text("${sectionNumber++}. ${listTranslatedHeaders.first.toString()}",
              style: TextStyle(fontSize: 28,color: PdfColors.red500,))));
      list.add(SizedBox(height: 10));
      test.exercises?.forEach((element) {
        list.add(getWidgetQuestion(test.exercises!.indexOf(element), element));
      });
     if ((test.exercises?.length??1) % 2 == 0) list.add(Container(height: 210));
    }
    if (test.listInsertNumbersExercises?.isNotEmpty == true) {
      list.add(Container(
          child: Text("${sectionNumber++}. ${listTranslatedHeaders[1].toString()}",
              style: TextStyle(fontSize: 28,color: PdfColors.red500))));
      list.add(SizedBox(height: 10));
      test.listInsertNumbersExercises?.forEach((element) {
        list.add(getWidgetInsertNumbersQuestion(
            test.listInsertNumbersExercises!.indexOf(element), element));
      });
      if ((test.listInsertNumbersExercises?.length??1) % 2 == 0) list.add(Container(height: 210));
    }
    if (list.length % 2 == 0) list.add(Container(height: 180));
    if (test.listComparisonNumbersExercises?.isNotEmpty == true) {
      list.add(Container(
          child: Text("${sectionNumber++}. ${listTranslatedHeaders.first.toString()}",
              style: TextStyle(fontSize: 28,color: PdfColors.red500,))));
      list.add(SizedBox(height: 10));
      test.listComparisonNumbersExercises?.forEach((element) {
        list.add(getWidgetQuestion(test.listComparisonNumbersExercises!.indexOf(element), element));
      });
      if ((test.listComparisonNumbersExercises?.length??1) % 2 == 0) list.add(Container(height: 210));
    }
    if (test.listQuestionsWordNumbers?.isNotEmpty == true) {
      list.add(Container(
          child: Text("${sectionNumber++}. ${listTranslatedHeaders.first.toString()}",
              style: TextStyle(fontSize: 28,color: PdfColors.red500,))));
      list.add(SizedBox(height: 10));
      test.listQuestionsWordNumbers?.forEach((element) {
        list.add(getWidgetQuestion(test.listQuestionsWordNumbers!.indexOf(element), element));
      });
      if ((test.listQuestionsWordNumbers?.length??1) % 2 == 0) list.add(Container(height: 210));
    }
    if (list.length % 2 == 0) list.add(Container(height: 180));

    if (test.listQuestionsWordsAndNumbers?.isNotEmpty == true) {
      list.addAll(getListQuestions("${sectionNumber++}. ${listTranslatedHeaders.first.toString()}",test.listQuestionsWordsAndNumbers!));

    }
    return list;
  }

 static List<Widget> getListQuestions(String textSection,List<Question> listQuestions){
   List<Widget> list = [
     Container(
         child: Text(textSection,
             style: TextStyle(fontSize: 28,color: PdfColors.red500,))),
     SizedBox(height: 10)
   ];
   listQuestions.forEach((element) {
     list.add(getWidgetQuestion(listQuestions.indexOf(element), element));
   });
   if ((listQuestions.length) % 2 == 0) list.add(Container(height: 210));
   return list;
  }

  static Widget getWidgetQuestion(int questionNumber, Question question) {
    var widgetList = [
      Text(
        "${(questionNumber + 1)}.                  ${question.exercise ?? ""}",
        style: TextStyle(
          fontSize: 28,
          color: PdfColors.blue700,
        ),
      ),
      SizedBox(height: 10),
    ];
    question.listAnswers?.forEach((element) {
      widgetList.add(WidgetCheckBox(text: element));
      widgetList.add(SizedBox(height: 5));
    });
    widgetList.add(Divider(color: PdfColors.black));
    widgetList.add(SizedBox(height: 5));
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList,
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
                fontSize: 26,
                color: PdfColors.blue700,
              ),
            ),
            SizedBox(height: 5),
            rows[0],
            SizedBox(height: 5),
            rows[1],
            SizedBox(height: 5),
            rows[2],
            SizedBox(height: 5),
            rows[3],
            SizedBox(height: 5),
            rows[4],
            SizedBox(height: 5),
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
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),
           SizedBox(width: 10),
           Expanded(child: Text((question.insertNumbersExercise![temp++] ?? "__").toString(),style: TextStyle(fontSize: 24))),

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
