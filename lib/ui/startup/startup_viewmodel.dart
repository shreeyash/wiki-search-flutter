import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:wiki_search/app/app.locator.dart';
import 'package:wiki_search/app/util.dart';
import 'package:wiki_search/model/wikiquery_model.dart';

class StartUpViewModel extends BaseViewModel {
  final searchController = TextEditingController();
  final navigation = locator<NavigationService>();

  List<Pages> wikiDataList = [];
  String searchKey = "Sachin+T";
  bool connected = false;
  String getWikiIdUrl(int id) => "https://en.wikipedia.org/?curid=$id";

  void initialise() => buildWikiDataList();

  void buildWikiDataList() async {
    try {
      final queryModel = await getData();
      wikiDataList.clear();
      queryModel.query?.pages?.forEach((element) {
        wikiDataList.add(element);
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void updateSearchKey() {
    String query = searchController.text;
    searchKey = query.replaceAll(" ", "+");
    print(searchKey);
  }

  Uri getUrl(String searchText) {
    final url = Uri.parse(
        'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=${searchText}&gpslimit=20');
    return url;
  }

  Future<WikiQueryModel> getData() async {
    setBusy(true);
    try {
      final url = getUrl(searchKey);
      print(url.query);
      final response = await http.get(url);
      final responseJson = jsonDecode(response.body);
      WikiQueryModel _wikiQueryModel = WikiQueryModel.fromJson(responseJson);
      setBusy(false);
      return _wikiQueryModel;
    } catch (e) {
      setBusy(false);
      throw e;
    }
  }

  void launchURL(int id) async {
    String _url = getWikiIdUrl(id);
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}
