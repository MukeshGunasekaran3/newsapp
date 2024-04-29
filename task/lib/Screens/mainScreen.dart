import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/Screens/bookmarks.dart';
import 'package:newsapp/Screens/newsview.dart';
import 'package:newsapp/Screens/search.dart';
import 'package:newsapp/provider/provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List content = [
    {"name": "Business", "icon": Icons.business_outlined},
    {"name": "Technology", "icon": Icons.computer_sharp},
    {"name": "General", "icon": Icons.directions_bus_filled_outlined},
    {"name": "Entertainment", "icon": Icons.movie_creation_outlined},
    {"name": "Sports", "icon": Icons.sports_cricket},
  ];

  @override
  Widget build(BuildContext context) {
    Data data = Data(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Bookmarks(),
            ));
          },
          child: const Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "News Daily",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/lottie/person.png"),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.teal,
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<searchdata>(context, listen: false)
                          .flushapi();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Search(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: double.infinity,
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Icon(Icons.search),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Search For Articles...."),
                          Expanded(child: Text('')),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: double.infinity,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Search(
                                value: content[index]["name"],
                              ),
                            ));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(content[index]["icon"]),
                                const Expanded(child: Text('')),
                                Text(content[index]["name"]),
                                const Expanded(child: Text('')),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: content.length,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Top Trending",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Consumer<Data>(
                  builder: (context, data, child) {
                    return data.isloading
                        ? Center(
                            child: Lottie.asset("assets/lottie/loading.json"),
                          )
                        : data.article.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => News_view(
                                              index: index,
                                              mdata: data.article[index],
                                              isbookmarked: true),
                                        ));
                                      },
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        elevation: 10,
                                        child: ListTile(
                                          title: Text(
                                            data.article[index]["title"] ?? "",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                data.article[index]
                                                        ["description"] ??
                                                    "unknown",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "- ${data.article[index]["author"] ?? ""}",
                                                    style: const TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 20,
                                    ),
                                itemCount: data.article.length)
                            : const Center(
                                child: Text("No data Found!"),
                              );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
