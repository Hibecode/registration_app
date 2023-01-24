import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/user_provider.dart';
import 'package:registration_app/views/forgot_password_page.dart';
import 'package:registration_app/views/signup_page.dart';

import '../app_styles.dart';
import '../model/user.dart';
import '../providers/auth_provider.dart';
import '../utility/validator.dart';
import '../widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  late String  _email, _password;

  @override
  Widget build(BuildContext context) {

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        Text("Authenticating ... Please wait")
      ],
    );

    AuthProvider auth = Provider.of<AuthProvider>(context);

    doSignin(){
      print('on doSignup');

      final form = formKey.currentState;
      if(form!.validate()){

        form.save();

        final Future<Map<String, dynamic>> respose = auth.login(_email, _password);

        respose.then((response){
          if (response['status']) {
            print('on doSignup');
            //User user = response['user'];

            //Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          } else {
            print('on doSignup3');
            Flushbar(
              title: "Failed Login",
              message: response['message'].toString(),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });


      } else{
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    }

    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Text('Sign In', style: kTitle.copyWith(color: kBlackMainColor),),
                    SizedBox(height: 60),



                    TextFormField(
                      autofocus: false,
                      validator: (input) => validateEmail(input!),
                      onSaved: (input) => _email = input!,
                      decoration: buildInputDecoration('Email'),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      autofocus: false,
                      obscureText: true,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (input) => _password = input!,
                      decoration: buildInputDecoration('Password'),
                    ),
                    const SizedBox(height: 20),

                    RichText(text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: 'Forgot Password?',
                          style: kBodyText1.copyWith(color: kGrey2Color, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                              );
                            }
                        ),
                      ]
                    )),


                    const SizedBox(height: 50),

                    auth.loggedInStatus == Status.Authenticating ? loading
                    :
                    longButtons('LOGIN', doSignin),
                    const SizedBox(height: 16),
                    CustomOutlinedButton2(text: 'LOGIN WITH FINGERPRINT', onPressed: () {}),


                    const SizedBox(height: 16),

                    RichText(text: TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                              text: "Don't have an account? ",
                              style: kBodyText1.copyWith(color: kGreyColor),

                          ),
                          TextSpan(
                              text: 'Sign up',
                              style: kBodyText1.copyWith(color: kPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => const SignUpPage()),
                                          (route) => false
                                  );
                                }
                          ),
                        ]
                    )),





                  ],
                ),
              ),
            ),
          ),
        ));
  }
}


class CustomOutlinedButton2 extends StatelessWidget {
  const CustomOutlinedButton2({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                side: const BorderSide(width: 2, color: kPrimaryColor),
                foregroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(12)
                )
            ),
            onPressed: onPressed,
            child: Text(text, style: kTitle.copyWith(fontSize: 14),),
          ),

    );
  }
}
