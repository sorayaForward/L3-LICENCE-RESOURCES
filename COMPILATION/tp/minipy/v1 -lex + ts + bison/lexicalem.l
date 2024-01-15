%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "syntm.tab.h"
int yylineo=1; //compter le nombre de ligne
extern col; //nombre de colonne
#include "ts.h"
struct idf;
idf *a;
struct mc;
mc *b;
struct sep;
sep *c; 
%}
lettreM [A-Z]
lettre [a-zA-Z]
lettrem [a-z]
chiffre [0-9]
commentaire (#)(.)*(\n)
IDF {lettreM}({lettrem}|{chiffre})*
nbrentier ("("("+"|"-"){chiffre}+")")|{chiffre}+
nbrreel ("("("+"|"-"){chiffre}+("."){chiffre}*")")|{chiffre}+("."){chiffre}*
cstbool (true|false)
cstchar {lettre}|{chiffre}
suittab (" ")*
%%
{commentaire} 	{ printf(" Commentaire reconnu :%s\n",yytext); }

{nbrentier} {if ((atoi(yytext)>-32768)&&(atoi(yytext)<32767)){		  
              a=rechercher(yytext,"nbr entier","int",atof(yytext),0,a,NULL).pidf; 
			     col = col + strlen(yytext); 
			     printf ("L entite lexicale reconnue est %s \n", yytext);
				 yylval.entier = atoi(yytext);//to send the value to bison
				 return nbrentier;
			   }else printf ("Erreur Lexical: constante entiere trop grande a la ligne %d a la colonne %d \n ",yylineo, col);}
{nbrreel} {a=rechercher(yytext,"nbr reel","reel",atof(yytext),0,a,NULL).pidf; 
			 col = col + strlen(yytext); 
			printf ("L entite lexicale reconnue est %s \n", yytext);
			yylval.reel = atof(yytext);
			return nbrreel;}
and               { b = rechercher(yytext,"Mc_and","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_and;
				  }
or                { b = rechercher(yytext,"Mc_or","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_or;
				  }
not               { b = rechercher(yytext,"Mc_not","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_not;
				  }
int               { b = rechercher(yytext,"Mc_int","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
					yylval.str = strdup(yytext);
					return mc_entier;
				  }
float             { b = rechercher(yytext,"Mc_float","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
					yylval.str = strdup(yytext);
					return mc_reel;
				  }
char              { b = rechercher(yytext,"Mc_char","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
					yylval.str = strdup(yytext);
					return mc_cara;
				  }
bool              { b = rechercher(yytext,"Mc_bool","",0,1,NULL,b).pmc; 
				   printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
				   yylval.str = strdup(yytext);
				   return mc_bool;
				  }
if                { b = rechercher(yytext,"Mc_if","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
					return mc_if;
    			  }
else              { b = rechercher(yytext,"Mc_else","",0,1,NULL,b).pmc;
                    printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);		
                    return mc_else;					
                  }
"for" 			  {  b = rechercher(yytext,"Mc_for","",0,1,NULL,b).pmc;
					printf ("L entite lexicale reconnue est %s \n", yytext);col = col + strlen(yytext); 
					return mc_for;
				  }				  
"in range"        { b = rechercher(yytext,"Mc_inRange","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
					return mc_inrange;
				  }
"range" 		  { b = rechercher(yytext,"Mc_range","",0,1,NULL,b).pmc;
				  printf ("L entite lexicale reconnue est %s \n", yytext);col = col + strlen(yytext);
				  return mc_range;
				  }
in           	  { b = rechercher(yytext,"Mc_in","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
					return mc_in;
				  } 
while 			  { b = rechercher(yytext,"Mc_while","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);col= col + strlen(yytext);
					return mc_while;
				  }
true   			  { b = rechercher(yytext,"Mc_true","",0,1,NULL,b).pmc;
					printf(" boolean %s reconnu\n",yytext);col= col + strlen(yytext);
					return cstbool;
				  }
false             { b = rechercher(yytext,"Mc_false","",0,1,NULL,b).pmc;
					printf(" boolean %s reconnu\n",yytext);col= col + strlen(yytext);
					return cstbool;
				  }
","	              { c = rechercher(yytext,"vergule","",0,2,NULL,c).psep;
				    printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return vg;
				  }
"="	              { c = rechercher(yytext,"egale","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_aff;
				  }
"["               { c = rechercher(yytext,"chauv_ouv","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext); 
					return mc_acouv;
				  }
"]"               { c = rechercher(yytext,"chauv_ferm","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_acfer;
 				  }
":"               { c = rechercher(yytext,"deux_points","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext); 
					return mc_dpoint;
				  }
">"               { c = rechercher(yytext,"greater","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_sup;
				  }
"<"               { c = rechercher(yytext,"lesser","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_inf;
				  }
"=="              { c = rechercher(yytext,"equal","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_equal;
				  }
"!="              { c = rechercher(yytext,"not equal","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_dif;
				  }
"<="              { c = rechercher(yytext,"lesser or eq","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_infeq;
				  }
">="              { c = rechercher(yytext,"greater or eq","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_supeq;
				  }

"+"               { c = rechercher(yytext,"add","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_plus;
				  }
"-"               { c = rechercher(yytext,"sub","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_moins;
				  }
"*"               { c = rechercher(yytext,"mul","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_mul;
				  }
"/"               { c = rechercher(yytext,"div","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_div;
				  }
"("               {c = rechercher(yytext,"parenthese ouv","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext);
					return mc_parouv;
				  }
")"               {c = rechercher(yytext,"perenthese ferm","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);col= col + strlen(yytext); 
					return mc_parfer;
				  }				  
" " 			  { col = col + strlen(yytext);
					//return spt;
				  }
			
{IDF}             {	if (yyleng>8){	col= col + strlen(yytext);
									printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",yylineo,col);
									return IDF;
									}
							else {
							a = rechercher(yytext,"idf","",0,0,a,NULL).pidf;
                            printf(" IDF reconnu %s \n",yytext);col= col + strlen(yytext);
							yylval.str = strdup(yytext);							
							return IDF;
							}
				  }
{cstchar} 		  { a = rechercher(yytext,"cstchar","",0,0,a,NULL).pidf;
				    printf(" %s reconnu\n",yytext);
				    col = col + strlen(yytext); return cstchar;
				  }
{suittab}          { 
					if(( yyleng % 4 )== 0)
					  {
						printf("des tabulations reconnu\n");
						return sptt;
					  }
				    else{
				      if(yyleng =1) { printf("un espace reconnu\n"); return spt;}
                    }
                  }
\t             		{col=col+strlen(yytext);
					return tabul;
				  }

\n 					{ yylineo++; col=1;
					return sdl;
					}

.				  {printf("Erreur lexicale ligne %d a la colonne %d sur l'entite %s\n",yylineo,col,yytext);
				   return err;
				   }


 