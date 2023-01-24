import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/app_styles.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/utility/validator.dart';
import 'package:registration_app/views/signin_page.dart';
import 'package:registration_app/widgets.dart';
import 'package:registration_app/model/user.dart';

import '../providers/user_provider.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final formKey = GlobalKey<FormState>();

  late String _name, _email, _password;

  @override
  Widget build(BuildContext context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);

    var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      CircularProgressIndicator(),
    Text("Registering ... Please wait")
    ],
    );


    doSignup(){
      print('on doSignup');

      final form = formKey.currentState;
      if(form!.validate()){

        form.save();


        auth.register(_name, _email, _password).then((response)   {
          if(response['status']){
            User user = response['data'];
            Provider.of<UserProvider>(context).setUser(user);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          } else {
            if (response['message'].toString().toLowerCase().contains('user already exists')) {
              Flushbar(
                title: "Registration Successful",
                message: response['message'].toString(),
                duration: const Duration(seconds: 10),
              ).show(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            }
            Flushbar(
              title: "Registration fail",
              message: response['message'].toString(),
              duration: const Duration(seconds: 10),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                 Text('Create Account', style: kTitle.copyWith(color: kBlackMainColor),),
                SizedBox(height: 60),

                TextFormField(
                  autofocus: false,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (input) => _name = input!,
                  decoration: buildInputDecoration('Name'),
                ),

                const SizedBox(height: 30),

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

                const SizedBox(height: 50),
                auth.loggedInStatus == Status.Authenticating ? loading :
                longButtons('SIGN UP', doSignup),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text('Already have an account?',
                        style: kBodyText1.copyWith(color: kGreyColor),),
                      onPressed: () {

                      },
                    ),
                    TextButton(
                      child: Text('Log in',
                        style: kBodyText1.copyWith(color: kPrimaryColor),),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                                (route) => false
                        );
                      },
                    ),
                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}



