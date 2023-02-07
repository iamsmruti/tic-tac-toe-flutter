import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_v2/utils/game_logic.dart';
import 'package:tic_tac_toe_v2/widgets/game_tile.dart';
import 'package:tic_tac_toe_v2/widgets/snackbar.dart';

class PlayScreen extends StatefulWidget {
  final DocumentSnapshot game;
  String? rival;

  PlayScreen({super.key, required this.game, this.rival});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
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
      int winner = checkWinner(player1, player2);
      if (winner == -1) {
        if (_gameTiles.every((element) => element.value != 0)) {
          showSnackBar(context, "Game Drawn");
        }
      } else if (winner == 1) {
        showSnackBar(context, "Player 1 Won");
      } else if (winner == 2) {
        showSnackBar(context, "Player 2 Won");
      }
    });
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
        title: const Text("Play locally!"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Local Game",
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
                    _gameTiles[index].enabled &&
                            checkWinner(player1, player2) == -1
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
