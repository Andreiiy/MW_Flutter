import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'decorations/theme_nofier.dart';
import 'decorations/theme_values.dart';
import 'localization/app_localization.dart';
import 'localization/language_constants.dart';
import 'router/custom_router.dart';
import 'router/route_constants.dart';

void main() => runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(blueTheme), child: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!)),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.getTheme(),
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("ru", "RU"),
          Locale("he", "IL")
        ],
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },

        home: new SplashScreen(),
        onGenerateRoute: MathAppRouter.generatedRoute,
        //initialRoute: homeRoute,
      );
    }
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('user',jsonEncode(AppData.user));
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, checkUser);
  }

  void navigationPage() {
    Navigator.popAndPushNamed(context, loginRoute);
    //Navigator.pushReplacementNamed(context, scheduleTimeRedactorPage);
  }

  void checkUser() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? jsonUser = null;//prefs.getString('user');
    // if(jsonUser != null){
    //   AppData.user = User.fromJson(jsonDecode(jsonUser));
    //   getCompany();
    // }else{
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.popAndPushNamed(context, startPage);
    });

    //}
  }

  @override
  void initState() {
    super.initState();
    startTime();
    //checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
        //child: new Image.asset('assets/images/splash2.jpg',fit: BoxFit.fill),
      ),
    );
  }
}
