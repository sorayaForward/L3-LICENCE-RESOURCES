%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "syntm.tab.h"
int yylineo=1; //compter le nombre de ligne
extern col; //nombre de colonne
#include "ts.h"
extern a;
extern b;
extern c; 
%}
lettreM [A-Z]
lettre [a-zA-Z]
lettrem [a-z]
chiffre [0-9]
Commentaire (#)(.)*
IDF {lettreM}({lettrem}|{chiffre})*
suitlettre {lettre}*
nbrentier ("("("+"|"-"){chiffre}+")")|{chiffre}+
nbrreel ("("("+"|"-"){chiffre}+("."){chiffre}*")")|{chiffre}+("."){chiffre}*
cstbool (true|false)
%%
{nbrentier} {if ((atoi(yytext)>-32768)&&(atoi(yytext)<32767)){		  
              a=rechercher(yytext,"nbr entiere","int",atof(yytext),0,a,NULL).pidf; 
			     col = col + strlen(yytext); return nbrentier; 
			     printf ("L entite lexicale reconnue est %s \n", yytext);
			   }else printf ("Erreur Lexical: constante entiere trop grande a la ligne %d a la colonne %d \n ",yylineo, col);}
{nbrreel} {a=rechercher(yytext,"nbr reel","reel",atof(yytext),0,a,NULL).pidf; 
			 col = col + strlen(yytext); return nbrreel; 
			printf ("L entite lexicale reconnue est %s \n", yytext);}
{cstbool} {
   col = col + strlen(yytext); return cstbool;}
int { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_entier;}
float {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_reel;}
char { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_cara;}
bool { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_bool;}
and {c = rechercher(yytext,"and","",0,2,NULL,c).psep;  
  col = col + strlen(yytext); return mc_and;}
or {c = rechercher(yytext,"or","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_or;}
not {c = rechercher(yytext,"not","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_not;}
"=" {c = rechercher(yytext,"affectation","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_aff;}
"if" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_if;}
"else" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_else;}
"for" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_for;}
"range" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_range;}
"in range" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_inrange;}
"in" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_in;}
"while" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf ("L entite lexicale reconnue est %s \n", yytext);
   col = col + strlen(yytext); return mc_while;}
"(" {c = rechercher(yytext,"parouv","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_parouv;}
")" {c = rechercher(yytext,"parfer","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_parfer;}
"[" { c = rechercher(yytext,"acouv","",0,2,NULL,c).psep; 
    col = col + strlen(yytext); return mc_acouv;}
"]" {c = rechercher(yytext,"acfer","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_acfer;}
":" {c = rechercher(yytext,"dpoint","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_dpoint;}
"+" {c = rechercher(yytext,"plus","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_plus;}
"-" {c = rechercher(yytext,"moins","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_moins;}
"*" {c = rechercher(yytext,"mul","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_mul;}
"/" {c = rechercher(yytext,"div","",0,2,NULL,c).psep;; 
   col = col + strlen(yytext); return mc_div;}
"<" {c = rechercher(yytext,"inf","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_inf;}
"<=" {c = rechercher(yytext,"infeq","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_infeq;}
">" {c = rechercher(yytext,"sup","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_sup;}
">=" {c = rechercher(yytext,"supeq","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_supeq;}
"!=" {c = rechercher(yytext,"dif","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return mc_dif;}
"==" {c = rechercher(yytext,"equal","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return mc_equal;}
"," {c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
   col = col + strlen(yytext); return vg;}
" " { col = col + strlen(yytext); return spt;}
"'" {c = rechercher(yytext,"gi","",0,2,NULL,c).psep; 
   col = col + strlen(yytext); return gi;}
{IDF} {a = rechercher(yytext,"IDF","",0,0,a,NULL).pidf; 
      col = col + strlen(yytext); return IDF; }
{suitlettre} {a = rechercher(yytext,"suitelettre","",0,0,a,NULL).pidf;
   col = col + strlen(yytext); return slet;}
{Commentaire} 
[ \t] {col = col + strlen(yytext); return tabul;}
\n {yylineo++; col=1; return sdl;}
. {printf("Erreur lexicale ligne %d sur l'entite %s\n", yylineo,col,yytext);
   return err;}

 