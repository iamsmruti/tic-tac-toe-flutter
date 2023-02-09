import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/providers/game_provider.dart';
import 'package:tic_tac_toe_v2/widgets/snackbar.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final phoneController = TextEditingController();

  void createNewGame() {
    final ap = Provider.of<GameProvider>(context, listen: false);
    ap.getUser();
    ap.checkExistingGames(context, "+91${phoneController.text.trim()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Game"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Whom do you want",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "to play with?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 8),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
              hintText: "Enter your friend's phone number",
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: () {
                if (phoneController.text.trim().isNotEmpty) {
                  createNewGame();
                } else {
                  showSnackBar(context, "Please enter a valid phone number");
                }
              },
              child: const Text("Create Game"))
        ]),
      ),
    );
  }
}
