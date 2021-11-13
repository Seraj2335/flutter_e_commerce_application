import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_e_commerce_application/itemCart.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_application/logInPage.dart';

class ItemPage extends StatefulWidget {
  @override
  State<ItemPage> createState() => _ItemPageState();
}

FirebaseFirestore store = FirebaseFirestore.instance;

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            TextButton(
                onPressed: () {
                  // Hello
                },
                child: Text(
                  'Orders',
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, letterSpacing: 0.5),
                )),
            SizedBox(
              width: 8,
            ),
            Container(
              padding: EdgeInsets.only(right: 10, top: 5),
              child: IconButton(
                onPressed: () {
                  CircularProgressIndicator(
                    color: Colors.blue,
                  );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Kart()));
                },
                icon: Badge(
                  badgeColor: Colors.white,
                  badgeContent: Text(
                    '0',
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  shape: BadgeShape.circle,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
          title: Center(child: Text('E-Commerce')),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 110),
                child: CircleAvatar(child: Icon(Icons.person_outline)),
              )),
              ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text('kseraj96@gmail.com'),
                  trailing: TextButton(
                    child: Text('Edit'),
                    onPressed: () {
                      // Hello
                    },
                  )),
              ListTile(
                leading: Icon(Icons.phone_outlined),
                title: Text('9151362335'),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white70,
        body: StreamBuilder<QuerySnapshot>(
            stream: store.collection('items').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var arr = [];
                for (var item in snapshot.data!.docs) {
                  arr.add(item.data());
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      height: 132,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      margin: EdgeInsets.only(bottom: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      child: Row(
                        children: [
                          Image(
                              width: 100,
                              image: NetworkImage(
                                  arr[index]['productImage'].toString())),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                arr[index]['productName'].toString(),
                                style: TextStyle(fontSize: 19),
                              ),
                              Text(
                                "Rs." + arr[index]['price'].toString() + "90",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              Text(
                                arr[index]['isPublished'].toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: [
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          minimumSize: Size(0, 25),
                                          primary: Colors.black54,
                                          backgroundColor:
                                              Colors.lightBlueAccent[700]),
                                      onPressed: () {
                                        // not yet defined
                                      },
                                      child: Text(
                                        'Buy Now',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          minimumSize: Size(0, 25),
                                          primary: Colors.black54,
                                          backgroundColor: Colors.yellow[500]),
                                      onPressed: () {
                                        store.collection('cart').add({
                                          'isPublished': arr[index]
                                                  ['isPublished']
                                              .toString(),
                                          'price':
                                              arr[index]['price'].toString(),
                                          'productName': arr[index]
                                                  ['productName']
                                              .toString()
                                              .toString(),
                                          'productImage': arr[index]
                                                  ['productImage']
                                              .toString()
                                              .toString()
                                        });
                                      },
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: arr.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
