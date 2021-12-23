import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final int index;
  final String email;
  final String productImage;
  OrderPage(
      {required this.index, required this.email, required this.productImage});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  late bool value = false;
  late String name;
  late String phoneNumber;
  late String pinCode;
  late String address;

  @override
  Widget build(BuildContext context) {
    return value
        ? Scaffold(
            body: Center(
            child: Container(
              margin: EdgeInsets.only(top: 280),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ordered',
                    style: TextStyle(fontSize: 19),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 110, right: 50),
                    child: Row(
                      children: [
                        Text('See more Products'),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 31,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        : Scaffold(
            body: ListView(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              children: [
                Text(
                  'ENTER YOUR ORDER DETAILS BELOW',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.2),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            name = value;
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.2),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pin Code',
                          style: TextStyle(color: Colors.black45),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              pinCode = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adress',
                          style: TextStyle(color: Colors.black45),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 16),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              address = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: store.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final myData = snapshot.data!.docs;
                        final listData = [];
                        for (var data in myData) {
                          listData.add(data.data());
                        }

                        return Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: Colors.black, width: 0.5)),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: value ? Colors.amber : Colors.blue,
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15)),
                                onPressed: () {
                                  store.collection('orders').add({
                                    'email': widget.email,
                                    'receiver': name,
                                    'receiverPhoneNumber': phoneNumber,
                                    'pincode': pinCode,
                                    'address': address,
                                    'image': widget.productImage
                                  });

                                  setState(() {
                                    value = !value;
                                  });
                                },
                                child: Text(
                                  'PLACE ORDER',
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.normal),
                                )));
                      }
                      return CircularProgressIndicator();
                    })
              ],
            ),
          );
  }
}
