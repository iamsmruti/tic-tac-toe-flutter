// ignore_for_file: unrelated_type_equality_checks

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_v2/widgets/game_tile.dart';
import 'package:tic_tac_toe_v2/widgets/snackbar.dart';

class PlayComputer extends StatefulWidget {
  const PlayComputer({super.key});

  @override
  State<PlayComputer> createState() => _PlayComputerState();
}

class _PlayComputerState extends State<PlayComputer> {
  var player1;
  var player2;
  var activePlayer = '1';

  List<GameTile> _gameTiles = [];

  @override
  void initState() {
    super.initState();
    _gameTiles = doInit();
  }

  List<GameTile> doInit() {
    player1 = List.empty(growable: true);
    player2 = List.empty(growable: true);

    List<GameTile> gameTiles = [
      GameTile(tileNo: 0),
      GameTile(tileNo: 1),
      GameTile(tileNo: 2),
      GameTile(tileNo: 3),
      GameTile(tileNo: 4),
      GameTile(tileNo: 5),
      GameTile(tileNo: 6),
      GameTile(tileNo: 7),
      GameTile(tileNo: 8),
    ];

    return gameTiles;
  }

  void playGame(GameTile gt) {
    setState(() {
      if (activePlayer == '1') {
        gt.value = 1;
        activePlayer = '2';
        player1.add(gt.tileNo);
      } else {
        gt.value = 2;
        activePlayer = '1';
        player2.add(gt.tileNo);
      }

      gt.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (_gameTiles.every((p) => p.value != 0)) {
          showSnackBar(
              context, "Game Draw, Press the reset button to start again.");
        } else {
          activePlayer == '2' ? autoPlay() : null;
        }
      }

      if (winner == 1) {
        showSnackBar(context, "Player 1 Won");
      } else if (winner == 2) {
        showSnackBar(context, "Computer Won");
      }
    });
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(0) && player1.contains(1) && player1.contains(2)) {
      winner = 1;
    }
    if (player2.contains(0) && player2.contains(1) && player2.contains(2)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(3) && player1.contains(4) && player1.contains(5)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(4) && player2.contains(5)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(6) && player1.contains(7) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(6) && player2.contains(7) && player2.contains(8)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(0) && player1.contains(3) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(0) && player2.contains(3) && player2.contains(6)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(0) && player1.contains(4) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(0) && player2.contains(4) && player2.contains(8)) {
      winner = 2;
    }

    if (player1.contains(2) && player1.contains(4) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(4) && player2.contains(6)) {
      winner = 2;
    }

    return winner;
  }

  void autoPlay() {
    var emptyCells = List.empty(growable: true);
    var list = List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = _gameTiles.indexWhere((p) => p.tileNo == cellID);
    playGame(_gameTiles[i]);
  }

  void resetGame() {
    setState(() {
      _gameTiles = doInit();
      player1 = List.empty(growable: true);
      player2 = List.empty(growable: true);

      activePlayer = '1';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Play with Computer"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Game with AI",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Turn of",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          (activePlayer == '1')
              ? Image.asset(
                  "assets/images/cross.png",
                  height: 50,
                  width: 50,
                )
              : Image.asset(
                  "assets/images/circle.png",
                  height: 50,
                  width: 50,
                ),
          const SizedBox(height: 24),
          Container(
            height: 50,
            color: Colors.pink[100],
            child: const Center(
              child: Text(
                "Game Board",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.pink[100],
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: _gameTiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _gameTiles[index].enabled && checkWinner() == -1
                        ? playGame(_gameTiles[index])
                        : null;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: _gameTiles[index].value == 1
                          ? Image.asset(
                              "assets/images/cross.png",
                              height: 50,
                              width: 50,
                            )
                          : _gameTiles[index].value == 2
                              ? Image.asset(
                                  "assets/images/circle.png",
                                  height: 50,
                                  width: 50,
                                )
                              : Container(),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Container(
              height: 50,
              color: Colors.pink[500],
              child: Center(
                child: TextButton(
                  onPressed: () {
                    resetGame();
                  },
                  child: const Text(
                    "Reset Game",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
