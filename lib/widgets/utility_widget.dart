import 'package:flutter/material.dart';

// Pageview Index UI ----------------------------
class IndicatorsTrueWidget extends StatelessWidget {
  const IndicatorsTrueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 400),
      height: 4,
      width: 24,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
    );
  }
}

class IndicatorsFalseWidget extends StatelessWidget {
  const IndicatorsFalseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 400),
      height: 6,
      width: 6,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade600,
      ),
    );
  }
}

// Image with transparecy gradient
class ImageGradientFade extends StatelessWidget {
  const ImageGradientFade({
    super.key,
    required this.imagePath,
    required this.gradientStops,
  });

  final String imagePath;
  final List<double> gradientStops;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: gradientStops,
          colors: const [
            Colors.transparent,
            Colors.black,
            Colors.black,
            Colors.transparent
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(imagePath),
    );
  }
}

// Image button with label
Widget buildImageButton(
  String label,
  Alignment labelAlignment,
  String imagePath,
  BuildContext context,
  String routeName,
) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Material(
          color: const Color.fromARGB(0, 0, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, routeName);
            },
            splashColor: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            child: Align(
              alignment: labelAlignment,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildExpandedButton(String label, Alignment labelAlignment,
    String imagePath, BuildContext context, String routeName) {
  return Expanded(
    child:
        buildImageButton(label, labelAlignment, imagePath, context, routeName),
  );
}

Widget buildExpandedRow(List<Widget> widgets) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    ),
  );
}

// Function to create RichText with bold and regular parts
Widget buildRichText(String boldText, String regularText) {
  TextStyle text = const TextStyle(color: Colors.black);
  return RichText(
    text: TextSpan(
      style: text,
      children: [
        TextSpan(
          text: boldText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: ' $regularText',
        ),
      ],
    ),
  );
}

//Custom divider
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.height, required this.color});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color,
    );
  }
}