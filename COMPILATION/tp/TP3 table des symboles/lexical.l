%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
   int yylineo=1; //compter le nombre de ligne
   extern Col; //nombre de colonne
   #include "syntaxique.tab.h"
   #include "ts.h"
%}
lettreM [A-Z]
lettre [a-zA-Z]
chiffre[0-9]
IDF{lettreM}({lettre}|{chiffre})*
cstint {chiffre}+
%%
DEBUT { rechercher(yytext,"Mot cle","",0, 1); 
		Col= Col + strlen(yytext); 
		printf (" L entite lexicale reconnue est %s \n", yytext); return mc_deb;  }
FIN { rechercher(yytext,"Mot cle","",0, 1); Col= Col + strlen(yytext); 
			printf (" L entite lexicale reconnue est %s \n", yytext); return mc_fin;  }
INTEGER   { rechercher(yytext,"Mot cle","",0, 1); Col= Col + strlen(yytext); 
			printf (" L entite lexicale reconnue est %s \n", yytext); return mc_entier; }
REAL      { rechercher(yytext,"Mot cle","",0, 1); Col= Col + strlen(yytext); 
			printf (" L entite lexicale reconnue est %s \n", yytext); return mc_reel; }
STRING      { rechercher(yytext,"Mot cle","",0, 1); Col= Col + strlen(yytext); 
			printf (" L entite lexicale reconnue est %s \n", yytext); return mc_str; }
CONST      { rechercher(yytext,"Mot cle","",0, 1); Col= Col + strlen(yytext); 
			printf (" L entite lexicale reconnue est %s \n", yytext); return mc_const; }
			
"/"       { rechercher(yytext,"Division","",0,2); Col= Col + strlen(yytext); return divi;}
"+"       { rechercher(yytext,"Addition","",0,2); Col= Col + strlen(yytext); return add;}
";"		  {rechercher(yytext,"Point virgule","",0,2); Col=Col+strlen(yytext);return pv;}
"."		  {rechercher(yytext,"Point","",0,2); Col=Col+strlen(yytext);	return pt;}
"="		  {rechercher(yytext,"Affectation","",0,2); Col=Col+strlen(yytext);	return aff;}
","		  {rechercher(yytext,"Virgule","",0,2); Col=Col+strlen(yytext);	return vg;}
{IDF}     { 
			  rechercher(yytext,"IDF","",0,0);  
              Col= Col + strlen(yytext);
			  if (yyleng>10) printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",yylineo, Col);
              else {printf (" L entite lexicale reconnue est %s \n", yytext); 
					return idf;}
		  }
{cstint}     { 
			  if ((atoi(yytext)>-32768)&&(atoi(yytext)<32767)){		  
              rechercher(yytext,"Cst entiere","INTEGER",atof(yytext),0); 
			  Col= Col + strlen(yytext); 
			  printf ("L entite lexicale reconnue est %s \n", yytext);
			  return cstint;
			  }else printf ("Erreur Lexical: constante entiere trop grande a la ligne %d a la colonne %d \n ",yylineo, Col);
		     }

[ \t] 	Col=Col+strlen(yytext);
\n 		{ yylineo++; Col=1; }
. printf ("Entite lexicale non reconnue a ligne %d a la colonne %d \n", yylineo, Col);
