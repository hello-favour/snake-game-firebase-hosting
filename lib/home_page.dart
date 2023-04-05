import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_snakegame_firebase_hosting/blank_pixel.dart';
import 'package:flutter_snakegame_firebase_hosting/food_pos.dart';
import 'package:flutter_snakegame_firebase_hosting/snake_pixel.dart';

enum snak_Direction {
  down,
  up,
  right,
  left,
}

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

  void startGame() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        // snakePos.add(snakePos.last + 1);
        // snakePos.removeAt(0);
        moveSnake();
      });
    });
  }

  void moveSnake() {
    switch (currentDirection) {
      case snak_Direction.right:
        {
          if (snakePos.last % rowSize == 9) {
            snakePos.add(snakePos.last + 1 - rowSize);
          } else {
            snakePos.add(snakePos.last + 1);
          }
          snakePos.removeAt(0);
        }
        break;
      case snak_Direction.left:
        {
          if (snakePos.last % rowSize == 0) {
            snakePos.add(snakePos.last - 1 + rowSize);
          } else {
            snakePos.add(snakePos.last - 1);
          }
          snakePos.removeAt(0);
        }
        break;
      case snak_Direction.up:
        {
          if (snakePos.last < rowSize) {
            snakePos.add(snakePos.last - rowSize + totalNumberOfSquare);
          } else {
            snakePos.add(snakePos.last - rowSize);
          }
          snakePos.removeAt(0);
        }
        break;
      case snak_Direction.down:
        {
          if (snakePos.last + rowSize > totalNumberOfSquare) {
            snakePos.add(snakePos.last + rowSize - totalNumberOfSquare);
          } else {
            snakePos.add(snakePos.last + rowSize);
          }
          snakePos.removeAt(0);
        }
        break;
      default:
    }
  }

  var currentDirection = snak_Direction.right;
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
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 &&
                    currentDirection != snak_Direction.up) {
                  currentDirection = snak_Direction.down;
                } else if (details.delta.dy < 0 &&
                    currentDirection != snak_Direction.down) {
                  currentDirection = snak_Direction.up;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 &&
                    currentDirection != snak_Direction.left) {
                  currentDirection = snak_Direction.right;
                } else if (details.delta.dx < 0 &&
                    currentDirection != snak_Direction.right) {
                  currentDirection = snak_Direction.left;
                }
              },
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
          ),
          Expanded(
            child: Container(
              child: Center(
                child: MaterialButton(
                  color: Colors.red,
                  child: Text("PLAY"),
                  onPressed: startGame,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
