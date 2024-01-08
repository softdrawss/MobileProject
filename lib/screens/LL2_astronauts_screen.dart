import 'package:flutter/material.dart';
import 'package:mobile_project/models/LL2_astronauts.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import '../widgets/utility_widget.dart';
import '../widgets/astronaut_details_widget.dart';


const statusFilter = ["Active", "Retired", "Training", "Lost in Service", "Deceased"];
const nationalityFilter = ["All", "American", "Russian", "European", "Other"];

int count = 0;
String initUrl = "https://lldev.thespacedevs.com/2.2.0/astronaut/?limit=30";
String next = initUrl;
List<Astronaut> astronauts = [];


class AstronautListScreen extends StatefulWidget {
  const AstronautListScreen({super.key});

  @override
  _AstronautListScreenState createState() => _AstronautListScreenState();
}

class _AstronautListScreenState extends State<AstronautListScreen> {
  int filterStatusIndex = 0;
  int filterNationalityIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool filter = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Astronauts'),
      ),
      body: Column(
        children: [
          FlutterToggleTab(
            selectedIndex: filterStatusIndex,
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w400,
            ),
            labels: const ["Active", "Retired", "Training", "Lost in\nService", "Deceased"],
            selectedLabelIndex: (index) {
              setState(() {
                filterStatusIndex = index;
                filter = true;
              });
            },          
            borderRadius: 6,
            selectedBackgroundColors: const [Color.fromARGB(255, 5, 26, 45)],
            unSelectedBackgroundColors: const [Color.fromARGB(255, 4, 11, 25)],
          ),
          FlutterToggleTab(
            selectedIndex: filterNationalityIndex,
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w400,
            ),
            labels: const ["All", "American", "Russian", "European", "Other"],
            selectedLabelIndex: (index) {
              setState(() {
                filterNationalityIndex = index;
                filter = true;
              });
            },
            borderRadius: 6,
            selectedBackgroundColors: const [Color.fromARGB(255, 5, 26, 45)],
            unSelectedBackgroundColors: const [Color.fromARGB(255, 4, 11, 25)],
          ),
          const SizedBox(height: 12),
          const CustomDivider(height: 1, color: Color.fromARGB(128, 161, 175, 188), horizontalPadding: 16),
          const SizedBox(height: 12),
          Expanded(
            child: _buildAstronautList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAstronautList() {
    if (filter) {
      // Apply filters and return the filtered list
      final filteredAstronauts = astronauts.where((astronaut) {
        final statusMatches = filterStatusIndex == 0 || astronaut.status.name == statusFilter[filterStatusIndex];
        final nationalityMatches =
            filterNationalityIndex == 0 || astronaut.nationality == nationalityFilter[filterNationalityIndex];
        return statusMatches && nationalityMatches;
      }).toList();

      return ListView.builder(
        itemCount: filteredAstronauts.length,
        itemBuilder: (context, index) {
          final astronaut = filteredAstronauts[index];
          return ListTile(
            title: Text(astronaut.name),
            subtitle: Text('Nationality: ${astronaut.nationality}'),
            onTap: () {
              astronautPopUp(astronaut, context);
            },
          );
        },
      );
    } else {
      // Use FutureBuilder to load the next page
      return FutureBuilder<AstronautResponse>(
        future: isLoading ? null : _loadNextPage(next),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text('Error loading astronauts');
          } else if (!snapshot.hasData || snapshot.data?.results == null) {
            return const Text('No astronauts available');
          }

          // Append data to the existing list
          next = snapshot.data!.next;
          astronauts.addAll(snapshot.data!.results);
          count = astronauts.length;
          isLoading = false;

          return ListView.builder(
            controller: _scrollController,
            itemCount: astronauts.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < astronauts.length) {
                final astronaut = astronauts[index];
                return ListTile(
                  title: Text(astronaut.name),
                  subtitle: Text('Nationality: ${astronaut.nationality}'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.blueGrey
                  ),
                  onTap: () {
                    astronautPopUp(astronaut, context);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      );
    }
  }

  // Load next page when reaching the end of the scroll
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<AstronautResponse> _loadNextPage(String next) async {
    return await loadAstronauts(next);
  }
}

void astronautPopUp(Astronaut astronaut, context) {
  final astronautDetailsPopup = AstronautDetailsPopup(info: astronaut);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 0.0,
                right: 0.0,
                top: 16.0,
              ),
              child: astronautDetailsPopup,
            ),
          ),
        ],
      );
    },
  );
}