import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class TextRow extends StatelessWidget {
  final String title;
  final String data;
  const TextRow({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
              color: white,
              fontFamily: font,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(width: 10),
        Expanded(
            child: Text(data,
                style: const TextStyle(
                  color: white,
                  fontFamily: font,
                  fontSize: 14,
                ),
                overflow: TextOverflow.clip)),
      ]),
    );
  }
}
