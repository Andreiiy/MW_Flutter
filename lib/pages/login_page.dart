import 'dart:async';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/models/user.dart';
import 'package:math_world/remote/repository.dart';
import 'package:math_world/widgets/loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Repository _repository = Repository();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final RoundedLoadingButtonController submitButtonController =  RoundedLoadingButtonController();

  bool? emailIsEmpty;
  bool? passwordValid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xff256E59),
      appBar: AppBar(
        backgroundColor: Color(0xff484443),
        title: Text(
          getTranslated(context, 'login') ?? "",
          style: GoogleFonts.courgette(color: Colors.white, fontSize: 16),
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
                                getTranslated(context, "registration") ?? "",
                                style: GoogleFonts.courgette(
                                    color: Colors.white, fontSize: 30))),
                        //Email
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            cursorColor: Colors.white,
                            controller: emailController,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              labelText: "Email",
                              labelStyle:
                              GoogleFonts.courgette(color: Colors.white),
                              //error/////////////////////////////////////////////
                              errorText: emailIsEmpty != null? emailIsEmpty == false?"Enter Email":null:null,
                              errorStyle: GoogleFonts.courgette(color: Colors.red),
                              errorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.0),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.0),
                              ),
                            ),
                            style: GoogleFonts.courgette(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                        //Password
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                labelText: 'Password',
                                errorText: passwordValid != null? passwordValid == false?"Enter password":null:null,
                                errorStyle: GoogleFonts.courgette(color: Colors.red),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1.0),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1.0),
                                ),
                                labelStyle:
                                GoogleFonts.courgette(color: Colors.white)
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child:
                            RoundedLoadingButton(
                              color: Theme.of(context).accentColor,
                              successColor: Colors.green,
                              controller: submitButtonController,
                              onPressed: () {
                                if(_validateForm())
                                  _submit(submitButtonController);
                                else
                                  submitButtonController.reset();
                              } ,
                              valueColor: Colors.white,
                              borderRadius: 30,
                              child:  Text(
                                  getTranslated(context, 'login') ??
                                      "",
                                  style: GoogleFonts.courgette(
                                      color: Colors.white, fontSize: 20)),
                            )
                        ),

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
  _submit(RoundedLoadingButtonController submitButtonController) async {
    // ResponseFromServer?  response =  await _repository.login("tatarenkoandrei7@gmail.com","111");
    // User user = User.fromJson(response?.data);
    //
    // Navigator.pushNamed(context, startPage);
    Timer(Duration(seconds: 5), () {
      submitButtonController.error();
      Timer(Duration(seconds: 1), () {
        submitButtonController.reset();
      });
    });

  }

  bool _validateForm(){
    if(!_validateEmail(emailController.text) || !_validatePassword(passwordController.text)) {
      setState(() {});
      return false;
    }
    else
      return true;
  }


  bool _validatePassword(String value) {
    if (value.isEmpty) {
      passwordValid = false;
      return false;
    }
    else {
      passwordValid = true;
      return true;
    }
  }
  bool _validateEmail(String value) {
    emailIsEmpty = false;
    if (value.isEmpty) {
      return false;
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
      emailIsEmpty = true;
      return true;
    }
    return false;
  }
  }



