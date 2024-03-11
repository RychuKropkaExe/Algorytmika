#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool isPrefix(char pattern[], char string[]){

    size_t patternLength, stringLength;

    if(string == NULL || pattern == NULL){
        printf("PATTERN OR STRIGN IS NULL: PATTERN:%s STRING: %s \n", pattern, string);
        return false;
    }

    patternLength = strlen(pattern);
    stringLength = strlen(string);

    if(patternLength > stringLength) {
        return false;
    }

    bool result = true;

    for(size_t i = 0; i < patternLength; i++){
        if(pattern[i] != string[i]){
            result = false;
        }   
    }

    return result;

}

bool isPostfix(char pattern[], char string[]){

    size_t patternLength, stringLength;

    if(string == NULL || pattern == NULL){
        printf("PATTERN OR STRIGN IS NULL: PATTERN:%s STRING: %s \n", pattern, string);
        return false;
    }

    patternLength = strlen(pattern);
    stringLength = strlen(string);

    if(patternLength > stringLength) {
        return false;
    }

    bool result = true;

    for(size_t i = 0; i < patternLength; i++){

        size_t stringIndex = i + (stringLength - patternLength);

        if(pattern[i] != string[stringIndex]){
            result = false;
        }
   
    }

    return result;

}

int main(){

    char prefix[] = "NIG";
    char badPrefix[] = "WHI";

    char string[] = "NIGGER";

    printf("RESULT: CMP PREFIX STRING: %u CMP BADPREFIX STRING: %u \n", isPrefix(prefix, string), isPrefix(badPrefix, string));

    char suffix[] = "GER";
    char badSuffix[] = "WHI";

    printf("RESULT: CMP SUFIX STRING: %u CMP BADSUFIX STRING: %u \n", isPostfix(suffix, string), isPostfix(badSuffix, string));

    return 0;

}
