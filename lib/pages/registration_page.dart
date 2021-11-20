import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/router/route_constants.dart';

class RegistrationPage extends StatefulWidget {

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xff256E59),
      appBar: AppBar(
        backgroundColor: Color(0xff484443),
        title: Text(
          getTranslated(context, 'registration')??"",
          style: GoogleFonts.courgette(color: Colors.white,fontSize: 16),
        ),
      ),
      body: FutureBuilder(
          future: getLanguageCode(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              String languageCode = snapshot.data!;
              return Center(
                // margin: EdgeInsets.all(20),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                  ),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              getTranslated(context, "registration")??"",
                                style: GoogleFonts.courgette(color: Colors.white,fontSize: 30)
                            )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1.0),

                              ),
                                fillColor: Colors.white, filled: true,
                              //border: OutlineInputBorder(),
                              labelText: getTranslated(context, "first_name"),

                            ),
                            //style: TextStyle(color: Colors.white),
                            style: GoogleFonts.courgette(color: Colors.white,fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                            ),
                              labelText: getTranslated(context, "last_name"),
                          ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                              ),
                              labelText: 'Password',

                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: CountryListPick(
                            appBar: AppBar(
                              backgroundColor: Colors.white,
                              title: Text('Pick your country'),
                            ),

                            theme: CountryTheme(
                              isShowFlag: true,
                              isShowTitle: true,
                              isShowCode: false,
                              isDownIcon: true,
                              showEnglishName: true,
                              labelColor: Colors.white,
                            ),
                            initialSelection: languageCode,
                            // or
                            // initialSelection: 'US'
                            onChanged: (CountryCode? code) {
                              print(code?.name);
                              print(code?.code);
                              print(code?.dialCode);
                              print(code?.flagUri);
                            },
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, startPage);
                              },
                              height: 50,
                              shape: StadiumBorder(),
                              color: Theme.of(context).accentColor,
                              child: Center(
                                child: Text(
                                  getTranslated(context, 'registration')??"",
                                   style: GoogleFonts.courgette(color: Colors.white,fontSize: 20)
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }
  }
}