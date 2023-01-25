import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/providers/user_provider.dart';
import 'package:registration_app/views/change_password_page.dart';
import 'package:registration_app/views/forgot_password_page.dart';
import 'package:registration_app/views/home_page.dart';
import 'package:registration_app/views/onboarding_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registration_app/views/signup_page.dart';
import 'package:registration_app/views/verify_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? seenOnboard;

void main() /*async*/ {
  // To load on board screens for the first time only
  /*SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false; *///if null set to false
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),

    ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme
            ),
            primarySwatch: Colors.blue,
          ),
          home: const OnBoardingPage(),
      ),
    );

  }
}

