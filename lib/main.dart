import 'package:flutter/material.dart';
import 'package:near/provider_app.dart';
import 'package:near/provider_meeting.dart';
import 'package:near/screen_splash.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => MeetingsProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<AppProvider>(context).currentTheme,
      home: Splash(),
    );
  }
}
