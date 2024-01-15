%{
//hadouma pour les quadruplets
int deb_else=0;
int qc=0;
int Fin_if=0;
char tmp [20];
char *sauvType;

extern int yylineo; 
int col=1; //declaraction du cpt de nombre de colonne
extern a;
extern b;
extern c; 
extern d;
%}

%union { //its the YYSTYPE
int entier;
char* str;//str ="hello"
float reel;
}

%token <entier>nbrentier <reel>nbrreel cstbool <str>IDF <str>mc_entier <str>mc_reel <str>mc_cara <str>mc_bool mc_and mc_or mc_not mc_aff mc_if mc_else mc_for mc_range mc_in mc_while mc_parouv mc_parfer mc_acouv mc_acfer mc_dpoint mc_plus mc_moins mc_mul mc_div mc_inf mc_inrange mc_infeq mc_sup mc_supeq mc_dif mc_equal vg sdl tabul slet err gi cstchar spt sptt
  

%right mc_aff 
%left mc_inf mc_infeq mc_sup mc_supeq mc_equal mc_dif
%left mc_plus mc_moins
%left mc_mul mc_div
%%
S :LIST_DEC LIST_INST
{ printf("Le prgramme est correcte syntaxiquement"); YYACCEPT;}
;
LIST_DEC :DEC LIST_DEC
          | 
;        
DEC :DEC_VAR
    |DEC_TAB
;
DEC_VAR : TYPE spt IDF LIST_IDF sdl
;
LIST_IDF :vg IDF LIST_IDF
         |mc_aff CST
         | 
;
DEC_TAB : TYPE spt IDF mc_acouv nbrentier mc_acfer sdl
;
TYPE : mc_entier
     | mc_reel
     | mc_cara
     | mc_bool
;
CST :nbrentier
    |nbrreel
    |cstbool
    |gi cstchar gi
;  
LIST_INST :INST LIST_INST
            | 
;
INST : INST_AFF
      |INST_IF
      |INST_FORA
      |INST_FORB
      |INST_WHILE; 
INST_AFF :IDF mc_aff EXPRESSION sdl
;
EXPRESSION : EXPRESSION OPERATEUR SUIT
            |SUIT
;
SUIT : IDF
     | CST
     | mc_parouv EXPRESSION mc_parfer
;
OPERATEUR :mc_plus
          |mc_moins
          |mc_mul
          |mc_div
;    
INST_IF : mc_if mc_parouv CONDITION mc_parfer mc_dpoint sdl SUIT_INST ELSE;
INST_FORA : mc_for spt IDF spt mc_inrange mc_parouv nbrentier vg nbrentier mc_parfer mc_dpoint sdl SUIT_INST
;
INST_FORB : mc_for spt IDF spt mc_in spt IDF mc_dpoint sdl SUIT_INST;
INST_WHILE : mc_while mc_parouv CONDITION mc_parfer mc_dpoint sdl SUIT_INST;
SUIT_INST: sptt INST SUIT_INST
          |sptt INST
;
ELSE : mc_else mc_dpoint sdl SUIT_INST
       |
;
CONDITION : EXPRESSION spt OP_COMPARAISON spt EXPRESSION
           | mc_not EXPRESSION
           |EXPRESSION OP_COMPARAISON EXPRESSION;
OP_COMPARAISON : mc_inf
                | mc_infeq
                | mc_sup
                | mc_supeq
                | mc_equal
                | mc_dif
                |mc_or
                |mc_and;
%%
main ()
{   
    yyparse();
    afficher(b,c,a);
	//afficher_qdr();

 }
 yywrap ()
 {}
int yyerror (char *msg ) { 
        printf ("Erreur syntaxique, ligne %d, colonne %d \n",yylineo,col); 
        return 1; }
 
 