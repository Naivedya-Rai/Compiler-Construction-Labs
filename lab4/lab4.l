%{
#include <stdio.h>
int a_word_count = 0;
%}
%%
[aA][a-zA-Z]* { a_word_count++; }
.|\n { /* Ignore other characters */ }
%%
int main() {
yylex();
printf("Number of words starting with 'A' or 'a': %d\n", a_word_count);
return 0;
}
int yywrap() {
return 1;
}