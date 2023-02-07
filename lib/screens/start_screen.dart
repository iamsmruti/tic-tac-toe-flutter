import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/providers/auth_provider.dart';
import 'package:tic_tac_toe_v2/screens/home_screen.dart';
import 'package:tic_tac_toe_v2/screens/login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo_full.png",
            fit: BoxFit.cover,
            width: 280,
            height: 280,
          ),
          const Text("Play with friends in Real-Time"),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              if (ap.isSignedIn == true) {
                await ap.getDataFromSP().whenComplete(
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      ),
                    );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            },
            child: const Text("Play Now"),
          )
        ],
      ),
    );
  }
}
