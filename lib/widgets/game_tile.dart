import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameTile extends StatefulWidget {
  final int tileNo;
  int value;
  bool enabled;

  GameTile({
    Key? key,
    required this.tileNo,
    this.value = 0,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  String image = "";
  String value = "";

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    if (widget.value == 1) {
      image = "assets/images/cross.png";
    } else if (widget.value == 2) {
      image = "assets/images/circle.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print("Tile No: ${widget.tileNo}");
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: image == ""
          ? Center(
              child: Text(
              "${widget.tileNo}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ))
          : Center(
              child: Image.asset(
              image,
              height: 50,
              width: 50,
            )),
    );
  }
}
