%{
#include <stdio.h>
%}

%%
[0-9]+	{ printf("%-10s -> 0x%X\n", yytext, atoi(yytext)); }
.		{ printf("%s", yytext); }
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}