import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/user_provider.dart';
import 'package:registration_app/views/forgot_password_page.dart';
import 'package:registration_app/views/signin_page.dart';
import 'package:registration_app/views/signup_page.dart';
import 'package:registration_app/views/verify_page.dart';

import '../app_styles.dart';
import '../model/user.dart';
import '../providers/auth_provider.dart';
import '../utility/validator.dart';
import '../widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();

  late String  _oldPassword, _newPassword, _confirmNewPassword;

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

    doReset(){
      print('on doReset');

      final form = formKey.currentState;
      if(form!.validate()){

        form.save();

        final Future<Map<String, dynamic>> respose = auth.resetPassword(_newPassword);

        if (_newPassword == _confirmNewPassword) {
          respose.then((response) {
            if (response['status']) {
              print('on doreset');
              Flushbar(
                title: "Reset Password",
                message: 'Mail has been sent',
                duration: const Duration(seconds: 5),
              ).show(context);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const SignInPage()),
                      (route) => false
              );
            } else {
              Flushbar(
                title: "Failed Reset",
                message: response['message'].toString(),
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          });
        } else{
          Flushbar(
            title: 'Mismatch password',
            message: 'Please enter valid confirm password',
            duration: const Duration(seconds: 5),
          ).show(context);
        }

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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const SignInPage()),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Text('Change Password', style: kTitle.copyWith(color: kBlackMainColor),),
                    SizedBox(height: 60),


                    TextFormField(
                      autofocus: false,
                      obscureText: true,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (input) => _newPassword = input!,
                      decoration: buildInputDecoration('New Password'),
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
                      onSaved: (input) => _confirmNewPassword = input!,
                      decoration: buildInputDecoration('Confirm Password'),
                    ),



                    const SizedBox(height: 50),


                    longButtons('RESET PASSWORD', doReset),


                    const SizedBox(height: 16),

                    RichText(
                        text: TextSpan(
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
