import 'package:flutter/material.dart';
import 'package:registration_app/app_styles.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Align(
            alignment: Alignment.center,
            child: Text('HOME PAGE', style: TextStyle(
                fontSize: 30,
                color: kBlackMainColor,
                fontWeight: FontWeight.w700
            ),),
          )

        ],
      ),
    );
  }
}
