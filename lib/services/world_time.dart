import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:world_time/services/database.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      // make the request
      Response response = await get('https://timezone.abstractapi.com/v1/current_time?api_key=35629f1c13314218b3fd86d1972b01a8&location=$url');
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['datetime'];
      int offset = data['gmt_offset'];
      // print(datetime);
      // print(offset);

      //create DateTime Object
      DateTime now = DateTime.parse(datetime);
      // now = now.add(Duration(hours: offset));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      //set time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'NA time';
      location = 'location not available';
    }

  }


}

