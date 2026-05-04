import 'dart:io';
import 'lexer.dart';
import 'token.dart';

const _eofToken = Token(TokenType.eof, '');

void startRepl() {
  while (true) {
    stdout.write('>> ');
    final source = stdin.readLineSync() ?? '';

    if (source == 'salir()') break;

    final lexer = Lexer(source);
    Token token;

    while ((token = lexer.nextToken()) != _eofToken) {
      print(token);
    }
  }
}
