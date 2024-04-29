import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/Screens/newsview.dart';
import 'package:newsapp/provider/provider.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  String value;
  Search({this.value = "", super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.value != "") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<searchdata>(context, listen: false).searchapi(widget.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController search_result = TextEditingController();
    search_result.text = widget.value;
    final data = context.watch<searchdata>();
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  data.searchapi(search_result.text);
                },
                child: Icon(Icons.send)),
            SizedBox(
              width: 10,
            )
          ],
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextFormField(
                  controller: search_result,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search for Articles",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                )),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: data.isupdated
              ? Center(
                  child: search_result.text.isEmpty
                      ? Text("")
                      : Lottie.asset("assets/lottie/loading.json"),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return data.Search_article[index]["title"] == "[Removed]"
                        ? SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => News_view(
                                    index: index,
                                    mdata: data.Search_article[index],
                                    isbookmarked: true),
                              ));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 10,
                              child: ListTile(
                                title: Text(
                                  data.Search_article[index]["title"] ?? "",
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
                                    Text(data.Search_article[index]
                                            ["description"] ??
                                        "unknown"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "- ${data.Search_article[index]["author"] ?? ""}",
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
                  itemCount: data.Search_article.length),
        ));
  }
}
