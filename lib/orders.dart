import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_application/itemCart.dart';

class Orders extends StatefulWidget {
  final String email;
  Orders({required this.email});
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: store.collection('orders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final streamList = snapshot.data!.docs;
              final lisData = [];
              for (var data in streamList) {
                if (data['email'] == widget.email) {
                  lisData.add(data.data());
                }
              }
              return ListView.builder(
                padding: EdgeInsets.only(top: 40),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black38, width: 0.2)),
                    child: Column(
                      children: [
                        Text('To ' + lisData[index]['receiver']),
                        Container(
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Image(
                                image: NetworkImage(lisData[index]['image']))),
                        Text('will be delivered to ' +
                            lisData[index]['address'] +
                            ', Pincode: ' +
                            lisData[index]['pincode'])
                      ],
                    ),
                  );
                },
                itemCount: lisData.length,
              );
            }
            return Center(
              child: Text('Do data Available'),
            );
          }),
    );
  }
}
