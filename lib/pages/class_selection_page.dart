
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/classes/language.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/models/class_settings.dart';
import 'package:math_world/router/route_constants.dart';

import '../main.dart';

class ClassSelectionPage extends StatefulWidget{

  var classes = [
    ClassSettings(classNumber: 1,imageString: 'assets/images/class_numbers/class1.png'),
    ClassSettings(classNumber: 2,imageString: 'assets/images/class_numbers/class2.png'),
    ClassSettings(classNumber: 3,imageString: 'assets/images/class_numbers/class3.png'),
    ClassSettings(classNumber: 4,imageString: 'assets/images/class_numbers/class4.png'),
    ClassSettings(classNumber: 5,imageString: 'assets/images/class_numbers/class5.png'),
    ClassSettings(classNumber: 6,imageString: 'assets/images/class_numbers/class6.png'),
  ];

  @override
  _ClassSelectionPageState createState() => _ClassSelectionPageState();

}

class _ClassSelectionPageState extends State<ClassSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff256E59),
        title: Text(
          getTranslated(context, "choose_class") ?? "",
          style: GoogleFonts.courgette(color: Colors.white,fontSize: 16),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) {
                _changeLanguage(language!);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xff256E59),
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: widget.classes.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return _classCard(widget.classes[index]);
            }),
      ),
    );
  }
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  Widget _classCard(ClassSettings classSettings) {
    return Container(
      // alignment: _getAlignmentForItemGroup(position),
        child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child:MaterialButton(onPressed: () {
              Navigator.popAndPushNamed(context, testSettingsPage,arguments: classSettings);
            },
            child:
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage(classSettings.imageString??""),
                  fit: BoxFit.fill,
                ),
              ),
            ),)  ,
            ));
  }
}
