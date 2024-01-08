import 'package:flutter/material.dart';
import 'package:mobile_project/models/LL2_astronauts.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';


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
  bool _isLoading = false;

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
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            labels: const ["Active", "Retired", "Training", "Lost in Service", "Deceased"],
            selectedLabelIndex: (index) {
              setState(() {
                filterStatusIndex = index;
              });
            },
          ),
          FlutterToggleTab(
            selectedIndex: filterNationalityIndex,
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            labels: const ["All", "American", "Russian", "European", "Other"],
            selectedLabelIndex: (index) {
              setState(() {
                filterNationalityIndex = index;
              });
            },
          ),
          Expanded(
            child: FutureBuilder<AstronautResponse>(
              future: _isLoading ? null : _loadNextPage(next),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !_isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } 
                else if (snapshot.hasError) {
                  return const Text('Error loading astronauts');
                } 
                else if (!snapshot.hasData || snapshot.data?.results == null) {
                  return const Text('No astronauts available');
                }
                else{
                  // Append data to the existing list
                  next = snapshot.data!.next;
                  astronauts.addAll(snapshot.data!.results);
                  count = astronauts.length;
                  _isLoading = false;
                }

                // Apply filters based on the selected indices
                final filteredAstronauts = astronauts.where((astronaut) {
                  final statusMatches = filterStatusIndex == 0 || astronaut.status.name == statusFilter[filterStatusIndex];
                  final nationalityMatches = filterNationalityIndex == 0 || astronaut.nationality == nationalityFilter[filterNationalityIndex];
                  return statusMatches && nationalityMatches;
                }).toList();

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredAstronauts.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < filteredAstronauts.length) {
                      final astronaut = filteredAstronauts[index];
                      return ListTile(
                        title: Text(astronaut.name),
                        subtitle: Text('Nationality: ${astronaut.nationality}'),
                        onTap: () {
                          // Handle astronaut tap
                        },
                      );
                    } 
                    else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Load next page when reaching the end of the scroll
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      setState(() {_isLoading = true;});
    }
  }

  Future<AstronautResponse> _loadNextPage(String next) async {
    return await loadAstronauts(next);
  }
}