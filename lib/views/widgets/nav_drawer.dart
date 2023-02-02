// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/controller/wrapper.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? userName;
  String? displayName;

  @override
  void initState() {
    if (_auth.currentUser!.phoneNumber != null) {
      userName = _auth.currentUser!.phoneNumber!;
    } else if (_auth.currentUser!.email != null) {
      userName = _auth.currentUser!.email!;
    } else {
      userName = "butamy@gmail.com";
    }

    if (_auth.currentUser!.displayName != null) {
      displayName = _auth.currentUser!.displayName!;
    } else {
      displayName = "Butamy";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: const EdgeInsets.all(0), children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFbdbdbd)),
          accountName: Text(
            displayName.toString(),
            style: TextStyle(fontSize: 18),
          ),
          accountEmail: Text(userName.toString()),
          currentAccountPictureSize: Size.square(50),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 165, 255, 137),
            child: Text(
              "B",
              style: TextStyle(fontSize: 30.0, color: Colors.blue),
            ), //Text
          ), //circleAvatar
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(' Logout '),
          onTap: () async {
            await _auth.signOut();
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Wrapper()),
            );
          },
        ), //UserAccountDrawerHeader
      ]),
    );
  }
}
