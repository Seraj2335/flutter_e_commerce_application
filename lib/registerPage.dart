import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_e_commerce_application/informationPage.dart';
import 'package:flutter_e_commerce_application/logInPage.dart';
import 'companyRegisterPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name;
  late String email;
  late String phoneNumber;
  late String password;
  bool value = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Experience the all new app!',
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Register to get started.',
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(
          height: 25,
        ),
        TextField(
          decoration: InputDecoration(
              hintText: 'Name',
              prefixIcon: Icon(Icons.person_outline_outlined)),
          onChanged: (value) {
            name = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
              hintText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
          onChanged: (value) {
            email = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
              hintText: 'Phone Number', prefixIcon: Icon(Icons.phone_outlined)),
          onChanged: (value) {
            phoneNumber = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
              hintText: 'Password', prefixIcon: Icon(Icons.lock_outline)),
          onChanged: (value) {
            password = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
              hintText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outlined)),
          onChanged: (value) {
            password = value;
          },
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              padding: EdgeInsets.only(top: 15, bottom: 15)),
          onPressed: () async {
            try {
              setState(() {
                value = !value;
              });
              Center(
                child: CircularProgressIndicator(),
              );
              Future.delayed(Duration(microseconds: 3500));
              // await _auth.createUserWithEmailAndPassword(
              //     email: email, password: password);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GreetingPage()));
            } catch (e) {
              print('Hello');
            }
          },
          child: value
              ? SizedBox(
                  height: 15,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  'Register',
                  style: TextStyle(fontSize: 19, letterSpacing: 1),
                ),
        ),
        Row(
          children: [
            Text(
              ' Already have account.',
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInPage()));
                },
                child: Text(
                  'LogIn',
                  style: TextStyle(fontSize: 19, color: Colors.blueAccent),
                ))
          ],
        ),
        Center(
          child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CompanyRegisterPage()));
              },
              child: Text('Register Compnay')),
        )
      ],
    );
  }
}
