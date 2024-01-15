%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "syntm.tab.h"
#include "ts.h"
extern YYSTYPE yylval;
#include "pgm.h"
int yylineo=1; //compter le nombre de ligne
extern col; //nombre de colonne

struct idf;
idf *a;
struct mc;
mc *b;
struct sep;
sep *c; 
char token[20];
%}

chiffre [0-9]
Commentaire (#)(.)*
IDF [A-Z]([a-z]|{chiffre})*
nbrentier ("("("+"|"-"){chiffre}+")")|{chiffre}+
nbrreel ("("("+"|"-"){chiffre}+("."){chiffre}*")")|{chiffre}+("."){chiffre}*
cstbool (true|false)
cstchar '.'
suittab (" ")*
%%

{nbrentier} {  	strcpy(token, yytext);
				if(yytext[0] == '('){				    
					 strcpy(token, strtok(token,"(+")); 
					 strcpy(token, strtok(token,")"));
				 }
				  if ((atoi(token)>-32768)&&(atoi(token)<32767)){		  
				  a=rechercher(yytext,"nbr entier","int",atof(yytext),0,a,NULL).pidf; 
					 col = col + strlen(yytext); 
					 printf("%s reconnu\n",yytext);
					 yylval.str = strdup(token);
				 return nbrentier;        
			   }else printf ("Erreur Lexical: constante entiere trop grande a la ligne %d a la colonne %d \n ",yylineo, col);}
{nbrreel} {
            a=rechercher(yytext,"nbr reel","reel",atof(yytext),0,a,NULL).pidf; 
			 col = col + strlen(yytext); 
			 printf(" %s reconnu\n",yytext);
			 yylval.reel=atoi(yytext);
			 return nbrreel; 
			 }
{cstbool} {
   col = col + strlen(yytext); 
   printf(" %s reconnu\n",yytext);
   yylval.str=strdup(yytext);
   return cstbool;}
   
   
   
int { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
    printf("%s reconnu\n",yytext);
   col = col + strlen(yytext); 
    yylval.str=strdup(yytext);
   return mc_entier;}
float {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
    printf("%s reconnu\n",yytext);
   col = col + strlen(yytext); 
   yylval.str=strdup(yytext);
   return mc_reel;}
char { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
    printf("%s reconnu\n",yytext);
   col = col + strlen(yytext);
	yylval.str=strdup(yytext);  
	return mc_cara;}
bool { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
    printf("%s reconnu\n",yytext);
   col = col + strlen(yytext);
   yylval.str=strdup(yytext);
   return mc_bool;}
and {c = rechercher(yytext,"and","",0,2,NULL,c).psep; 
 printf("%s reconnu\n",yytext); 
  col = col + strlen(yytext); 
  yylval.str=strdup(yytext);
  return mc_and;}
or {c = rechercher(yytext,"or","",0,2,NULL,c).psep;
  printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
   yylval.str=strdup(yytext);
   return mc_or;}
not {c = rechercher(yytext,"not","",0,2,NULL,c).psep;
  printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
   yylval.str=strdup(yytext);
   return mc_not;}
   
   
   
   
"if" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
    yylval.str = strdup(yytext);
  return mc_if;}
"else" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
    yylval.str = strdup(yytext);
   return mc_else;}
   
   
   
"for" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_for;}
"range" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_range;}
"in range" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_inrange;}
"in" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_in;}
   
   
   
"while" {b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_while;}


{Commentaire} { printf(" Commentaire reconnu :%s\n",yytext);}

{IDF} {a = rechercher(yytext,"IDF","",0,0,a,NULL).pidf;
   printf("idf  %s reconnu\n",yytext); 
   col = col + strlen(yytext); 
   yylval.str = strdup(yytext);
   return IDF; 
  }
{cstchar} {a = rechercher(yytext,"cstchar","",0,0,a,NULL).pidf;
   printf(" %s reconnu\n",yytext);
   	yylval.str = strdup(yytext);
   col = col + strlen(yytext); return cstchar;}

   
   
"(" {c = rechercher(yytext,"parouv","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_parouv;}
")" {c = rechercher(yytext,"parfer","",0,2,NULL,c).psep; 
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_parfer;}
"[" { c = rechercher(yytext,"acouv","",0,2,NULL,c).psep; 
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_acouv;}
"]" {c = rechercher(yytext,"acfer","",0,2,NULL,c).psep; 
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); return mc_acfer;}
":" {c = rechercher(yytext,"dpoint","",0,2,NULL,c).psep; 
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
      yylval.str=strdup(yytext);
	return mc_dpoint;}
   
   
   
"+" {c = rechercher(yytext,"plus","",0,2,NULL,c).psep; 
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
   yylval.str=strdup(yytext);
   return mc_plus;}
"-" {c = rechercher(yytext,"moins","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
   yylval.str = strdup(yytext); 
  return mc_moins;}
"*" {c = rechercher(yytext,"mul","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext);
   yylval.str = strdup(yytext); 
   return mc_mul;}
"/" {c = rechercher(yytext,"div","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext); 
   col = col + strlen(yytext); 
   yylval.str = strdup(yytext); 
   return mc_div;}
"=" {c = rechercher(yytext,"affectation","",0,2,NULL,c).psep; 
  printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext);
   return mc_aff;}
   
   
   
"<" {c = rechercher(yytext,"inf","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext);
   yylval.str=strdup(yytext);
   return mc_inf;}
"<=" {c = rechercher(yytext,"infeq","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
     yylval.str=strdup(yytext);
	return mc_infeq;}
">" {c = rechercher(yytext,"sup","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext);
   yylval.str=strdup(yytext);
   return mc_sup;}
">=" {c = rechercher(yytext,"supeq","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext); 
   col = col + strlen(yytext); 
   yylval.str=strdup(yytext);
   return mc_supeq;}
"!=" {c = rechercher(yytext,"dif","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext);
   yylval.str=strdup(yytext);
   return mc_dif;}
"==" {c = rechercher(yytext,"equal","",0,2,NULL,c).psep; 
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
   yylval.str = strdup(yytext); 
   return mc_equal;}
   
   


"," {c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
   return vg;}
"'" {c = rechercher(yytext,"gi","",0,2,NULL,c).psep;
   printf(" %s reconnu\n",yytext);
   col = col + strlen(yytext); 
   return gi;}
   
   
   
{suittab} {
   if((yyleng % 4 )== 0)
         {
            printf("des tabulations reconnu\n");
            return sptt;
         }
       
       else{
         if(yyleng =1) { printf("un espace reconnu\n"); return spt;}
       }
}


[ \t] {col = col + strlen(yytext); return tabul;}
\n {yylineo++; col=1; return sdl;}


. {printf("Erreur lexicale ligne %d sur l'entite %s\n", yylineo,col,yytext);
   return err;}
   