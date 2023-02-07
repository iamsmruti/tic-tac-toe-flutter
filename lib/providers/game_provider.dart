import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe_v2/models/user_model.dart';
import 'package:tic_tac_toe_v2/screens/home_screen.dart';
import 'package:tic_tac_toe_v2/widgets/snackbar.dart';

class GameProvider extends ChangeNotifier {
  String _uid = "";
  String get uid => _uid;

  UserModel? _user;
  UserModel get user => _user!;

  GameProvider() {
    getUser();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getUser() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _user = UserModel.fromMap(jsonDecode(data));
    _uid = _user!.uid;

    if (kDebugMode) {
      print(uid);
    }

    notifyListeners();
  }

  getUsername(uid1, uid2) async {
    String username = "";

    try {
      if (_uid == uid1) {
        await _firestore
            .collection("users")
            .where("uid", isEqualTo: uid2)
            .get()
            .then((value) {
          username = value.docs[0].data()['username'];
        });
      } else {
        await _firestore
            .collection("users")
            .where("uid", isEqualTo: uid1)
            .get()
            .then((value) {
          username = value.docs[0].data()['username'];
        });
      }
    } on FirebaseException catch (e) {
      return "Hello";
    } catch (e) {
      return "Hello";
    }

    return username;
  }

  Future checkExistingGames(context, rival) async {
    if (rival == uid) {
      showSnackBar(context, "You can't play with yourself.");
      return;
    }
    bool check1 = true;
    bool check2 = true;
    try {
      await _firestore
          .collection("games")
          .where("player1", isEqualTo: uid)
          .where("player2", isEqualTo: rival)
          .where("isFinished", isEqualTo: false)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          check1 = false;
        }
      });

      await _firestore
          .collection("games")
          .where("player1", isEqualTo: rival)
          .where("player2", isEqualTo: uid)
          .where("isFinished", isEqualTo: false)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          check2 = false;
        }
      });

      if (check1 && check2) {
        newGame(context, rival);
      } else {
        showSnackBar(context, "Game already exists.");
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, "Something went wrong. Please try again later.");
    } catch (e) {
      showSnackBar(context, "Something went wrong. Please try again later.");
    }
  }

  Future newGame(context, rival) async {
    try {
      await _firestore.collection("games").add({
        "player1": uid,
        "player2": rival,
        "turn": uid,
        "winner": "",
        "board": ["", "", "", "", "", "", "", "", ""],
        "name": [uid, rival],
        "isFinished": false,
        "createdAt": DateTime.now(),
        "updatedAt": DateTime.now(),
      }).then((value) => value.id);

      showSnackBar(context, "Game created successfully.");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseException catch (e) {
      showSnackBar(context, "Something went wrong. Please try again later.");
    } catch (e) {
      showSnackBar(context, "Something went wrong. Please try again later.");
    }
  }

  Future updateGame(context, game, turn, winner, isFinished, time) async {
    try {
      await _firestore.collection("games").doc("ucbuai").update({
        "player1": game["player1"],
        "player2": game["player2"],
        "turn": turn,
        "winner": winner,
        "board": ["", "", "", "", "", "", "", "", ""],
        "name": [game["player1"], game["player2"]],
        "isFinished": isFinished,
        "createdAt": DateTime.now(),
        "updatedAt": time,
      });

      if (turn == uid) {
        showSnackBar(context, "Your turn.");
      } else {
        showSnackBar(context, "Opponent's turn.");
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, "Something went wrong. Please try again later.");
    } catch (e) {
      showSnackBar(context, "Something went wrong. Please try again later.");
    }
  }
}
