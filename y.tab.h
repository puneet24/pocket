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
    VAR = 258,
    NUMBER = 259,
    CHAR_LIT = 260,
    STRING_LIT = 261,
    EQUAL = 262,
    GT = 263,
    LT = 264,
    LTE = 265,
    GTE = 266,
    ET = 267,
    PLUS = 268,
    MINUS = 269,
    STAR = 270,
    DIV = 271,
    INT = 272,
    CHAR = 273,
    STRING = 274,
    SEMICOLON = 275,
    COMMA = 276,
    IF = 277,
    ELSE = 278,
    WHILE = 279,
    FOR = 280
  };
#endif
/* Tokens.  */
#define VAR 258
#define NUMBER 259
#define CHAR_LIT 260
#define STRING_LIT 261
#define EQUAL 262
#define GT 263
#define LT 264
#define LTE 265
#define GTE 266
#define ET 267
#define PLUS 268
#define MINUS 269
#define STAR 270
#define DIV 271
#define INT 272
#define CHAR 273
#define STRING 274
#define SEMICOLON 275
#define COMMA 276
#define IF 277
#define ELSE 278
#define WHILE 279
#define FOR 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 22 "lang.y" /* yacc.c:1909  */

	union constant val;
	char code[1000];
	nodeType *nptr;

#line 110 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
