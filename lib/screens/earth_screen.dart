import 'package:flutter/material.dart';
import 'package:mobile_project/models/epic.dart';

class EarthViewScreen extends StatelessWidget {
  const EarthViewScreen({super.key});

  //final String date = "2024-01-13";
  final String date = "2015-06-13";
  final int currentImg = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadEPICData(date),
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
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                    child: Image(
                      image: NetworkImage(epic[currentImg].image),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text(epic[currentImg].caption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12)),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Date: "),
                    Text(epic[currentImg].date.substring(0, 10)),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Time: "),
                    Text(epic[currentImg].date.substring(11)),
                  ],
                ),
                const SizedBox(height: 7),
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 161, 175, 188),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Latitude: ", style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                            Text(epic[currentImg].lat.toString(), style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Longitude: ", style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                            Text(epic[currentImg].lon.toString(), style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                          ],
                        ),
                        Row(
                          children: [
                            Text("DSCOVR position:      ", style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                            Column(
                              children: [
                                Text(epic[currentImg].dscovrX.toString(), style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].dscovrY.toString(), style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                                Text(epic[currentImg].dscovrZ.toString(), style: TextStyle(color: Color.fromARGB(255, 30, 20, 44))),
                              ],
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
