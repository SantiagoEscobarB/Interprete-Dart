enum TokenType {
  // Operadores y simbolos
  assign, // =
  comma, // ,
  dif, // !=
  eq, // ==
  gt, // >
  gte, // >=
  lt, // <
  lte, // <=
  plus, // +
  minus, // -
  negation, // !
  pow, // ^
  multiply, // *
  mod, // %
  // Delimitadores
  lParen, // (
  rParen, // )
  lBrace, // {
  rBrace, // }
  lBracket, // [
  rBracket, // ]
  semicolon, // ;
  // Tipos de datos
  identifier,
  integer,
  string,

  // Palabras reservadas - tipos
  integerKeyword, // integer
  // Palabras reservadas
  function,
  let,
  ifKeyword,
  elseKeyword,
  elseifKeyword,
  forKeyword,
  whileKeyword,
  returnKeyword,
  breakKeyword,
  continueKeyword,

  // Tokens especiales
  eof,
  illegal,
}

class Token {
  final TokenType tokenType;
  final String literal;

  const Token(this.tokenType, this.literal);

  @override
  String toString() => 'Type: $tokenType, Literal: $literal';

  @override
  bool operator ==(Object other) =>
      other is Token &&
      other.tokenType == tokenType &&
      other.literal == literal;

  @override
  int get hashCode => Object.hash(tokenType, literal);
}

TokenType lookupTokenType(String literal) {
  const keywords = <String, TokenType>{
    'integer': TokenType.integerKeyword,
    'function': TokenType.function,
    'for': TokenType.forKeyword,
    'let': TokenType.let,
    'if': TokenType.ifKeyword,
    'else': TokenType.elseKeyword,
    'elseif': TokenType.elseifKeyword,
    'while': TokenType.whileKeyword,
    'return': TokenType.returnKeyword,
    'continue': TokenType.continueKeyword,
    'break': TokenType.breakKeyword,
  };
  return keywords[literal] ?? TokenType.identifier;
}
