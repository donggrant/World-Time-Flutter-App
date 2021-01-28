import 'package:flutter/material.dart';
import 'package:world_time/services/database.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/authenticate.dart';
import 'package:world_time/models/user.dart';
import 'package:provider/provider.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: 'Charlottesville', flag: 'United States.png', url: 'Charlottesville, United States'),
    WorldTime(location: 'Beijing', flag: 'China.png', url: 'Beijing, China'),
    WorldTime(location: 'Kyoto', flag: 'Japan.png', url: 'Kyoto, Japan'),
    WorldTime(location: 'London', flag: 'United Kingdom.png', url: 'London, United Kingdom'),
    WorldTime(location: 'Dubai', flag: 'United Arab Emirates.png', url: 'Dubai, United Arab Emirates'),
    WorldTime(location: 'Seoul', flag: 'South Korea.png', url: 'Seoul, South Korea'),
    WorldTime(location: 'Lord Howe Island', flag: 'Australia.png', url: 'Lord Howe Island, Australia'),
    WorldTime(location: 'Maputo', flag: 'Mozambique.png', url: 'Maputo, Mozambique'),
    WorldTime(location: "Amsterdam", flag: 'Netherlands.png', url: 'Amsterdam, Netherlands'),
    WorldTime(location: "Oslo", flag: 'Norway.png', url: 'Oslo, Norway'),
    WorldTime(location: "Philipsburg", flag: 'Sint Maarten.png', url: 'Philipsburg, Sint Maarten'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    //navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Card(
              color: Colors.grey[300],
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
