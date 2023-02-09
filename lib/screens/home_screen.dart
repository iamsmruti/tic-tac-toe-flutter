import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/providers/game_provider.dart';
import 'package:tic_tac_toe_v2/screens/new_game_screen.dart';
import 'package:tic_tac_toe_v2/widgets/game_card.dart';
import 'package:tic_tac_toe_v2/widgets/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final gp = Provider.of<GameProvider>(context, listen: false);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("games").orderBy("updatedAt", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Games"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewGameScreen()));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if ((snapshot.data!.docs[index].data()["name"] as List)
                      .contains(gp.uid)) {
                    return GameCard(
                      game: snapshot.data!.docs[index],
                      gameId: snapshot.data!.docs[index].id,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            drawer: const Drawer(
              child: SideDrawer(),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
