import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/widgets/snackbar.dart';

import '../providers/game_provider.dart';

class PlayScreen extends StatefulWidget {
  final String gameId;
  final String? rival;

  PlayScreen({super.key, this.rival, required this.gameId});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  GameProvider? gp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        gp = Provider.of<GameProvider>(context, listen: false);
        
      },
    );
  }

  void playGameOnline(int index, Map<String, dynamic> game) {
    if (game["turn"] == gp?.uid &&
        game["board"][index] == "" &&
        game["isFinished"] == false) {
      (game["board"] as List)[index] = gp?.uid;
      FirebaseFirestore.instance.collection("games").doc(widget.gameId).update({
        "board": game["board"],
        "turn":
            game["turn"] == game["player1"] ? game["player2"] : game["player1"],
        "winner": checkOnlineWinner(game["board"]),
        "isFinished": checkOnlineWinner(game["board"]) != "" ? true : false,
      });
    } else {
      if (game["isFinished"] == true) {
        showSnackBar(context, "Game is finished, play again");
      }

      showSnackBar(context, "Not your turn");
    }

    if (checkOnlineWinner(game["board"]) != "") {
      showSnackBar(context, "Winner is ${checkOnlineWinner(game["board"])}");
    }
  }

  checkOnlineWinner(List game) {
    const winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (int i = 0; i < winningCombos.length; i++) {
      int a = winningCombos[i][0];
      int b = winningCombos[i][1];
      int c = winningCombos[i][2];
      if (game[a] != "" && game[a] == game[b] && game[a] == game[c]) {
        return game[a];
      }
    }
    return "";
  }

  void resetGame(rival) {
    gp?.newGame(context, rival);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Happy Playing!"),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("games")
              .doc(widget.gameId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Game with ${widget.rival}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Your Piece",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        "assets/images/cross.png",
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        height: 50,
                        color: Colors.pink[100],
                        child: Center(
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
                          itemCount: 9,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 9,
                            mainAxisSpacing: 9,
                          ),
                          itemBuilder: (context, index) {
                            print(snapshot.data?.data()!["board"][0]);
                            print(gp?.uid);
                            return GestureDetector(
                              onTap: () {
                                playGameOnline(
                                    index % 9, snapshot.data!.data()!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: snapshot.data?.data()!["board"]
                                              [index] ==
                                          gp?.uid
                                      ? Image.asset(
                                          "assets/images/cross.png",
                                          height: 50,
                                          width: 50,
                                        )
                                      : snapshot.data?.data()!["board"]
                                                  [index] ==
                                              ""
                                          ? null
                                          : Image.asset(
                                              "assets/images/circle.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                          height: 50,
                          color: snapshot.data?.data()!["isFinished"] != true
                              ? Colors.black45
                              : Colors.pink[500],
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                if (snapshot.data?.data()!["isFinished"] ==
                                    true) {
                                  resetGame(snapshot.data?.data()!["player1"] ==
                                          gp?.uid
                                      ? snapshot.data?.data()!["player2"]
                                      : snapshot.data?.data()!["player1"]);
                                } else {
                                  showSnackBar(
                                      context, "Game is not finished yet");
                                }
                              },
                              child: Text(
                                snapshot.data?.data()!["isFinished"] == true
                                    ? "Reset Game"
                                    : "Match is still on",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ))
                    ]),
              );
            } else {
              return CircularProgressIndicator(
                color: Colors.pinkAccent,
              );
            }
          }),
    );
  }
}
