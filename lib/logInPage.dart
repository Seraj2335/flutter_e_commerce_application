import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_application/itemPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

FirebaseFirestore store = FirebaseFirestore.instance;

class _LogInPageState extends State<LogInPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  // Future<int> getLength() async {
  //   final response = await store.collection('cart').get();
  //   int count = 0;
  //   for (var responses in response.docs) {
  //     count++;
  //   }
  //   return count;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 50,
            ),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined)),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline)),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.blue,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        padding: EdgeInsets.only(top: 20, bottom: 20)),
                    onPressed: () async {
                      Future.delayed(Duration(minutes: 1));
                      Center(child: CircularProgressIndicator());

                      // final user = await _auth.signInWithEmailAndPassword(
                      //     email: email, password: password);
                      // if (user.user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ItemPage()));
                      // }
                    },
                    child: Text(
                      'LOG IN',
                      style: TextStyle(letterSpacing: 0.5),
                    ))
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 470),
              child: SvgPicture.asset(
                'assets/flat-mountains.svg',
                fit: BoxFit.fill,
              ),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(80)))),
        ],
      ),
    );
  }
}
