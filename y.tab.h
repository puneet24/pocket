/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    CHAR = 259,
    STRING = 260,
    EQUAL = 261,
    GT = 262,
    LT = 263,
    LTE = 264,
    GTE = 265,
    ET = 266,
    SEMICOLON = 267,
    COMMA = 268,
    IF = 269,
    ELSE = 270,
    WHILE = 271,
    MINUS = 272,
    PLUS = 273,
    STAR = 274,
    DIV = 275,
    VAR = 276,
    NUMBER = 277,
    STRING_LIT = 278,
    CHAR_LIT = 279
  };
#endif
/* Tokens.  */
#define INT 258
#define CHAR 259
#define STRING 260
#define EQUAL 261
#define GT 262
#define LT 263
#define LTE 264
#define GTE 265
#define ET 266
#define SEMICOLON 267
#define COMMA 268
#define IF 269
#define ELSE 270
#define WHILE 271
#define MINUS 272
#define PLUS 273
#define STAR 274
#define DIV 275
#define VAR 276
#define NUMBER 277
#define STRING_LIT 278
#define CHAR_LIT 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
