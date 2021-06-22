import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:wiki_search/app/app.locator.dart';
import 'package:wiki_search/app/app.router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Wiki Search',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
  }
}
