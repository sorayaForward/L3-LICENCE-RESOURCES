%{
    extern int yylineo; 
    int Col=1; //declaraction du cpt de nombre de colonne
%}

%token mc_deb mc_entier mc_reel mc_str addition mc_var eg mc_const idf cstint  
      dpts aff  mult acco mc_fin crov crfm fin divi add vg pv pt
%start S
%%
S :  mc_deb pt LIST_DEC LIST_INST  mc_fin pt
   { printf(" Le programme est correcte syntaxiquement"); YYACCEPT; }
;

LIST_DEC: DEC LIST_DEC
		 |;
	
DEC: DEC_VAR
	|DEC_CONST
	|DEC_TAB;
	
DEC_VAR:  TYPE idf LIST_IDF pv
;
	
LIST_IDF: vg idf LIST_IDF 
        | 
;	

DEC_TAB: TYPE idf "[" cstint "]" pv;
	
		
DEC_CONST: mc_const TYPE  LIST_IDF_CST pv 
;

LIST_IDF_CST : idf aff cstint vg  LIST_IDF_CST
              | idf aff cstint
;
		
TYPE:  mc_entier
      |mc_reel
;	  
LIST_INST: INST_AFF LIST_INST                  
         |                     
;		                                  

INST_AFF : idf aff EXPRESSION pv
;

EXPRESSION: idf 
          | cstint
	    | idf "[" cstint "]"
	    | idf  OP cstint	      
;

OP: add | divi;

%%
main ()
{
   initialisation();
   yyparse(); 
   afficher();
 }
 yywrap ()
 {}
int yyerror (char *msg ) { 
        printf ("Erreur syntaxique, ligne %d, colonne %d \n",yylineo,Col); 
        return 1; }
 
 