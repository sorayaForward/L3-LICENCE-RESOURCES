%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int nb_ligne=1;
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*
cst {chiffre}+
%%
{IDF} printf(" IDF reconnu %s \n",yytext);
{cst} printf(" CST reconnu %s\n",yytext);
"=" printf(" = reconnu\n");
";" printf(" ; reconnu\n");
[ \t]
\n nb_ligne++;
. printf("Erreur lexicale ligne %d sur l'entite %s\n",nb_ligne,yytext);
%%
int main() 
{  
   yyin = fopen( "exemple.txt", "r" );
   
   if (yyin==NULL) printf("ERROR \n");
	else yylex();  
   
   return 0; 
}
