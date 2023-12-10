import 'package:flutter/material.dart';

class SSList extends StatelessWidget {
  const SSList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            ElevatedButton(
                onPressed: () {},
                child: Scaffold(
                  body: Center(
                    child: Row(
                      children: [Text("PLANETS")],
                    ),
                  ),
                ))
          ],
        )
      ],
    );
  }
}
