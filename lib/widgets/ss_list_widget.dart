import 'package:flutter/material.dart';
import 'package:mobile_project/screens/ss_body_screen.dart';
import 'package:mobile_project/models/ss_list.dart';

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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: const Color.fromARGB(255, 219, 230, 240), width: 2),
        image: DecorationImage(
            image: AssetImage(imagePath), fit: BoxFit.contain, opacity: 0.8),
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
            alignment: Alignment.center,
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

  @override

  // To calculate maxPages
  void initState() {
    super.initState();
    // Load the list and set the initial values of currentPage and maxPages
    loadList(widget.url).then((List<ListedBody> bodyList) {
      maxPages = (bodyList.length / 10).ceil();
      setState(() {});
    });
  }

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
