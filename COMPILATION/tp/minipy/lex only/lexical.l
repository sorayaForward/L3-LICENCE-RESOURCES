%{

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts.h"
int Col;
int nb_ligne=1;
idf *a;
mc *b;
sep *c;


%}

lettreMaj [A-Z]
lettreMin [a-z]
chiffre [0-9]
IDF {lettreMaj}({lettreMin}|{chiffre})*

commentaire (#.*)

%%

and               { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
or                { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
not               { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
int               { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
float             { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
char              { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
bool              { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc; 
				   printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
if                { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
    			  }
else              { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
                    printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);			
                  }
"in range"        { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
in           	  { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  } 
while 			  { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" mot cle (%s) reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
true   			  { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" boolean %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
false             { b = rechercher(yytext,"Mot cle","",0,1,NULL,b).pmc;
					printf(" boolean %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
","	              { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
				    printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"="	              { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"["               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext); 
				  }
"]"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
 				  }
":"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext); 
				  }
">"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"<"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"=="              { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"!="              { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"<="              { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"+"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"-"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"*"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"/"               { c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
"("               {c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext);
				  }
")"               {c = rechercher(yytext,"Vergule","",0,2,NULL,c).psep;
					printf(" %s reconnu\n",yytext);Col= Col + strlen(yytext); 
				  }
{IDF}             { a = rechercher(yytext,"idf","",0,0,a,NULL).pidf;
					if (yyleng>8){printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",nb_ligne,Col);
							}
							else {printf(" IDF reconnu %s \n",yytext);Col= Col + strlen(yytext); 
							}
					}
{commentaire} 		{ printf(" Commentaire reconnu :%s\n",yytext);}
[ \t] Col=Col+strlen(yytext);
\n 	{ nb_ligne++;Col=1; }
. printf("Erreur lexicale ligne %d a la colonne %d sur l'entite %s\n",nb_ligne,Col,yytext);

%%
main(){	


 	yylex();
 afficher(b,c,a);

}
