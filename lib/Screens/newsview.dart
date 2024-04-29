// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:newsapp/provider/provider.dart';

class News_view extends StatelessWidget {
  final Map mdata;
  bool isbookmarked;
  int index;
  News_view({
    Key? key,
    required this.mdata,
    required this.isbookmarked,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map m = mdata;
    return Scaffold(
        appBar: AppBar(
          actions: [
            isbookmarked
                ? InkWell(
                    onTap: () {
                      Provider.of<searchdata>(context, listen: false)
                          .setdata(mdata, context);
                    },
                    child: Icon(Icons.add))
                : InkWell(
                    onTap: () {
                      Provider.of<searchdata>(context, listen: false)
                          .removebook(index);
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.delete),
                  ),
            SizedBox(
              width: 10,
            )
          ],
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            m["source"]["name"] ?? "",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        m["title"],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    m["urlToImage"] == null
                        ? Image.asset("assets/lottie/6325254.jpg")
                        : Image.network(m["urlToImage"]),
                    Text(
                      "published at ${m["publishedAt"]}",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${m["description"]}${m["content"]}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "- ${m["author"]}",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                  onPressed: () async {
                    final Uri _url = Uri.parse(m["url"]);
                    print("url launche =:${await launchUrl(_url)}");
                  },
                  child: Text(
                    "view Source",
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                height: 35,
              )
            ],
          ),
        ));
  }
}
