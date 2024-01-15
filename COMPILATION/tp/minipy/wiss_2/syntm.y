%{
 #include<stdio.h>
 #include<stdlib.h>
 #include<string.h>
 extern int yylineo; 
 int col=1; //declaraction du cpt de nombre de colonne
 char souvtype[20];
 char valeur[20];
 int typ;
 extern a;
 extern b;
 extern c; 
%}
%start S
%token nbrentier nbrreel cstbool IDF <str>mc_entier <str>mc_reel <str>mc_char <str>mc_bool mc_and mc_or mc_not mc_aff mc_if mc_else mc_for mc_range 
 mc_in mc_while mc_parouv mc_parfer mc_acouv mc_acfer mc_dpoint mc_plus mc_moins mc_mul mc_div mc_inf mc_inrange
 mc_infeq mc_sup mc_supeq mc_dif mc_equal  vg sdl tabul cstchar spt gi err sptt
%union {
int entier; 
float reel; 
char *str;
struct{
  int type;
  char *ctx;
  float v;
}tt;
}
%type<str> nbrentier nbrreel cstbool IDF
%type<entier> TYPE
%type<tt> EXPRESSION CST CONDITION 

%left mc_or
%left mc_and
%left mc_not
%left mc_inf mc_infeq mc_sup mc_supeq mc_equal mc_dif
%left mc_plus mc_moins
%left mc_mul mc_div
%left mc_parouv mc_parfer

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
DEC_VAR : TYPE spt IDF LIST_IDF sdl {if(doubleDeclaration($3,a)==0){printf("entite non declarer\n"); insererTYPE($3,souvtype,a); 
                        if($1==0 && typ==2){printf("valeur fausse erreur semantique dans la ligne %d\n",yylineo);return 0;}
                        insererValeur($3,a,valeur); 
                             }
                           else{printf("erreur semantique double declaration %s la ligne %d\n", $3,yylineo);}}                 
; 

LIST_IDF :vg IDF LIST_IDF {if(doubleDeclaration($2,a)==0) {printf("entite non declarer\n"); insererTYPE($2,souvtype,a); }
                           else{printf("erreur semantique double declaration %s la ligne %d\n", $2,yylineo);}}                     
         |mc_aff CST 
         |
;
DEC_TAB : TYPE spt IDF mc_acouv nbrentier mc_acfer sdl {if(doubleDeclaration($3,a)==0) {printf("entite non declarer\n"); insererTYPE($3,souvtype,a); }
                           else{printf("erreur semantique double declaration %s la ligne %d\n", $3,yylineo);}}
;
TYPE : mc_entier {strcpy(souvtype,$1);$$=0;}
     | mc_reel{strcpy(souvtype,$1);$$=2;}
     | mc_char{strcpy(souvtype,$1);$$=1;}
     | mc_bool{strcpy(souvtype,$1); $$=3;}
;
CST :nbrentier { strcpy(valeur,$1);typ=0; $$.type =0; $$.v=atof($1);}
    |nbrreel {strcpy(valeur,$1); typ=2;$$.type =2; $$.v=atof($1);}
    |cstbool {$$.type =3;printf($$.ctx,"%c",$1);$$.v=1;}
    |cstchar {$$.type =1;sprintf($$.ctx,"%c",$1[1]);$$.v=1;}
;  
LIST_INST :INST LIST_INST
            | 
;
INST : INST_AFF
      |INST_IF
      |INST_FORA
      |INST_FORB
      |INST_WHILE; 
INST_AFF :IDF mc_aff EXPRESSION sdl  {
        if(recherche($1,a)==-1) {printf("entite non declarer dans la ligne %d ,erreur semantique\n",yylineo); return 0; 
        }else{
        int t;
         t= gettype($1,a);
        if(compatibletype(t,$3.type)!=0)
        {
          printf("Incpmpatibilite des types dans la ligne %d et la colonne %d\n",yylineo,col);
           return 0;
        }
        }}
        |IDF mc_acouv nbrentier mc_acfer mc_aff EXPRESSION sdl { if(recherche($1,a)==-1)
                                         {
                                           printf("variable non declaré erreur semantique\n"); return 0;
                                        } else
                                       {
                                          int t = gettype($1,a);
                                          if(compatibletype(t,$6.type)!=0 )
                                          {
                                            printf("Incpmpatibilite des types dans la ligne %d \n",yylineo);
                                       return 0;
                                         }
                                    }
    }

