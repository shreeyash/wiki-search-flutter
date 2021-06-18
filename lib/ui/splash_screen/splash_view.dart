import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
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
