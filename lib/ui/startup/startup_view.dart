import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:stacked/stacked.dart';

import 'package:wiki_search/ui/startup/startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            model.updateSearchKey();
                            model.initialise();
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  model.isBusy
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
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  onTap: () => model.launchURL(
                                      model.wikiDataList[index].pageid ?? 0),
                                  title: Text(model.wikiDataList[index].title ??
                                      "No Title"),
                                  subtitle: Text(model.wikiDataList[index].terms
                                          ?.description?[0] ??
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
  }
}
