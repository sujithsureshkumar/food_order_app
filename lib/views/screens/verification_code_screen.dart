// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../controller/wrapper.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String phoneNumber;
  const VerificationCodeScreen({super.key, required this.phoneNumber});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationString;
  String? smsCode;
  bool _isloading = false;
  bool _isScreenloading = false;

  navigateAfterOtp() async {
    String uid = _auth.currentUser!.uid;

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Wrapper()),
        (Route<dynamic> route) => false);
  }

  Future verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationString!, smsCode: smsCode!);

    // Sign the user in (or link) with the credential
    await _auth.signInWithCredential(credential);
  }

  void phoneVerification() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      codeSent: (String verificationId, int? resendToken) async {
        print("verification id");
        print(verificationId);
        verificationString = verificationId;
        // Update the UI - wait for the user to enter the SMS code
        // String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationString = verificationId;
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        setState(() {
          _isScreenloading = true;
        });
        await _auth.signInWithCredential(phoneAuthCredential);
        await navigateAfterOtp();
        setState(() {
          _isScreenloading = false;
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Error The provided phone number is not valid')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')),
          );
        }
      },
    );
  }

  @override
  void initState() {
    print(widget.phoneNumber);
    phoneVerification();
    super.initState();
  }

  @override
  void dispose() {
    verificationString = null;
    smsCode = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: _isScreenloading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_new)),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image(
                    width: 200,
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/flutter_logo.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(
                      "Enter your verification code",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  VerificationCode(
                    itemSize: 40,
                    digitsOnly: true,
                    fullBorder: true,
                    fillColor: Colors.white,
                    textStyle:
                        TextStyle(fontSize: 20.0, color: Colors.red[900]),
                    keyboardType: TextInputType.number,
                    underlineWidth: 3,
                    underlineUnfocusedColor: Color.fromARGB(255, 211, 204, 204),
                    underlineColor: Colors
                        .amber, // If this is null it will use primaryColor: Colors.red from Theme
                    length: 6,
                    cursorColor: Colors
                        .blue, // If this is null it will default to the ambient
                    // clearAll is NOT required, you can delete it
                    // takes any widget, so you can implement your design

                    onCompleted: (String value) {
                      setState(() {
                        //_code = value;
                        smsCode = value;
                        print(smsCode);
                      });
                    },
                    onEditing: (bool value) {
                      setState(() {
                        // _onEditing = value;
                      });
                      // if (!_onEditing) FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Didn't get a code?",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                    backgroundColor: Color(0xFF0c3cac),
                    onPressed: _isloading
                        ? null
                        : () async {
                            if (verificationString != null && smsCode != null) {
                              setState(() {
                                _isloading = true;
                              });
                              await verifyOtp();
                              setState(() {
                                _isloading = false;
                              });
                            }

                            navigateAfterOtp();
                          },
                    child: _isloading
                        ? Center(child: CircularProgressIndicator())
                        : Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
      )),
    );
  }
}
