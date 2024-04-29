import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newsapp/Screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data extends ChangeNotifier {
  final BuildContext context;

  bool isloading = true;

  List article = [];

  Data(this.context) {
    get();
  }
  get() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=0eac3fb62ca34249bc4e806025bee713"));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      if (res["status"] == "ok") {
        article = res['articles'];

        isloading = false;
        notifyListeners();
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error occured")));
    }
  }
}

class searchdata extends ChangeNotifier {
  final BuildContext context;
  searchdata(this.context) {
    getdata();
  }
  List bookmarkdata = [];
  bool isupdated = true;
  List Search_article = [];

  searchapi(String content) async {
    print("entered");
    Search_article = [];
    isupdated = true;
    notifyListeners();
    try {
      var response = await http.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=${content.toString().toLowerCase()}&sortBy=popularity&apiKey=0eac3fb62ca34249bc4e806025bee713"));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if (res["status"] == "ok") {
          Search_article = res['articles'];
          print(Search_article);
          isupdated = false;
          notifyListeners();
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("error occured")));
      }
      notifyListeners();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  setdata(Map mdata, BuildContext context) async {
    print("seting data");
    SharedPreferences s = await SharedPreferences.getInstance();
    List l1 = jsonDecode(s.getString("list") ?? "[]");
    l1.add(mdata);
    await s.setString("list", jsonEncode(l1));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("bookmarked")));
    print(s.getString("list"));
    getdata();
  }

  getdata() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    bookmarkdata = jsonDecode(s.getString("list") ?? "[]");
    notifyListeners();
  }

  removedata() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString("list", '[]');
    bookmarkdata = [];
    notifyListeners();
  }

  removebook(int index) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    List data = jsonDecode(s.getString("list") ?? "[]");
    print(data);
    print(index);
    data.removeAt(index);
    await s.setString("list", jsonEncode(data));
    getdata();
  }

  flushapi() {
    Search_article = [];
    notifyListeners();
  }
}
