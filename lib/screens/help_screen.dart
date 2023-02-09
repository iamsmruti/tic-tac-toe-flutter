import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "How to play?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text("This game provides various modes to play with.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text("1. Play Online with friends.",
                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
              SizedBox(height: 8),
              Text("2. Play Locally with friends.",
                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
              SizedBox(height: 8),
              Text("3. Play with Computer",
                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
              SizedBox(height: 24),
              Text("Rules for the Game:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                  "The game is played on a grid that's 3 squares by 3 squares.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 14),
              Text(
                  "You are X, your friend (or the computer in this case) is O. Players take turns putting their marks in empty squares.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 14),
              Text(
                  "The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 14),
              Text(
                  "When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
            ]),
      ),
    );
  }
}
