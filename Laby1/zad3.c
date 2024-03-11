#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

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

size_t longestPrefixSuffix(char firstString[], char secondString[]){

    size_t firstStringLength, secondStringLength;

    if(firstString == NULL || secondString == NULL){
        printf("firstString OR secondString IS NULL: PATTERN:%s STRING: %s \n", firstString, secondString);
        return false;
    }

    firstStringLength = strlen(firstString);
    secondStringLength = strlen(secondString);

    size_t result = 0;

    for(size_t i = 0; i < firstStringLength; i++){
        size_t k = firstStringLength - i;
        char* pattern = malloc(sizeof(char)*k);
        memcpy(pattern, firstString, k);
        if(isPostfix(pattern, secondString)){
            result = k;
            break;
        }    
    }

    return result;

}

int main(){

    char firstString[] = "ABRA";
    char secondString[] = "ABRACADABRA";

    printf("RESULT: %ld \n", longestPrefixSuffix(firstString, secondString));

    return 0;

}