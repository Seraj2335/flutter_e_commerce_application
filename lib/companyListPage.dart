import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyListPage extends StatefulWidget {
  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Company Data List')),
        body: StreamBuilder<QuerySnapshot>(
            stream: store.collection('testDetails').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final items = snapshot.data!.docs;
                final dataList = [];
                for (var item in items) {
                  dataList.add(item.data());
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return OutlinedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Container(
                                    color: Colors.white,
                                    child: ListView(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 10, right: 20),
                                      children: [
                                        Text(
                                          dataList[index]['companyName']
                                              .toString(),
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Company Details',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              dataList[index]['companyDetails']
                                                  .toString(),
                                              style:
                                                  TextStyle(letterSpacing: 0.5),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Package: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(dataList[index]['package']
                                                .toString())
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Registration Date: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(dataList[index]
                                                    ['registrationDate']
                                                .toString())
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Status: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(dataList[index]['status']
                                                .toString())
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Internship: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(dataList[index][
                                                    'intershipAmountAndDuration']
                                                .toString())
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Test Date: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(dataList[index]['testDate']
                                                .toString())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(color: Colors.white10),
                          width: 380,
                          height: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dataList[index]['companyName'].toString(),
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.normal),
                              ),
                              ListTile(
                                dense: true,
                                title: Text('Package'),
                                trailing: Text(
                                  dataList[index]['package'].toString() +
                                      ' LPA',
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                              ListTile(
                                  dense: true,
                                  title: Text('Status'),
                                  trailing: Text(
                                    dataList[index]['status'].toString(),
                                    style: TextStyle(color: Colors.black26),
                                  ))
                            ],
                          ),
                        ));
                  },
                  itemCount: dataList.length,
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
