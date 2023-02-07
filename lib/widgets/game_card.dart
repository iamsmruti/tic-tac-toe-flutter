import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/providers/game_provider.dart';
import 'package:tic_tac_toe_v2/screens/play_screen.dart';

class GameCard extends StatefulWidget {
  final DocumentSnapshot game;

  const GameCard({super.key, required this.game});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  String _username = '';

  @override
  Widget build(BuildContext context) {
    final gp = Provider.of<GameProvider>(context, listen: false);

    gp
        .getUsername(widget.game['player1'], widget.game['player2'])
        .then((value) {
      setState(() {
        _username = value;
      });
    });

    return Column(
      children: [
        Card(
          elevation: 2,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
            child: ListTile(
              leading: Image.asset('assets/images/logo.png'),
              title: Text("Game with ${_username}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Turn: ${widget.game['turn']}"),
                    const SizedBox(height: 3.0),
                    Text(
                      "Game Status: ${widget.game['winner'] == "" ? 'In Progress' : 'Completed'}",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Column(
                children: [
                  const SizedBox(height: 0.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayScreen(game: widget.game, rival: _username),
                        ),
                      );
                    },
                    child: const Text("Play"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
