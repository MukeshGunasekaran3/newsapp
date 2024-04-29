import 'package:flutter/material.dart';
import 'package:newsapp/Screens/newsview.dart';
import 'package:newsapp/provider/provider.dart';
import 'package:provider/provider.dart';

class Bookmarks extends StatelessWidget {
  Bookmarks({super.key});

  List? data;

  @override
  Widget build(BuildContext context) {
    searchdata d = searchdata(context);
    final data = context.watch<searchdata>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Provider.of<searchdata>(context, listen: false).removedata();
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
          "Bookmarks",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<searchdata>(builder: (context, data2, child) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: data.bookmarkdata.isEmpty
              ? Center(
                  child: Text("No Bookmarks Found"),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return data.bookmarkdata[index]["title"] == "[Removed]"
                        ? SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => News_view(
                                    index: index,
                                    mdata: data.bookmarkdata[index],
                                    isbookmarked: false),
                              ));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 10,
                              child: ListTile(
                                title: Text(
                                  data.bookmarkdata[index]["title"] ?? "",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(data.bookmarkdata[index]
                                            ["description"] ??
                                        "unknown"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "- ${data.bookmarkdata[index]["author"] ?? ""}",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: data.bookmarkdata.length),
        );
      }),
    );
  }
}
