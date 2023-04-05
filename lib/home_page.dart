import 'package:flutter/material.dart';
import 'package:flutter_snakegame_firebase_hosting/blank_pixel.dart';
import 'package:flutter_snakegame_firebase_hosting/food_pos.dart';
import 'package:flutter_snakegame_firebase_hosting/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rowSize = 10;
  int totalNumberOfSquare = 100;

  List<int> snakePos = [
    0,
    1,
    2,
  ];

  int foodPos = 55;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalNumberOfSquare,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize),
              itemBuilder: (context, index) {
                if (snakePos.contains(index)) {
                  return const SnakePixel();
                } else if (foodPos == index) {
                  return const FoodPos();
                } else {
                  return const BlankPixel();
                }
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
