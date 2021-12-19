import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_application/companyListPage.dart';

class CompanyRegisterPage extends StatefulWidget {
  @override
  State<CompanyRegisterPage> createState() => _CompanyRegisterPageState();
}

class _CompanyRegisterPageState extends State<CompanyRegisterPage> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  late String companyName;
  late String package;
  late String companyDetails;
  late String registrationDate;
  late String testDate;
  late String status;
  late String internshipAmountAndDuration;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register Company Details'),
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 35, right: 35),
          children: [
            TextField(
                decoration: InputDecoration(hintText: 'CompanyName'),
                onChanged: (value) {
                  companyName = value;
                }),
            TextField(
                decoration: InputDecoration(hintText: 'Package'),
                onChanged: (value) {
                  package = value;
                }),
            SizedBox(
              height: 10,
            ),
            TextField(
                decoration:
                    InputDecoration(hintText: 'Last Date Of Registration'),
                onChanged: (value) {
                  registrationDate = value;
                }),
            SizedBox(
              height: 10,
            ),
            TextField(
                decoration: InputDecoration(hintText: 'Test Date'),
                onChanged: (value) {
                  testDate = value;
                }),
            SizedBox(
              height: 10,
            ),
            TextField(
                decoration: InputDecoration(hintText: 'status'),
                onChanged: (value) {
                  status = value;
                }),
            SizedBox(
              height: 10,
            ),
            TextField(
                decoration:
                    InputDecoration(hintText: 'Intership Amout And Duration'),
                onChanged: (value) {
                  internshipAmountAndDuration = value;
                }),
            SizedBox(
              height: 10,
            ),
            TextField(
                decoration: InputDecoration(hintText: 'About the Company'),
                onChanged: (value) {
                  companyDetails = value;
                }),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    backgroundColor: Colors.blue),
                onPressed: () {
                  store.collection('testDetails').add({
                    'companyName': companyName,
                    'package': package,
                    'status': status,
                    'registrationDate': registrationDate,
                    'testDate': testDate,
                    'companyDetails': companyDetails,
                    'intershipAmountAndDuration': internshipAmountAndDuration
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompanyListPage()));
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 1, fontSize: 16),
                )),
            Row(
              children: [
                Text('Already Registered?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyListPage()));
                    },
                    child: Text('See The List'))
              ],
            )
          ],
        ));
  }
}
