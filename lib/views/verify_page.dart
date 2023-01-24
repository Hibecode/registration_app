import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/views/signin_page.dart';
import 'package:registration_app/views/signup_page.dart';
import 'package:registration_app/views/verify_page.dart';

import '../app_styles.dart';
import '../providers/auth_provider.dart';
import '../utility/validator.dart';
import '../widgets.dart';


class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late String _email;

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);

    doVerification() {
      print('on do-verification');

      final form = formKey.currentState;
      if(form!.validate()){

        form.save();

        final Future<Map<String, dynamic>> responseState = auth.forgotPassword(_email);

        responseState.then((response){
          if (response['status']) {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VerifyPage()),
            );
          } else {
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text('Verification ID', style: kTitle.copyWith(color: kBlackMainColor),),
              const SizedBox(height: 5),
              Text('Please type the verification code sent to janedoe***@gmail.com',
                style: kBodyText1.copyWith(color: kBlackMainColor),),
              const SizedBox(height: 60),

              TextFormField(
                autofocus: false,
                validator: (input) => validateEmail(input!),
                onSaved: (input) => _email = input!,
                decoration: buildInputDecoration('Email'),
              ),

              const SizedBox(height: 100),

              longButtons('VERIFY', doVerification),

              const SizedBox(height: 16),




            ],
          ),
        ),
      ),
    );
  }
}
