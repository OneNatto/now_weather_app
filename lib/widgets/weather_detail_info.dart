import 'package:flutter/material.dart';

class WeatherDetailInfo extends StatelessWidget {
  final String image;
  final String title;
  final String content;

  const WeatherDetailInfo({
    Key? key,
    required this.image,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          scale: 10,
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
