import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/auth.dart';
import 'package:world_time/models/user.dart';
import 'package:world_time/services/database.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/services/world_time.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {

  Map data = {};

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final locations = Provider.of<QuerySnapshot>(context);
    String country = "";
    String city = "";
    for(var doc in locations.documents){
      country = doc.data['country'];
      city = doc.data['city'];
    }

    final user = Provider.of<User>(context);
    
    void setupWorldTime(String a, String b) async {

      // change to produce start location based on user data
      WorldTime instance = WorldTime(location:a, flag: b+'.png', url: a + ", " + b);

      await instance.getTime();
      data = {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      };
      print(data);
    }

    setupWorldTime(city, country);

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    //set background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image:  DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                      };
                    });
                    String s = data['flag'];
                    await DatabaseService(uid: user.uid).updateUserData(s.substring(0, s.indexOf('.')), data['location']);
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 80),
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign Out'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
