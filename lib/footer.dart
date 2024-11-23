import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget{
  const Footer({super.key});

  @override
  Widget build(BuildContext context){
    return  Padding(
        padding: const EdgeInsets.all(11.0),
        child: Card(
          color: Colors.black,
          elevation: 405,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (kDebugMode) {
                    print('Home');
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (kDebugMode) {
                    print('Search');
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.blur_circular ,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (kDebugMode) {
                    print('Over all earth');
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (kDebugMode) {
                    print('Favorite Location');
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (kDebugMode) {
                    print('Profile');
                  }
                },
              ),
            ],
          ),
        ),
      );
  }
}