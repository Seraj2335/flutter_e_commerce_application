import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'itemPage.dart';
import 'package:flutter_e_commerce_application/itemPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name;
  late String email;
  late String phoneNumber;
  late String password;
  bool state = true;
  bool value = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return state
        ? ListView(
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
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined)),
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
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    store.collection('users').add({
                      'name': name,
                      'email': email,
                      'phoneNumber': phoneNumber,
                    });
                    showDialog(
                        context: context,
                        builder: (context) => Container(
                              margin: EdgeInsets.only(
                                  top: 200, bottom: 250, left: 40, right: 40),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white),
                              child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Center(
                                        child: CircleAvatar(
                                            radius: 34,
                                            child: Icon(
                                              Icons.check,
                                              size: 25,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Text(
                                          'Registered',
                                          style: TextStyle(fontSize: 21),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 100),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 22,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('LogIn'))
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ));
                    setState(() {
                      state = !state;
                    });
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
                        setState(() {
                          state = !state;
                        });
                      },
                      child: Text(
                        'LogIn',
                        style:
                            TextStyle(fontSize: 19, color: Colors.blueAccent),
                      ))
                ],
              ),
            ],
          )
        : ListView(
            children: [
              Text(
                'LogIn',
                style: TextStyle(fontSize: 24, letterSpacing: 1),
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
                    hintText: 'Password', prefixIcon: Icon(Icons.lock_outline)),
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
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user.user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemPage(
                                    email: email,
                                  )));
                    }
                  },
                  child: Text(
                    'LOG IN',
                    style: TextStyle(letterSpacing: 0.5),
                  )),
              Row(
                children: [
                  Text("Don't have account?"),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          state = !state;
                        });
                      },
                      child: Text('Sign Up'))
                ],
              )
            ],
          );
  }
}
