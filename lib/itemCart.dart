import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

FirebaseFirestore store = FirebaseFirestore.instance;

class Kart extends StatefulWidget {
  @override
  State<Kart> createState() => _KartState();
}

class _KartState extends State<Kart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(child: Text('Your kart items')),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: store.collection('cart').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!.docs;
              final dataList = [];
              for (var item in items) {
                dataList.add(item.data());
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 132,
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
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
                                dataList[index]['productImage'].toString())),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataList[index]['productName'].toString(),
                              style: TextStyle(fontSize: 21),
                            ),
                            Text(
                              "Rs." +
                                  dataList[index]['price'].toString() +
                                  "99",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            Text(
                              dataList[index]['isPublished'].toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: null,
                                          child: Icon(Icons.add)),
                                      Text('0'),
                                      TextButton(
                                          onPressed: null,
                                          child: Center(
                                              child: Icon(Icons.remove))),
                                    ],
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              // OutlinedButton(
                              //     style: OutlinedButton.styleFrom(
                              //         primary: Colors.black54,
                              //         backgroundColor: Colors.yellow[700]),
                              //     onPressed: () {
                              //       // Navigator.push(
                              //       //     context,
                              //       //     MaterialPageRoute(
                              //       //         builder: (context) =>
                              //       //             ItemPage()));
                              //     },
                              //     child: Text('Buy Now' + index.toString())),
                              SizedBox(
                                width: 5,
                              ),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      primary: Colors.black54,
                                      backgroundColor: Colors.red[500]),
                                  onPressed: () {
                                    setState(() {
                                      dataList.where((element) =>
                                          element.id != dataList[index].id);
                                    });

                                    var snackBar = SnackBar(
                                        content: Text(
                                            'Cart Items ${dataList.length}'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: Text('Delete')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
