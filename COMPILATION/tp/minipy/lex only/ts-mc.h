/****************CREATION DE LA TABLE DES SYMBOLES ******************/
/***Step 1: Definition des structures de données ***/
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
typedef struct ts_tdf
{
   int state;
   char name[20];
   char code[20];
   char type[20];
   float val;
   struct ts_tdf *suiv;
 } idf; //data type : struct ts_idf == idf 


typedef struct ts_mcs
{ 
   int state; 
   char name[20];
   char type[20];   
   struct ts_mcs *suiv;
} mc,sep,both;

/***Step 2: creation des listes des symbloles***/

// liste des mc
mc* creationCellule_mc(mc *t){
	 t=malloc(sizeof(mc));
	(t)->suiv=NULL;
	return t;
};

/***Step 4: insertion des entititées lexicales dans les tables des symboles ***/

both* inserer (char entite[], char code[],char type[],float val,both *p,idf *t,int y)
{ 	

		if(p == NULL){
			p = creationCellule_mc(p);
		}
       p->state=1;
       strcpy(p->name,entite);
       strcpy(p->type,code);
	   printf("incerer\n");
	   return p;

 

}


/***Step 3: La fonction Rechercher permet de verifier  si l'entité existe dèja dans la liste des symboles */
both* rechercher (char entite[], char code[],char type[],float val,int y,idf *t,both *p)	
{
both *p1,*p2;
int boo = 1;

p1=p;
       /*Chercher si entite existe dans tabm: si non on appelle la fonction inserer*/
	if(p!=NULL){
		p2 = p->suiv;
			   while(p1!=NULL){
				   if(strcmp(entite,p1->name)==0) { 
						printf("Entite %s existe deja\n",entite);
						boo = 0;
						p1 = NULL;
				   }
				   else {
				   if(p2==NULL) {p1->suiv = inserer(entite,code,type,val,p2,NULL,0); boo = 0;}
					else {p2=p2->suiv;}
					p1=p1->suiv;
				   }
			   }
				   if(p->suiv == NULL){
					   if(boo == 1)
					   p->suiv = inserer(entite,code,type,val,p1,NULL,0);
				   }else{
						   if( boo == 1 ) p1= inserer(entite,code,type,val,p2,NULL,0);
					   }       
	}else{
		p = inserer(entite,code,type,val,p,NULL,0);
	}
					
	 return p;

}


/***Step 5 L'affichage du contenue de la table des symboles ***/

void afficher(mc *p,sep *y,idf *t)
{
	both *t2;
	t2=p;
	printf("\n/***************Table des symboles mots cles*************/\n");

	printf("_____________________________________\n");
	printf("\t| NomEntite |  CodeEntite | \n");
	printf("_____________________________________\n");


	while(t2 != NULL){	//mc
		if(t2->state==1)
		  { 
			printf("\t|%10s |%12s | \n",t2->name, t2->type);
				   
		  }
		t2=t2->suiv;
	}
	free(t2);



}
