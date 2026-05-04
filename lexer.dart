import 'token.dart';

class Lexer {
  final String _source;
  String _character = '';
  int _position = 0;
  int _readPosition = 0;

  Lexer(String source) : _source = source {
    _readCharacter();
  }

  Token nextToken() {
    _skipWhiteSpaces();

    switch (_character) {
      case '':
        return _singleToken(TokenType.eof);
      case '+':
        return _singleToken(TokenType.plus);
      case '-':
        return _singleToken(TokenType.minus);
      case '*':
        return _singleToken(TokenType.multiply);
      case '%':
        return _singleToken(TokenType.mod);
      case '^':
        return _singleToken(TokenType.pow);
      case '(':
        return _singleToken(TokenType.lParen);
      case ')':
        return _singleToken(TokenType.rParen);
      case '{':
        return _singleToken(TokenType.lBrace);
      case '}':
        return _singleToken(TokenType.rBrace);
      case '[':
        return _singleToken(TokenType.lBracket);
      case ']':
        return _singleToken(TokenType.rBracket);
      case ';':
        return _singleToken(TokenType.semicolon);
      case ',':
        return _singleToken(TokenType.comma);
      case '>':
        if (_peekCharacter() == '=') {
          return _makeTwoCharacterToken(TokenType.gte);
        }
        return _singleToken(TokenType.gt);
      case '<':
        if (_peekCharacter() == '=') {
          return _makeTwoCharacterToken(TokenType.lte);
        }
        return _singleToken(TokenType.lt);
      case '!':
        if (_peekCharacter() == '=') {
          return _makeTwoCharacterToken(TokenType.dif);
        }
        return _singleToken(TokenType.negation);
      case '=':
        if (_peekCharacter() == '=') {
          return _makeTwoCharacterToken(TokenType.eq);
        }
        return _singleToken(TokenType.assign);
      default:
        if (_isLetter(_character)) {
          final literal = _readIdentifier();
          return Token(lookupTokenType(literal), literal);
        } else if (_isDigit(_character)) {
          return Token(TokenType.integer, _readNumber());
        } else {
          return _singleToken(TokenType.illegal);
        }
    }
  }

  // Lee un único carácter, avanza y retorna el token
  Token _singleToken(TokenType tokenType) {
    final token = Token(tokenType, _character);
    _readCharacter();
    return token;
  }

  // Lee dos caracteres consecutivos y retorna el token compuesto
  Token _makeTwoCharacterToken(TokenType tokenType) {
    final prefix = _character;
    _readCharacter();
    final suffix = _character;
    _readCharacter();
    return Token(tokenType, '$prefix$suffix');
  }

  void _skipWhiteSpaces() {
    while (_character == ' ' ||
        _character == '\t' ||
        _character == '\n' ||
        _character == '\r') {
      _readCharacter();
    }
  }

  void _readCharacter() {
    if (_readPosition >= _source.length) {
      _character = '';
    } else {
      _character = _source[_readPosition];
    }
    _position = _readPosition;
    _readPosition++;
  }

  String _readNumber() {
    final start = _position;
    while (_isDigit(_character)) {
      _readCharacter();
    }
    return _source.substring(start, _position);
  }

  String _readIdentifier() {
    final start = _position;
    while (_isLetter(_character) || _isDigit(_character)) {
      _readCharacter();
    }
    return _source.substring(start, _position);
  }

  String _peekCharacter() {
    if (_readPosition >= _source.length) return '';
    return _source[_readPosition];
  }

  bool _isLetter(String char) {
    if (char.isEmpty) return false;
    final code = char.codeUnitAt(0);
    return (code >= 65 && code <= 90) ||
        (code >= 97 && code <= 122) ||
        char == '_';
  }

  bool _isDigit(String char) {
    if (char.isEmpty) return false;
    final code = char.codeUnitAt(0);
    return code >= 48 && code <= 57;
  }
}
