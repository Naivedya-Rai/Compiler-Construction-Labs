%{
#include <stdio.h>
int com_count = 0;
%}

%%
.*com\n {++com_count;}
\n {}
.
%%

int main() {
	yylex();
	printf("Number of lines with com: %d\n", com_count);
	return 0;
}

int yywrap() {
	return 1;
}
