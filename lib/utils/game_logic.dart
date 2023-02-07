int checkWinner(var player1, var player2) {
  var winner = -1;
  if (player1.contains(0) && player1.contains(1) && player1.contains(2)) {
    winner = 1;
  }
  if (player2.contains(0) && player2.contains(1) && player2.contains(2)) {
    winner = 2;
  }

  // row 2
  if (player1.contains(3) && player1.contains(4) && player1.contains(5)) {
    winner = 1;
  }
  if (player2.contains(3) && player2.contains(4) && player2.contains(5)) {
    winner = 2;
  }

  // row 3
  if (player1.contains(6) && player1.contains(7) && player1.contains(8)) {
    winner = 1;
  }
  if (player2.contains(6) && player2.contains(7) && player2.contains(8)) {
    winner = 2;
  }

  // col 1
  if (player1.contains(0) && player1.contains(3) && player1.contains(6)) {
    winner = 1;
  }
  if (player2.contains(0) && player2.contains(3) && player2.contains(6)) {
    winner = 2;
  }

  // col 2
  if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
    winner = 1;
  }
  if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
    winner = 2;
  }

  // col 3
  if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
    winner = 1;
  }
  if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
    winner = 2;
  }

  //diagonal
  if (player1.contains(0) && player1.contains(4) && player1.contains(8)) {
    winner = 1;
  }
  if (player2.contains(0) && player2.contains(4) && player2.contains(8)) {
    winner = 2;
  }

  if (player1.contains(2) && player1.contains(4) && player1.contains(6)) {
    winner = 1;
  }
  if (player2.contains(2) && player2.contains(4) && player2.contains(6)) {
    winner = 2;
  }
  return winner;
}
