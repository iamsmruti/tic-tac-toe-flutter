import 'dart:convert';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class GameModel {
    GameModel({
        required this.id,
        required this.player1,
        required this.player2,
        required this.turn,
        required this.winner,
        required this.isFinished,
        required this.board,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String player1;
    String player2;
    String turn;
    String winner;
    String isFinished;
    List<String> board;
    DateTime createdAt;
    DateTime updatedAt;

    factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        id: json["_id"],
        player1: json["player1"],
        player2: json["player2"],
        turn: json["turn"],
        winner: json["winner"],
        isFinished: json["isFinished"],
        board: List<String>.from(json["board"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "player1": player1,
        "player2": player2,
        "turn": turn,
        "winner": winner,
        "isFinished": isFinished,
        "board": List<dynamic>.from(board.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
