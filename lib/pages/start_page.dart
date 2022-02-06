import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/classes/language.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/math_generator.dart';
import 'package:math_world/math_generator/models/generator_for_first_class.dart';
import 'package:math_world/router/route_constants.dart';

import '../main.dart';

class StartPage extends StatefulWidget {
  MathGenerator generator = new MathGenerator();

  StartPage();

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff484443),
        title: Text(
          getTranslated(context, "welcome") ?? "",
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
                  ).toList(),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_start.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:
            //Column(
            //children: [

            Center(
          // margin: EdgeInsets.all(20),
          child:Column(
            children: [
              FloatingActionButton.extended(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.pushNamed(context, classSelectionPage);
                },
                label: Text(
                  "Create test ",
                  style: GoogleFonts.courgette(color: Colors.white, fontSize: 26),
                ),
              ),
              Expanded(child: Container()),
              FloatingActionButton.extended(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.pushNamed(context, loginPage);
                },
                label: Text(
                  getTranslated(context, 'login')??"",
                  style: GoogleFonts.courgette(color: Colors.white, fontSize: 26),
                ),
              ),
            ],
          ),
        ),

        // Visibility(
        //   child: FloatingActionButton.extended(
        //     backgroundColor: Colors.deepOrange,
        //     onPressed: () {
        //       setState(() {
        //         widget.isCheckTest = true;
        //       });
        //       //Navigator.pushNamed(context, createMessagePage);
        //     },
        //     label: Text(
        //       getTranslated(context, "finish_test") ?? " ",
        //       style:
        //       TextStyle(color: Colors.white, fontSize: 30),
        //     ),
        //   ),
        //   visible: widget.isCheckTest == false,
        // ),

        //SizedBox(
        //   height: 20,
        //  )
        // ],
        // ),
      ),
    );
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }
}
