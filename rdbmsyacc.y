%{
	#include <stdio.h>
	#include <string.h>
	int yylex(void);

typedef struct sql_stmt {
	char * proj_list[10];
	char * from_list[10];
	int pcount;
	int fcount;
} sql_stmt1; 

void addtoProjList(char *obj);
void addtoFromList(char *obj);
void printList();

%}

%union 
{
	char *stringval;
}

%token <stringval> TOK_SELECT 
%token <stringval> TOK_FROM 
%token <stringval> OBJ

%left TOK_SEMICOLON TOK_COMMA

%%

statement: TOK_SELECT select_list TOK_FROM from_list TOK_SEMICOLON
		{ 	printList();
		 }
		;

select_list: select_list TOK_COMMA OBJ  { addtoProjList($3); }
		| OBJ 			{ addtoProjList($1); }
		;

from_list: from_list TOK_COMMA OBJ { addtoFromList($3); }
		  | OBJ   		 { addtoFromList($1); }
		  ;

%%

yyerror(s)
char *s;
{
 fprintf(stderr, "%s\n", s);
  return 0;
}

int main(void) {
	//struct sql_stmt sql_stmt1;
	yyparse();
	return 0;
}

void addtoProjList(char *obj){
	sql_stmt1 = malloc(sizeof(sql_stmt));
	sql_stmt1.proj_list[pcount] = (char *)malloc(strlen(obj*)*sizeof(char));
	strcpy(sql_stmt1.proj_list[pcount], obj);
	pcount++;
}

void addtoFromList(char *obj){
	sql_stmt1.from_list[fcount] = (char *)malloc(strlen(obj*)*sizeof(char));
	strcpy(sql_stmt1.from_list[fcount], obj);
	fcount++;
}

void printList(){
	int i = 0;
	printf("Objects in SQL statement: \n");
	printf("Projection List: ");
	for(i = 0; i < sql_stmt1.pcount; ++i){
		printf("%s\t", sql_stmt1.proj_list[i]);
	}

	printf("\n");
	printf("From List: ");
	for(i = 0; i < sql_stmt1.fcount; ++i){
		printf("%s\t", sql_stmt1.from_list[i]);
	}
	printf("\n");
}
