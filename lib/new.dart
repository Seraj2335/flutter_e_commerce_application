import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Drawer extends StatefulWidget {
  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  FirebaseFirestore store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final data = store.collection('cart').get();
    return ListView.builder(itemBuilder: (context, index) {
      return Card();
    });
  }
}
