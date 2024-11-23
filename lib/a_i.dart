import 'package:flutter/material.dart';

class Ai extends StatelessWidget {
  final IconData icon;
  final String info;
  final String value;
  const Ai({super.key , required this.icon , required this.info, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(
          icon,
          size: 33,
        ),
        Text(
          info,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
