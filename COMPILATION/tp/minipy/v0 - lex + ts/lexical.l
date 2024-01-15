%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylineo=1; //compter le nombre de ligne
int Col = 1; //nombre de colonne
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
commentaire (#)(.)+
IDF ^{lettreM}({lettrem}|{chiffre})*
nbrentier ("("("+"|"-"){chiffre}+")")|{chiffre}+
nbrreel ("("("+"|"-"){chiffre}+("."){chiffre}*")")|{chiffre}+("."){chiffre}*
%%
{nbrentier} {if ((atoi(yytext)>-32768)&&(atoi(yytext)<32767)){		  
              a=rechercher(yytext,"nbr entier","int",atof(yytext),0,a,NULL).pidf; 
			     Col = Col + strlen(yytext); 
			     printf ("L entite lexicale reconnue est %s \n", yytext);
			   }else printf ("Erreur Lexical: constante entiere trop grande a la ligne %d  la colonne %d \n ",yylineo, Col);}
{nbrreel} {a=rechercher(yytext,"nbr reel","reel",atof(yytext),0,a,NULL).pidf; 
			 Col = Col + strlen(yytext); 
			printf ("L entite lexicale reconnue est %s \n", yytext);}
and               { b = rechercher(yytext,"Mc_and","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
or                { b = rechercher(yytext,"Mc_or","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
not               { b = rechercher(yytext,"Mc_not","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
int               { b = rechercher(yytext,"Mc_int","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
float             { b = rechercher(yytext,"Mc_float","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
char              { b = rechercher(yytext,"Mc_char","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
bool              { b = rechercher(yytext,"Mc_bool","",0,1,NULL,b).pmc; 
				   printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
if                { b = rechercher(yytext,"Mc_if","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
    			  }
else              { b = rechercher(yytext,"Mot_cle_else","",0,1,NULL,b).pmc;
                    printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);			
                  }
"in range"        { b = rechercher(yytext,"Mc_inRange","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
in           	  { b = rechercher(yytext,"Mc_in","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  } 
while 			  { b = rechercher(yytext,"Mc_while","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
true   			  { b = rechercher(yytext,"Mc_true","",0,1,NULL,b).pmc;
					printf(" boolean %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
false             { b = rechercher(yytext,"Mc_false","",0,1,NULL,b).pmc;
					printf(" boolean %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
","	              { c = rechercher(yytext,"vergule","",0,2,NULL,c).psep;
				    printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"="	              { c = rechercher(yytext,"egale","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"["               { c = rechercher(yytext,"chauv_ouv","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext); 
				  }
"]"               { c = rechercher(yytext,"chauv_ferm","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
 				  }
":"               { c = rechercher(yytext,"deux_points","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext); 
				  }
">"               { c = rechercher(yytext,"greater","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"<"               { c = rechercher(yytext,"lesser","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"=="              { c = rechercher(yytext,"double equal","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"!="              { c = rechercher(yytext,"not equal","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"<="              { c = rechercher(yytext,"lesser or eq","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"+"               { c = rechercher(yytext,"add","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"-"               { c = rechercher(yytext,"sub","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"*"               { c = rechercher(yytext,"mul","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"/"               { c = rechercher(yytext,"div","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"("               {c = rechercher(yytext,"parenthese ouv","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
")"               {c = rechercher(yytext,"perenthese ferm","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext); 
				  }
{IDF}             {	if (yyleng>8){printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",yylineo,Col);

							}
							else {
							a = rechercher(yytext,"idf","",0,0,a,NULL).pidf;
                            printf(" IDF reconnu %s \n",yytext);Col= Col + strlen(yytext); 
							}
					}
{commentaire} 		{ printf(" Commentaire reconnu :%s\n",yytext);}
[ \t]              Col=Col+strlen(yytext);
\n 	               { yylineo++;Col=1; }
. printf("Erreur lexicale ligne %d a la colonne %d sur l'entite %s\n",yylineo,Col,yytext);


%%
main(){	


 	yylex();
 afficher(b,c,a);

}
 
