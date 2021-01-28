import 'package:flutter/material.dart';
import 'package:world_time/models/user.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:world_time/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child:   MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Wrapper(),
          '/location': (context) => ChooseLocation(),
        },
      ),
    );
  }
}
