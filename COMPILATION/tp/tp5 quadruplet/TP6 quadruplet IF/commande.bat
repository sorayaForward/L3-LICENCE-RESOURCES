flex pgm.l
bison -d pgm.y
gcc lex.yy.c pgm.tab.c -lfl -ly -o comp2021.exe
comp2021.exe<exp.txt