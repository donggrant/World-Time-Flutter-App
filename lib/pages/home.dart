import 'package:flutter/material.dart';
import 'package:world_time/pages/location_list.dart';
import 'package:world_time/services/auth.dart';
import 'package:world_time/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().locations,
      child: LocationList(),
    );
  }
}
