import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'About: This app showcases car listings fetched from a REST API with a carousel and details.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


