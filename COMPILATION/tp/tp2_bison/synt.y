
%{
 int nb_ligne=1, col=1;	
%}
%token mc_code mc_start mc_end IDF err
%start S

%%
S: mc_code IDF mc_start mc_end {printf("prog syntaxiquement correct");YYACCEPT;}


%%
main()
{
yyparse();
}
yywrap()
{}
