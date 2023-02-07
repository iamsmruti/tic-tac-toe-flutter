import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_v2/providers/auth_provider.dart';
import 'package:tic_tac_toe_v2/screens/about_screen.dart';
import 'package:tic_tac_toe_v2/screens/help_screen.dart';
import 'package:tic_tac_toe_v2/screens/home_screen.dart';
import 'package:tic_tac_toe_v2/screens/new_game_screen.dart';
import 'package:tic_tac_toe_v2/screens/play_computer.dart';
import 'package:tic_tac_toe_v2/screens/play_local_screen.dart';
import 'package:tic_tac_toe_v2/screens/start_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.pinkAccent,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.pinkAccent),
              accountName: Text(
                ap.userModel.name,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              accountEmail: Text(
                ap.userModel.email,
                style: const TextStyle(color: Colors.white),
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.gamepad),
            title: const Text(' My Games '),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.gamepad),
            title: const Text(' Play Locally '),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayLocalScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.gamepad),
            title: const Text(' Play vs Computer '),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayComputer(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text(' New Game '),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewGameScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text(' Help '),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(' About '),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(' LogOut '),
            onTap: () {
              Navigator.pop(context);
              ap.userSignOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StartScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
