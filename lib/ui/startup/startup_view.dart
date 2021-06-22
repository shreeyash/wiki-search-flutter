import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:stacked/stacked.dart';
import 'package:wiki_search/app/util.dart';

import 'package:wiki_search/ui/startup/startup_viewmodel.dart';

class StartUpView extends StatefulWidget {
  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  final _formKey = GlobalKey<FormState>();
  StreamSubscription? subscription;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackbar);
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<StartUpViewModel>.reactive(
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text('Wiki Search'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              controller: model.searchController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.blue,
                          onPressed: () async {
                            if (isConnected) {
                              if (_formKey.currentState!.validate()) {
                                model.updateSearchKey();
                                model.initialise();
                              }
                            } else {
                              showConnectivitySnackbar(ConnectivityResult.none);
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    !isConnected
                        ? Center(
                            child: SizedBox(
                              child: Text(
                                  "Please turn on the internet, to use wiki search!"),
                            ),
                          )
                        : model.isBusy
                            ? Center(
                                child: SizedBox(
                                  width: 50,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.pacman,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            : model.wikiDataList.isEmpty
                                ? Text('No data found..')
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        onTap: () => model.launchURL(
                                            model.wikiDataList[index].pageid ??
                                                0),
                                        title: Text(
                                            model.wikiDataList[index].title ??
                                                "No Title"),
                                        subtitle: Text(model.wikiDataList[index]
                                                .terms?.description?[0] ??
                                            "No Title"),
                                        leading: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Image.network(
                                            model.wikiDataList[index].thumbnail
                                                    ?.source ??
                                                "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemCount: model.wikiDataList.length,
                                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
        viewModelBuilder: () => StartUpViewModel(),
      );

  showConnectivitySnackbar(ConnectivityResult result) async {
    final hasInternet = result != ConnectivityResult.none;

    setState(() {
      isConnected = hasInternet;
    });

    final message = hasInternet
        ? "You have active internet connection"
        : "No internet connection";
    final color = hasInternet ? Colors.green : Colors.red;

    Utils.showTopSnackBar(context, message, color);
  }
}
