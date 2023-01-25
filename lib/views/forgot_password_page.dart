import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/views/signin_page.dart';
import 'package:registration_app/views/signup_page.dart';
import 'package:registration_app/views/verify_page.dart';

import '../app_styles.dart';
import '../model/user.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../utility/validator.dart';
import '../widgets.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late String _email;

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);

    doForgotPassword() {
      print('on do-forgot-password');

      final form = formKey.currentState;
      if(form!.validate()){
        print('on do-forgot-password2');

        form.save();
        User user = User(
          firstName: '', lastName: '',
          email: _email, phoneNumber: '', password: '',

        );
        print(user.email.toString());
        //Provider.of<UserProvider>(context).setUser(user);
        print(user.email.toString());


        final Future<Map<String, dynamic>> responseState = auth.forgotPassword(_email);

        responseState.then((response){
          if (response['status']) {
            print('on do-forgot-password3');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerifyPage(_email)),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerifyPage(_email)),
            );
            /*Flushbar(
              title: "Error",
              message: response['message'].toString(),
              duration: const Duration(seconds: 3),
            ).show(context);*/
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text('Forgot Password', style: kTitle.copyWith(color: kBlackMainColor),),
                const SizedBox(height: 5),
                Text('Enter your email to reset your password',
                  style: kBodyText1.copyWith(color: kBlackMainColor),),
                const SizedBox(height: 40),

                TextFormField(
                  autofocus: false,
                  validator: (input) => validateEmail(input!),
                  onSaved: (input) => _email = input!,
                  decoration: buildInputDecoration('Email'),
                ),

                const SizedBox(height: 100),

                longButtons('CONTINUE', doForgotPassword),

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
    );
  }
}
