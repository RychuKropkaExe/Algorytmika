#include <stdio.h>
int main() { char *s="#include <stdio.h>%cint main() { char *s=%c%s%c; printf(s,34,s,34); }"; printf(s,10, 34,s,34);}  