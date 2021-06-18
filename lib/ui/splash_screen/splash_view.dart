import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wiki_search/app/app.locator.dart';
import 'package:wiki_search/app/app.router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navigation = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      // 5s over, navigate to a new page
      navigation.replaceWith(Routes.startUpView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/wikiLogo.png"),
          Text(
            'Wiki Search',
            style: TextStyle(
                color: Colors.grey[700], decoration: TextDecoration.none),
          ),
          Text(
            'Shreeyash Hatitashya',
            style: TextStyle(
                color: Colors.grey[700],
                decoration: TextDecoration.none,
                fontSize: 24),
          ),
        ],
      ),
    );
  }
}
