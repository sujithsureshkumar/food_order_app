// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_order_app/views/screens/phone_number.dart';

import '../../firebase_services/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              width: 200,
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/flutter_logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  //await _auth.signOut();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NameFormPage()),
                  // );
                  googleLogin();
                },
                style: TextButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    maximumSize: const Size(300, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.google,
                        size: 25.0, color: Colors.white),
                    Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text("Google"))),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  //await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneNumber()),
                  );
                },
                style: TextButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    maximumSize: const Size(300, 50),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.phone,
                        size: 25.0, color: Colors.white),
                    Expanded(
                        child: Align(
                            alignment: Alignment.center, child: Text("Phone"))),
                  ],
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
