import 'package:flutter/material.dart';
import 'package:near/provider_app.dart';
import 'package:near/screen_main.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider appProvider, Widget child) {
      return (appProvider.isRegistered)
          ? MainScreen()
          : Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black45,
                      BlendMode.darken,
                    ),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg.jpeg'),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Center(),
                    Text(
                      'Near',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Start or Join a Video Meeting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Expanded(child: Container()),
                    appProvider.isStorageGranted
                        ? RaisedButton(
                            padding: EdgeInsets.only(
                                left: 60, right: 60, top: 10, bottom: 10),
                            color: Colors.blueAccent,
                            onPressed: () => appProvider.checkPermission(),
                            child: Text(
                              'Start Meeting',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : Text(
                            'Storage Persmission are Denied',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '*File read permission are required to continue',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            );
    });
  }
}
