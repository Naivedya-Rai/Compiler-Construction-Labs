%{
#include <stdio.h>
#include <string.h>

int comment_count = 0;
int keyword_count = 0;
int identifier_count = 0;
int word_count = 0;
int line_count = 0;
int space_count = 0;

char keywords[][20] = {
    "if", "else", "while", "for", "def", "class", "import", "from", "return", "print"
};

%}

%%

"//"(.*) {comment_count++;}
"#"(.*) {comment_count++;}

[ \t] { space_count += strlen(yytext); }
[\n] { line_count++; space_count++; }

[a-zA-Z_][a-zA-Z0-9_]* {
    int is_keyword = 0;
    for(int i=0; i<sizeof(keywords); i++){
        if(strcmp(yytext, keywords[i])==0){
            is_keyword = 1;
            break;
        }
    }
    if(is_keyword){
        keyword_count++;
    }
    else{
        identifier_count++;
    }

    word_count++;
}

. {word_count++;}

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    yyin = input_file;
    yylex();

    fclose(input_file);

    printf("Comment Count: %d\n", comment_count);
    printf("Keyword Count: %d\n", keyword_count);
    printf("Identifier Count: %d\n", identifier_count);
    printf("Word Count: %d\n", word_count);
    printf("Line Count: %d\n", line_count);
    printf("Space Count: %d\n", space_count);

    return 0;
}

int yywrap() {
    return 1;
}
