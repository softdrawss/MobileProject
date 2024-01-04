import 'package:flutter/material.dart';

class ChooseDateWidget extends StatefulWidget {
  const ChooseDateWidget({
    super.key,
    required this.dateTime,
    required this.onDateChanged,
  });

  final DateTime dateTime;
  final Function(DateTime) onDateChanged;

  @override
  State<ChooseDateWidget> createState() => _ChooseDateWidgetState();
}

class _ChooseDateWidgetState extends State<ChooseDateWidget> {
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.dateTime;
  }

  void selectDate() {
    showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Color.fromARGB(
                        255, 80, 54, 116), // header background color
                    onPrimary: Colors.white, // header text color
                    onSurface:
                        Color.fromARGB(255, 161, 175, 188), // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1995, 6, 20),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        widget.onDateChanged(value);
        setState(() {
          selectedDateTime = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectDate();
      },
      child: Text(
        selectedDateTime.toString().split(" ")[0],
        style: const TextStyle(color: Color.fromARGB(255, 161, 175, 188)),
      ),
    );
  }
}
