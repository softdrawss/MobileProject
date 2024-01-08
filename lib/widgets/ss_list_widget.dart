import 'package:flutter/material.dart';
import 'package:mobile_project/screens/ss_body_screen.dart';
import 'package:mobile_project/models/ss_list.dart';
import 'package:mobile_project/widgets/utility_widget.dart';

void navigateToBodyDetails(BuildContext context, String planetName) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SSBodyScreen(id: planetName),
    ),
  );
}

Widget buildBodyButton(
    String label, String imagePath, BuildContext context, String id) {
  return GestureDetector(
    onTap: () {
      navigateToBodyDetails(context, id);
    },
    child: Container(
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height / 5 - 10,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imagePath), fit: BoxFit.contain, opacity: 0.8),
        color: const Color.fromARGB(0, 0, 0, 0),
      ),
      child: Material(
        color: const Color.fromARGB(0, 0, 0, 0),
        child: InkWell(
          onTap: () {
            navigateToBodyDetails(context, id);
          },
          splashColor: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(
                  color: Color.fromARGB(255, 219, 230, 240),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none, // Remove text decoration
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class BodyList extends StatefulWidget {
  final String url;
  const BodyList({super.key, required this.url});

  @override
  BodyListState createState() => BodyListState();
}

class BodyListState extends State<BodyList> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  int maxPages = 0;

  static const CustomDivider divider =
      CustomDivider(height: 1, color: Color.fromARGB(64, 161, 175, 188), horizontalPadding: 32);

  // To calculate maxPages
  @override
  void initState() {
    super.initState();
    // Load the list and set the initial values of currentPage and maxPages
    loadList(widget.url).then((List<ListedBody> bodyList) {
      maxPages = (bodyList.length / 10).ceil();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: loadList(widget.url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    (snapshot.data as List).isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  List<ListedBody> bodyList = snapshot.data as List<ListedBody>;
                  maxPages = (bodyList.length / 10).ceil();

                  return PageView.builder(
                    controller: _pageController,
                    itemCount: maxPages,
                    onPageChanged: (int index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, pageIndex) {
                      int startIndex = currentPage * 10;
                      int endIndex = (currentPage + 1) * 10;
                      endIndex = endIndex > bodyList.length
                          ? bodyList.length
                          : endIndex;

                      List<ListedBody> pageItems =
                          bodyList.sublist(startIndex, endIndex);

                      return ListView.builder(
                        itemCount: pageItems.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const SizedBox(width: 46),
                                title: Center(
                                  child: Text(
                                    pageItems[index].name,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(right: 32),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.blueGrey,
                                ),
                                onTap: () {
                                  navigateToBodyDetails(context, pageItems[index].id);
                                },
                              ),
                              const SizedBox(height: 4),
                              divider,
                              const SizedBox(height: 4),
                            ],
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                  color: Colors.blueGrey,
                ),
                onPressed: currentPage > 0
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
                color: currentPage == 0 ? Colors.grey.withOpacity(0.5) : null,
              ),
              // Display row of numbers between the arrows
              Text("${currentPage + 1}"),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.blueGrey,
                  ),
                onPressed: currentPage + 1 < maxPages
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
                color: currentPage + 1 >= maxPages
                    ? Colors.grey.withOpacity(0.5)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyListImage extends StatelessWidget {
  final String url;
  final String folder;
  const BodyListImage({super.key, required this.url, required this.folder});

  static const CustomDivider divider =
      CustomDivider(height: 1, color: Color.fromARGB(128, 161, 175, 188));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: loadList(url),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                List<ListedBody> bodyList = snapshot.data as List<ListedBody>;
                return ListView.builder(
                  itemCount: bodyList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        buildBodyButton(
                            bodyList[index].name.toUpperCase(),
                            "lib/assets/images/ss_list_screen/$folder/${bodyList[index].name.toLowerCase()}.jpg",
                            context,
                            bodyList[index].id),
                        divider,
                        const SizedBox(height: 6)
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class BodyMoonList extends StatefulWidget {
  final String planetID;
  final String planetName;
  const BodyMoonList(
      {super.key, required this.planetID, required this.planetName});

  @override
  BodyMoonListState createState() => BodyMoonListState();
}

class BodyMoonListState extends State<BodyMoonList> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  int maxPages = 0;

  @override

  // To calculate maxPages
  void initState() {
    super.initState();
    // Load the list and set the initial values of currentPage and maxPages
    loadMoonList(widget.planetID).then((List<ListedBody> bodyList) {
      maxPages = (bodyList.length / 10).ceil();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Text(
            "Moons from ${widget.planetName}",
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 219, 230, 240)),
          ),
          Expanded(
            child: FutureBuilder(
              future: loadMoonList(widget.planetID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    (snapshot.data as List).isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  List<ListedBody> bodyList = snapshot.data as List<ListedBody>;
                  maxPages = (bodyList.length / 10).ceil();

                  return PageView.builder(
                    controller: _pageController,
                    itemCount: maxPages,
                    onPageChanged: (int index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, pageIndex) {
                      int startIndex = currentPage * 10;
                      int endIndex = (currentPage + 1) * 10;
                      endIndex = endIndex > bodyList.length
                          ? bodyList.length
                          : endIndex;

                      List<ListedBody> pageItems =
                          bodyList.sublist(startIndex, endIndex);

                      return ListView.builder(
                        itemCount: pageItems.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  navigateToBodyDetails(
                                      context, pageItems[index].id);
                                },
                                child: Text(pageItems[index].name),
                              ),
                              const SizedBox(height: 6)
                            ],
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: currentPage > 0
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
                color: currentPage == 0 ? Colors.grey.withOpacity(0.5) : null,
              ),
              // Display row of numbers between the arrows
              Text("${currentPage + 1}"),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: currentPage + 1 < maxPages
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
                color: currentPage + 1 >= maxPages
                    ? Colors.grey.withOpacity(0.5)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
