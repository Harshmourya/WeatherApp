import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const Cards({super.key , required this.time , required this.icon , required this.temp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        surfaceTintColor: const Color.fromARGB(255, 3, 255, 255),
        elevation: 3,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 28),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Icon(icon , color: const Color.fromARGB(255, 255, 220, 91), size: 45,),
            Text(temp , style: const TextStyle(fontSize: 24),),
          ],
        ),
      ),
    );
  }
}
