%{
 extern int yylineo; 
 int col=1; //declaraction du cpt de nombre de colonne
 extern a;
 extern b;
 extern c; 
 //dec pour quad
 char tmp[20],tmpElse[20],tmpdb[20];
 extern Fin_if,Fin_for1,Fin_for2,debut_for,deb_else,Fin_while;
 extern p;//qc = indice qui indique sur quel quadruplet on est
 extern qc;
 extern pos;
 char *val;
 int po;

%}
%union {
int entier;
char* str;
float reel;


}

%type <str> OPERATEUR OP_COMPARAISON SUIT EXPRESSION LIST_IDF CST ELSE DEC_TAB



%start S

%token <str>nbrentier <str>nbrreel <str>cstbool <str>IDF mc_entier mc_reel mc_cara mc_bool mc_and mc_or mc_not mc_aff mc_if <str>mc_else mc_for mc_range 
 mc_in mc_while mc_parouv mc_parfer mc_acouv mc_acfer <str>mc_dpoint mc_plus mc_moins mc_mul mc_div mc_inf mc_inrange
 mc_infeq mc_sup mc_supeq mc_dif <str>mc_equal vg sdl tabul cstchar spt gi err sptt
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
LIST_IDF : vg IDF LIST_IDF
         | mc_aff CST {
				 qc = quadr("=",$2,"vide",$$);
            }
         | 
;
DEC_TAB : TYPE spt IDF mc_acouv nbrentier mc_acfer sdl{
       
	     qc = quadr("ADEC","0",$5,$3);
     	}
;
TYPE :mc_entier
     |mc_reel
     |mc_cara
     |mc_bool
;
CST :nbrentier 
    |nbrreel 
    |cstbool 
    |cstchar
	|IDF mc_acouv CST mc_acfer
	
;  
LIST_INST :INST LIST_INST
            | 
;
INST : INST_AFF
      |INST_IF
      |INST_FORA
      |INST_FORB
      |INST_WHILE
; 
INST_AFF :IDF mc_aff EXPRESSION sdl{
                    qc = quadr("=",$3,"vide",$1);
					
}
;
EXPRESSION : EXPRESSION OPERATEUR SUIT { 
					qc = quadr($2,$1,$3,"tmp"); 
					strcpy($$, "tmp");
 
}
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
INST_IF : A ELSE { 	
				   //si else existe
					ajour_quad(deb_else,1,tmpElse);
					po = pos + 1;
					sprintf(tmp,"%d",po); 
					ajour_quad(Fin_if,1,tmp);
                
}
;
A : B mc_dpoint sdl SUIT_INST{
						
				
				qc = quadr("BR","","vide","vide");//la fin jsnp ou elle est 
				Fin_if = qc;
				po = pos+1;
				sprintf(tmp,"%d",po); 
				sprintf(tmpElse,"%d",po);
				ajour_quad(Fin_if,1,tmp);



}
;
B : mc_if mc_parouv CONDITION mc_parfer{
				
			    qc = quadr("BZ","","tmp","vide");//jnsp si ilya le else 
				deb_else = qc;
				Fin_if = qc;
				
}
;
INST_FORA : FORA sdl SUIT_INST {
						   qc = quadr("BR","","vide","vide");
						   qc = ajour_quad(qc,1,tmpdb);
						   po = pos+1;
						   sprintf(tmp,"%d",po); 
                           qc = ajour_quad(Fin_for1,1,tmp);
						   qc = ajour_quad(Fin_for2,1,tmp);


						   
}
;
FORA : mc_for spt IDF spt mc_inrange mc_parouv nbrentier vg nbrentier mc_parfer mc_dpoint{
							    qc = quadr("=",$7,"vide",$3);
								qc = quadr("<",$3,$9,"tmp");
								sprintf(tmpdb,"%d",pos); //indice du debut de la condition du for
								qc = quadr("BZ","","vide","vide");
								Fin_for1 = qc;
								qc = quadr(">",$3,$7,"tmp");
								qc = quadr("BZ","","vide","vide");
								Fin_for2 = qc;

								
}
;
INST_FORB : mc_for spt IDF spt mc_in spt IDF mc_dpoint sdl SUIT_INST;
INST_WHILE : WHILEA sdl SUIT_INST{
				qc = quadr("BR","","vide","vide");
				qc = ajour_quad(qc,1,tmpdb);
				po=pos+1;
				sprintf(tmp,"%d",po); 
				qc = ajour_quad(Fin_while,1,tmp);
}                           
;
WHILEA : mc_while mc_parouv CONDITION mc_parfer mc_dpoint{
				 sprintf(tmpdb,"%d",pos); //indice du debut de while
            	 qc = quadr("BZ","","vide","vide");
				 Fin_while = qc;	     
};

SUIT_INST: sptt INST SUIT_INST
          |sptt INST
;
ELSE : mc_else mc_dpoint sdl SUIT_INST
       |
;
CONDITION : EXPRESSION spt OP_COMPARAISON spt EXPRESSION 
           | mc_not EXPRESSION
           |EXPRESSION OP_COMPARAISON EXPRESSION{	
             	    qc = quadr($2,$1,$3,"tmp");
}
OP_COMPARAISON : mc_inf 
                | mc_infeq 
                | mc_sup 
                | mc_supeq 
                | mc_equal 
                | mc_dif 
                | mc_or 
                | mc_and 


%%
main ()
{
   yyparse(); 
  
  afficher(b,c,a);
  afficher_qdr(p);
 }
 yywrap ()
 {}
int yyerror (char *msg ) { 
        printf ("Erreur syntaxique, ligne %d, colonne %d \n",yylineo,col); 
        return 1; }

 
