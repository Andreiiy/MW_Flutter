import 'dart:io';

import 'package:flutter/services.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/models/question.dart';
import 'package:math_world/math_generator/models/test.dart';
import 'package:math_world/pdf_api/pdf_fraction_widget.dart';
import 'package:math_world/pdf_api/bidi.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'widgetCheckBox.dart';

class PdfApi {
  final pdf = Document();

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
    final font = await rootBundle.load("assets/fonts/arial-unicode-ms.ttf");
    final ttfFont = Font.ttf(font);
    final currentLanguageCode = await getLanguageCode();
    final pdf = Document();

    final imageJpg = (await rootBundle.load('assets/images/bg_pdf.png'))
        .buffer
        .asUint8List();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      theme: ThemeData(
        defaultTextStyle: TextStyle(
          font: ttfFont,
        ),
      ),
      textDirection:
          currentLanguageCode == 'IL' ? TextDirection.rtl : TextDirection.ltr,
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
          // textDirection: currentLanguageCode == 'IL'
          //     ? TextDirection.rtl
          //     : TextDirection.ltr,
          build: (context) => [
                SizedBox(height: 300),
                Center(
                  child: Text(" כיתה ${test.numberClass}".bidi(),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 48, font: ttfFont)),
                ),
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
                style: TextStyle(color: PdfColors.black, font: ttfFont),
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
    list.add(SizedBox(height: 340));

