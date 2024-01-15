%{
#include<stdlib.h>
#include<stdio.h>
%}
chiffre [0-9]
cstint [0-9]+
cstreel {chiffre}*\,{chiffre}*
%%
int { printf("Int %s recnnu \n",yytext); }
{cstint}  { printf("constante %s recnnu \n",yytext); }
{cstreel} { printf("constante reel %s recnnu \n",yytext); }
True      { printf("%s recnnu \n",yytext); }
False 	  { printf("%s recnnu \n",yytext); }
. 		  {printf("Entite lexicale non reconnue\n"); }
%%
