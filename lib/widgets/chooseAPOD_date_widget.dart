import 'package:flutter/material.dart';

class ChooseDateWidget extends StatefulWidget {
  const ChooseDateWidget({
    super.key,
    required this.dateTime,
    required this.beginDate,
    required this.onDateChanged,
  });

  final DateTime dateTime;
  final DateTime beginDate;
  final Function(DateTime) onDateChanged;

  @override
  State<ChooseDateWidget> createState() => _ChooseDateWidgetState();
}

class _ChooseDateWidgetState extends State<ChooseDateWidget> {
  late DateTime selectedDateTime = widget.dateTime;

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
            initialDate: selectedDateTime,
            currentDate: selectedDateTime,
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
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 161, 175, 188), width: .50),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedDateTime.toString().split(" ")[0],
              style: const TextStyle(color: Color.fromARGB(255, 161, 175, 188)),
            ),
          ],
        ),
      ),
    );
  }
}
