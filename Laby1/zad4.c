#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

void findAllOccurrences(char pattern[], char text[]){
    if(pattern == NULL || text == NULL){
        printf("pattern OR text IS NULL: PATTERN:%s STRING: %s \n", pattern, text);
        return;
    }

    size_t patternLength = strlen(pattern);

    for(size_t i = 0; i < patternLength; i++){
        if(text[i] == '\0'){
            printf("TEXT IS SHORTER THAN PATTERN!\n");
            return;
        }
    }


    size_t currentIndex = 0;

    while(text[currentIndex + patternLength - 1] != '\0'){
        if(memcmp(pattern, &text[currentIndex], patternLength) == 0){
            printf("FOUND MATCH AT INDEX: %lu \n", currentIndex);
        }
        currentIndex++;
    }

    return;
}

int main(){

    char pattern[] = "ABRA";
    char text[] = "ABRACADABRA";

    findAllOccurrences(pattern, text);

    return 0;

}