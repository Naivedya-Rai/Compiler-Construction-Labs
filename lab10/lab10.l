%{
#include <stdio.h>
int tempCount = 1;
%}

%option noyywrap

%%
[0-9]+ {
    printf("t%d = %s\n", tempCount, yytext);
    tempCount++;
}
[a-zA-Z_][a-zA-Z0-9_]* {
    printf("t%d = %s\n", tempCount, yytext);
    tempCount++;
}
[-+*/] {
    char op = yytext[0];
    printf("t%d = t%d %c t%d\n", tempCount, tempCount - 2, op, tempCount - 1);
    tempCount++;
}
\n {
    // Newline, reset the temp count for the next line
    tempCount = 1;
}
. {
    // Ignore other characters
}

%%

int main() {
    yylex();
    return 0;
}