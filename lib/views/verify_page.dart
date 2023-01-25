import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/user_provider.dart';
import 'package:registration_app/views/change_password_page.dart';
import 'package:registration_app/views/forgot_password_page.dart';
import 'package:registration_app/views/signin_page.dart';
import 'package:registration_app/views/signup_page.dart';
import 'package:registration_app/views/verify_page.dart';

import '../app_styles.dart';
import '../model/user.dart';
import '../providers/auth_provider.dart';
import '../utility/validator.dart';
import '../widgets.dart';


class VerifyPage extends StatefulWidget {
  final String email;
  VerifyPage(this.email);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late String _code;
  late bool _onEditing;

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);
    //User user = Provider.of<UserProvider>(context).user;

    doVerification() {
      print('on do-verification');

      final form = formKey.currentState;
      if(_code.length == 6){


        final Future<Map<String, dynamic>> responseState = auth.verify(widget.email, _code);
        print(widget.email);

        responseState.then((response){
          if (response['status']) {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
            );
            Flushbar(
              title: "Error",
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
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
                Text('Verification ID', style: kTitle.copyWith(color: kBlackMainColor),),
                const SizedBox(height: 5),
                Text('Please type the verification code sent to ${replaceString(widget.email)}',
                  style: kBodyText1.copyWith(color: kBlackMainColor),),
                const SizedBox(height: 60),

                VerificationCode(
                  textStyle: const TextStyle(fontSize: 20.0, color: kBlackMainColor),
                  keyboardType: TextInputType.number,
                  length: 6,

                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),

                const SizedBox(height: 30,),

                RichText(text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                          text: 'Resend Code',
                          style: kBodyText1.copyWith(color: kGrey2Color, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                              if(_code.length == 6){


                                final Future<Map<String, dynamic>> responseState = auth.verify(widget.email, _code);

                                responseState.then((response){
                                  if (response['status']) {

                                  }
                                });
                              }
                            }
                      ),
                    ]
                )),

                const SizedBox(height: 100),

                longButtons('VERIFY', doVerification),

                const SizedBox(height: 16),




              ],
            ),
          ),
        ),
      ),
    );
  }
}

replaceString(String email) {
  var firstPart = email.split('@')[0];
  var secondPart = email.split('@')[1];
  var shownText = firstPart.substring(0,4);
  return '$shownText***@$secondPart';
}
