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

class PaginatedBodyList extends StatefulWidget {
  final String url;

  const PaginatedBodyList({super.key, required this.url});

  @override
  PaginatedBodyListState createState() => PaginatedBodyListState();
}

class PaginatedBodyListState extends State<PaginatedBodyList> {
  final PageController _pageController = PageController();

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

                  return PageView.builder(
                    controller: _pageController,
                    itemCount: (bodyList.length / 10).ceil(),
                    itemBuilder: (context, pageIndex) {
                      int startIndex = pageIndex * 10;
                      int endIndex = (pageIndex + 1) * 10;
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
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (_pageController.page!.toInt() != 0) {
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_pageController.page!.toInt() !=
                      (_pageController.page!.toInt() - 1)) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}