import 'package:flutter/material.dart';
import 'package:mobile_project/models/apod.dart';

class APODScreen extends StatelessWidget {
  const APODScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadAPOD(), 
        builder: (context, snapshot){
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final picture = snapshot.data!;
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
                Text(picture.title),
                Image(image: NetworkImage(picture.url)),
                Text(picture.explanation),
              ],
            ),
          );
        },
      ),
    );
  }
}