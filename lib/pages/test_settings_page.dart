import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/math_generator.dart';
import 'package:math_world/math_generator/models/class_settings.dart';
import 'package:math_world/pdf_api/pdf_api.dart';
import 'package:math_world/router/route_constants.dart';

class TestSettingsPage extends StatefulWidget {
  ClassSettings classSettings;
  bool viewSettingsVisible = false;

  TestSettingsPage({required this.classSettings});

  @override
  _TestSettingsPageState createState() => _TestSettingsPageState();
}

class _TestSettingsPageState extends State<TestSettingsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff256E59),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff256E59),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            constraints: BoxConstraints(
              maxWidth: 800,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              Expanded(
                flex: 90,
                child: Container(
                  //height: MediaQuery.of(context).size.height / 2,
                  child: Scrollbar(
                    child: ListView(children: <Widget>[
                      Visibility(
                        child: Text(
                          getTranslated(context, "title_test_settings_page") ?? "",
                          style: GoogleFonts.courgette(
                              fontSize: 20, color: Colors.white),
                        ),
                        visible: !widget.viewSettingsVisible,
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Visibility(
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.green,
                          onPressed: () {
                            setState(() {});
                            //Navigator.pushNamed(context, createMessagePage);
                          },
                          label: Text(
                            getTranslated(context, "start_test") ?? " ",
                            style: GoogleFonts.courgette(
                                color: Colors.white, fontSize: 24),
                          ),
                        ),
                        visible: !widget.viewSettingsVisible,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.deepOrangeAccent,
                        onPressed: () {
                          setState(() {
                            widget.viewSettingsVisible =
                                !widget.viewSettingsVisible;
                          });
                          //Navigator.pushNamed(context, createMessagePage);
                        },
                        label: Text(
                          getTranslated(
                                  context,
                                  widget.viewSettingsVisible
                                      ? "сlose_test_settings"
                                      : "сhange_test_settings") ??
                              " ",
                          style: GoogleFonts.courgette(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        child: Column(
                          children: [
                            Text(
                              getTranslated(context, "title_test_settings") ??
                                  "",
                              style: GoogleFonts.courgette(
                                  fontSize: 20, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: generateListSetingsWidgets(
                                  widget.classSettings.listItemsSettings),
                            ),
                            FloatingActionButton.extended(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                setState(() {});
                                try{
                                 if(widget.classSettings.listItemsSettings.firstWhere((element) => element.active == true) != null)
                                   Navigator.popAndPushNamed(context, testPage,arguments: widget.classSettings);
                                }catch(Exeption){
                                  int i = 0;
                                }

                              },
                              label: Text(
                                getTranslated(context, "start_test") ?? " ",
                                style: GoogleFonts.courgette(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /////////////////////////////////////////////////////////////////////////////////////////////////////
                            FloatingActionButton.extended(
                              backgroundColor: Colors.blue,
                              onPressed:() async {
                                try{
                                  if(widget.classSettings.listItemsSettings.firstWhere((element) => element.active == true) != null) {
                                    MathGenerator generator = new MathGenerator();
                                    var test = generator.createTest(
                                        widget.classSettings);
                                    test.transformTestForPdf(context);
                                    final pdfFile = await  PdfApi.createPDFTest(
                                        test,
                                    [
                                      getTranslated(context, "adding_and_subtracting")??"",
                                      getTranslated(context, "insert_missing_numbers")??"",
                                      getTranslated(context, "comparing_numbers")??"",
                                      getTranslated(context, "written_number")??"",
                                      getTranslated(context, "decimal_numbers")??"",
                                    ]
                                    );
                                    PdfApi.openFile(pdfFile);
                                  }
                                }catch(Exeption){
                                  int i = 0;
                                }

                               },
                              label: Text(
                                getTranslated(context, "generate_pdf_file") ??
                                    " ",
                                style: GoogleFonts.courgette(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        visible: widget.viewSettingsVisible,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      /////////////////////////////////////////////////////////////////////////////////////////////////////
                      Visibility(
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            setState(() {});
                            //Navigator.pushNamed(context, createMessagePage);
                          },
                          label: Text(
                            getTranslated(context, "generate_pdf_file") ?? " ",
                            style: GoogleFonts.courgette(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        visible: !widget.viewSettingsVisible,
                      ),
                    ]),
                  ),
                ),
              ),
            ])),
      ),
    );
  }

  Widget getWidgetSettings(ItemSettings itemSettings) {
    return Card(
      color: Color(0xff484443),
      shadowColor: Colors.black,
      borderOnForeground: true,
      margin: EdgeInsets.only(bottom: 20),
      child: Container(
          child: Row(
        children: [
          Expanded(
            flex: 7,
            child: ListTile(
              title: Text(
                getTranslated(context, itemSettings.nameKey) ?? "",
                style: GoogleFonts.courgette(fontSize: 16, color: Colors.white),
              ),
              leading: Checkbox(
                fillColor: MaterialStateProperty.all(Colors.white),
                value: itemSettings.active,
                activeColor: Colors.red,
                checkColor: Colors.red,
                onChanged: (value) {
                  setState(() {
                    itemSettings.active = value ?? false;
                  });
                },
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    getTranslated(context, "amount") ?? "",
                    style:
                        GoogleFonts.courgette(fontSize: 12, color: Colors.red),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 0),
                      child: new Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(5.0),
                                bottomLeft: const Radius.circular(5.0),
                                bottomRight: const Radius.circular(5.0),
                                topRight: const Radius.circular(5.0))),
                        child: new Center(
                            child: new Column(children: [
                          new DropdownButton<String>(
                              underline: Text(''),
                              icon: Icon(Icons.keyboard_arrow_down),
                              hint: Center(child: new Text("0")),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              value: itemSettings.amountQuestions.toString(),
                              onChanged: (newValue) {
                                if (newValue != null)
                                  setState(() {
                                    itemSettings.amountQuestions =
                                        int.parse(newValue);
                                  });
                              },
                              items: buildDropDownMenuItems(
                                  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])),
                        ])),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ))
        ],
      )),
    );
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>>? items = [];
    for (int listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(
            listItem.toString(),
            style: TextStyle(fontSize: 20),
          ),
          value: listItem.toString(),
        ),
      );
    }
    return items;
  }

  generateListSetingsWidgets(List<ItemSettings> listItemsSettings) {
    return listItemsSettings.map((e) => getWidgetSettings(e)).toList();
  }

  @override
  void initState() {
    if(widget.classSettings.classNumber > 1)
      widget.classSettings.listItemsSettings.addAll([
        ItemSettings(
          nameKey: "decimal_numbers",
          typeQuestion: QUESTION_TYPE_WORDS_AND_NUMBERS
      ),
        ItemSettings(
            nameKey: "written_number",
            typeQuestion: QUESTION_TYPE_WORD_NUMBERS
        ),]);
    }
}