;
EXPRESSION : EXPRESSION mc_plus EXPRESSION {if($1.type==2 || $3.type==2)
                                              {$$.type=2;}
                                            else  $$.type=0;
                                                  $1.ctx=strdup($$.ctx);
                                                  $$.v=$1.v+$3.v;
                                          }
            |EXPRESSION mc_moins EXPRESSION {if($1.type==2 || $3.type==2)
                                          {$$.type=2;}
                                          else $$.type=0;
                                          $1.ctx=strdup($$.ctx);
                                          $$.v=$1.v-$3.v;               
                                          }
            |EXPRESSION mc_mul EXPRESSION {if($1.type==2 || $3.type==2)
                                          {$$.type=2;}
                                          else $$.type=0;
                                          $1.ctx=strdup($$.ctx);
                                          $$.v=$1.v*$3.v;
                
                                          }
            |EXPRESSION mc_div EXPRESSION  {if($3.v==0){printf("division par 0 erreur semantique\n"); return 0;
                                         }else{
                                          if($1.type==2 || $3.type==2)
                                          {$$.type=2;}
                                          else $$.type=0;
                                          $1.ctx=strdup($$.ctx);
                                          $$.v=$1.v/$3.v;               
                                          }}
            | IDF  {
                    if(recherche($1,a)==-1)
                    {
                      printf("variable non declaré la ligne %d et la colonne %d\n",yylineo,col); return 0;
                    }
                    else
                    {
                    
                        int k =gettype($1,a);
                        if(k!=2) 
                        k=0;
                        $$.ctx=$1;
                        $$.type=k;
                        $$.v=getval($1,a);  
                        printf("%f",$$.v);                 
                    }
                }
            | CST { if($1.type ==0 || $1.type ==2)
               {int k= $1.type;         
                   $1.ctx=strdup($$.ctx);
                    $$.type=k;
                    $$.v=$1.v;}
            }
            | mc_parouv EXPRESSION mc_parfer  { if($2.type ==0 || $2.type ==2)
                   {int k= $2.type;         
                  $2.ctx=strdup($$.ctx);
                    $$.type=k;
                    $$.v=$2.v;}
            }
            |IDF mc_acouv nbrentier mc_acfer  {if(recherche($1,a)==-1)
                                                        {
                                                          printf("variable non declaré \n"); return 0;
                                                        }
                                                      else
                                                      {
                                                         
                                                            int k = gettype($1,a);
                                                            if(k!=2) k=0;
                                                            $$.ctx=$1;
                                                            $$.type=k;
                                                            $$.v=getval($1,a);                                                          
                                                      }
                                                  }

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
CONDITION : EXPRESSION separation mc_inf separation EXPRESSION { $1.ctx=strdup($$.ctx); printf("%s\n",$$.ctx);}
           |EXPRESSION separation mc_infeq separation EXPRESSION { $1.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           |EXPRESSION separation mc_sup separation EXPRESSION { $1.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           |EXPRESSION separation mc_supeq separation EXPRESSION { $1.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           |EXPRESSION separation mc_equal separation EXPRESSION { $1.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           |EXPRESSION separation mc_dif separation EXPRESSION { $1.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           |EXPRESSION separation mc_or separation EXPRESSION{ $1.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           |EXPRESSION separation mc_and separation EXPRESSION { $1.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           |mc_not EXPRESSION { $2.ctx=strdup($$.ctx);printf("%s\n",$$.ctx);}
           ;
separation : spt
            |;

%%
main ()
{
   yyparse(); 
   afficher(b,c,a);
 }
 yywrap ()
 {}
int yyerror (char *msg ) { 
        printf ("Erreur syntaxique, ligne %d, colonne %d \n",yylineo,col); 
        return 1; }

 
