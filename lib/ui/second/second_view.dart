import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:wiki_search/ui/second/second_viewmodel.dart';

class SecondView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SecondViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: model.doSomething,
        ),
        body: Center(
          child: Text(model.title),
        ),
      ),
      viewModelBuilder: () => SecondViewModel(),
    );
  }
}
