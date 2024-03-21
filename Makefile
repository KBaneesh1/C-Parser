
CC = gcc

FLEX = flex

YACC = bison
YFLAGS = -dy

OUTPUT = parser

LEXER = lex.yy.c
LEXER_TAB = lex.yy.h
PARSER = y.tab.c
PARSER_TAB = y.tab.h

all:    $(OUTPUT)

$(OUTPUT):  $(LEXER) $(PARSER)
	$(CC) $(LEXER) $(PARSER) -o $(OUTPUT)

$(LEXER):   c_lexer.l
	$(FLEX) c_lexer.l

$(PARSER): c_parser.y
	$(YACC) $(YFLAGS) c_parser.y  -Wno

clean:
	rm -f $(LEXER) $(PARSER) $(OUTPUT) $(LEXER_TAB) $(PARSER_TAB)