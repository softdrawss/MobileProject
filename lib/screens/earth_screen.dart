import 'package:flutter/material.dart';
import 'package:mobile_project/models/epic.dart';

class EarthViewScreen extends StatelessWidget {
  const EarthViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadEPICData("2015-10-31"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final epic = snapshot.data!;
          
          return Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                ),
                Text(epic[0].date),
                Image(image: NetworkImage(epic[0].image),),
                Text(epic[0].imageCode),
                Text(epic[0].caption),
                Text(epic[0].lat.toString()),
                Text(epic[0].lon.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
