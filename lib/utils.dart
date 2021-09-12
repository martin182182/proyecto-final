//@dart = 2.9
import 'package:chess/chess.dart';

String makeMove(String fen, String move) {
    final chess = Chess.fromFEN(fen);

    if (chess.move(move)) {
      return chess.fen;
    }

  return 'Vacio';
}