    if (test.exercises?.isNotEmpty == true) {
      if (currentLanguageCode != 'he') {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders.first.toString()}",
            test.exercises!,
            false,
            false));
      } else {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders.first.toString()}",
            test.exercises!,
            true,
            false));
      }
      if ((test.exercises?.length ?? 1) % 2 == 0)
        list.add(Container(height: 210));
    }
    if (test.listInsertNumbersExercises?.isNotEmpty == true) {
      if (currentLanguageCode != 'he') {
        list.add(Container(
            child: Text(
                "${sectionNumber++}. ${listTranslatedHeaders[1].toString()}",
                style: TextStyle(fontSize: 28, color: PdfColors.red500))));
      } else {
        list.add(Container(
            child: Text(
                "${sectionNumber++}. ${listTranslatedHeaders[1].toString()}"
                    .bidi(),
                style: TextStyle(fontSize: 28, color: PdfColors.red500))));
      }
      list.add(SizedBox(height: 10));
      test.listInsertNumbersExercises?.forEach((element) {
        list.add(getWidgetInsertNumbersQuestion(
            test.listInsertNumbersExercises!.indexOf(element), element,currentLanguageCode == 'he'));
      });
      if ((test.listInsertNumbersExercises?.length ?? 1) % 2 == 0)
        list.add(Container(height: 210));
    }
    if (list.length > 0 && list.length % 2 == 0)
      list.add(Container(height: 180));
    ////////////////////////////////////////////////////////////////////////////
    if (test.listComparisonNumbersExercises?.isNotEmpty == true) {
      if (currentLanguageCode != 'he') {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[2].toString()}",
            test.listComparisonNumbersExercises!,
            false,
            false));
      } else {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[2].toString()}",
            test.listComparisonNumbersExercises!,
            true,
            false));
      }
      if ((test.listComparisonNumbersExercises?.length ?? 1) % 2 == 0)
        list.add(Container(height: 210));
    }
    ////////////////////////////////////////////////////////////////////////////
    if (test.listQuestionsWordNumbers?.isNotEmpty == true) {
      if (currentLanguageCode != 'he') {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[3].toString()}",
            test.listQuestionsWordNumbers!,
            false,
            true));
      } else {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[3].toString()}",
            test.listQuestionsWordNumbers!,
            true,
            true));
      }
      if ((test.listQuestionsWordNumbers?.length ?? 1) % 2 == 0)
        list.add(Container(height: 210));
    }
    ////////////////////////////////////////////////////////////////////////////
    if (list.length > 0 && list.length % 2 == 0)
      list.add(Container(height: 180));

    if (test.listQuestionsWordsAndNumbers?.isNotEmpty == true) {
      if (currentLanguageCode != 'he') {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[4].toString()}",
            test.listQuestionsWordsAndNumbers!,
            false,
            true));
      } else {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[4].toString()}",
            test.listQuestionsWordsAndNumbers!,
            true,
            true));
      }
    }
    if (list.length > 0 && list.length % 2 == 0)
      list.add(Container(height: 180));

    if (test.listMultiplicationTableExercises?.isNotEmpty == true) {
      if (currentLanguageCode != 'he') {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[5].toString()}",
            test.listMultiplicationTableExercises!,
            false,
            false));
      } else {
        list.addAll(getListQuestions(
            "${sectionNumber++}. ${listTranslatedHeaders[5].toString()}",
            test.listMultiplicationTableExercises!,
            true,
            false));
      }

      if ((test.listMultiplicationTableExercises?.length ?? 1) % 2 == 0)
        list.add(Container(height: 210));
    }
    ////////////////////////////////////////////////////////////////////////////
    if (list.length > 0 && list.length % 2 == 0)
      list.add(Container(height: 180));
    if (test.listExercisesWithFractions?.isNotEmpty == true) {
      if (currentLanguageCode != 'he') {
        list.add(Container(
            child: Text(
                "${sectionNumber++}. ${listTranslatedHeaders[6].toString()}",
                style: TextStyle(
                  fontSize: 28,
                  color: PdfColors.red500,
                ))));
        list.add(SizedBox(height: 10));
        test.listExercisesWithFractions?.forEach((element) {
          list.add(getWidgetQuestionWithFraction(
              test.listExercisesWithFractions!.indexOf(element), element));
        });
      } else {
        list.add(Container(
            child: Text(
                "${sectionNumber++}. ${listTranslatedHeaders[6].toString()}"
                    .bidi(),
                style: TextStyle(
                  fontSize: 28,
                  color: PdfColors.red500,
                ))));
        list.add(SizedBox(height: 10));
        test.listExercisesWithFractions?.forEach((element) {
          list.add(getWidgetQuestionWithFractionRightToLeft(
              test.listExercisesWithFractions!.indexOf(element), element));
        });
      }
      if ((test.listExercisesWithFractions?.length ?? 1) % 2 == 0)
        list.add(Container(height: 210));
    }
    return list;
  }

  static List<Widget> getListQuestions(
      String textSection,
      List<Question> listQuestions,
      bool directionRTL,
      bool questionsWithWords) {
    List<Widget> list = [
      Container(
          child: Text(!directionRTL ? textSection : textSection.bidi(),
              style: TextStyle(
                fontSize: 28,
                color: PdfColors.red500,
              ))),
      SizedBox(height: 10)
    ];
    listQuestions.forEach((element) {
      if (!directionRTL)
        list.add(getWidgetQuestion(listQuestions.indexOf(element), element));
      else
        list.add(getWidgetQuestionRightToLeft(
            listQuestions.indexOf(element), element, questionsWithWords));
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

  static Widget getWidgetQuestionRightToLeft(
      int questionNumber, Question question, bool questionsWithWords) {
    List<Widget> widgetList = [
      Row(children: [
        Expanded(child: Container()),
        SizedBox(height: 10),
        Text(
          "${questionsWithWords ? (question.exercise ?? "").bidi() : (question.exercise ?? "")}                  .${(questionNumber + 1)}",
          style: TextStyle(
            fontSize: 28,
            color: PdfColors.blue700,
          ),
        ),
      ])
    ];
    question.listAnswers?.forEach((element) {
      widgetList.add(WidgetCheckBox(text: element, directionRTL: true));
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

  static Widget getWidgetQuestionWithFraction(
      int questionNumber, Question question) {
    var widgetList = [
      Row(children: [
        Text(
          "${(questionNumber + 1)}.",
          style: TextStyle(
            fontSize: 28,
            color: PdfColors.blue700,
          ),
        ),
        SizedBox(width: 50),
        Expanded(
            child: PdfFractionWidget(
                operand: question.exerciseOperand1 ?? "",
                operand2: question.exerciseOperand2,
                operator: question.operator,
                textSize: 24)),
      ]),
      SizedBox(height: 10),
    ];
    question.listAnswers?.forEach((element) {
      widgetList.add(
        //WidgetCheckBox(text:""));
        Row(children: [
          WidgetCheckBox(text: ""),
          SizedBox(width: 10),
          Expanded(child: PdfFractionWidget(operand: element, textSize: 16)),
        ]),
      );
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

  static Widget getWidgetQuestionWithFractionRightToLeft(
      int questionNumber, Question question) {
    var widgetList = [
      Row(children: [
        Expanded(
            child: PdfFractionWidget(
                operand: question.exerciseOperand1 ?? "",
                operand2: question.exerciseOperand2,
                operator: question.operator,
                textSize: 24)),
        SizedBox(width: 50),
        Text(
          ".${(questionNumber + 1)}",
          style: TextStyle(
            fontSize: 28,
            color: PdfColors.blue700,
          ),
        ),
      ]),
      SizedBox(height: 10),
    ];
    question.listAnswers?.forEach((element) {
      widgetList.add(
        //WidgetCheckBox(text:""));
        Row(children: [
          Expanded(child: PdfFractionWidget(operand: element, textSize: 16)),
          SizedBox(width: 10),
          WidgetCheckBox(text: "", directionRTL: true),
        ]),
      );
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
      int questionNumber, Question question, bool directionRTL) {
    List<Widget> rows = getListToTable(question);
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            directionRTL?
            Row(children: [
              Expanded(child: Container()),
              Text(
                ".${questionNumber + 1}",
                style: TextStyle(
                  fontSize: 26,
                  color: PdfColors.blue700,
                ),
              ),
            ]):
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

  static List<Widget> getListToTable(Question question) {
    List<Widget> resalt = [];
    int temp = 0;
    for (int i = 0; i < 5; i++) {
      resalt.add(Row(children: [
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
        SizedBox(width: 10),
        Expanded(
            child: Text(
                (question.insertNumbersExercise![temp++] ?? "__").toString(),
                style: TextStyle(fontSize: 24))),
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
