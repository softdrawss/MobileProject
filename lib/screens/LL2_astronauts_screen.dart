import 'package:flutter/material.dart';
import 'package:mobile_project/models/LL2_astronauts.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';


const statusFilter = ["Active", "Retired", "Training", "Lost in Service", "Deceased"];
const nationalityFilter = ["All", "American", "Russian", "European", "Other"];

class AstronautListScreen extends StatefulWidget {
  const AstronautListScreen({super.key});

  @override
  _AstronautListScreenState createState() => _AstronautListScreenState();
}

class _AstronautListScreenState extends State<AstronautListScreen> {
  int filterStatusIndex = 0;
  int filterNationalityIndex = 0;
  
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
              future: loadAstronauts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading astronauts');
                } else if (!snapshot.hasData || snapshot.data?.results == null) {
                  return const Text('No astronauts available');
                }

                final astronauts = snapshot.data!.results;

                // Apply filters based on the selected indices
                final filteredAstronauts = astronauts.where((astronaut) {
                  final statusMatches = filterStatusIndex == 0 || astronaut.status.name == statusFilter[filterStatusIndex];
                  final nationalityMatches = filterNationalityIndex == 0 || astronaut.nationality == nationalityFilter[filterNationalityIndex];
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
                        // Handle astronaut tap
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}