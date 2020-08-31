%{
    let contador = 0;

    function new_temp(){
        contador++;
        cadena = "t"+contador;
        return cadena;
    }
%}

%lex
%options case-insensitive
id ([a-zA-Z_])[a-zA-Z0-9_]*
%%

\s+                   /* skip whitespace */
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"("                   return '('
")"                   return ')'
{id}                  return 'id'
<<EOF>>		          return 'EOF'

/lex

%start S

%%

S 
    : E EOF
    {
        console.log($1.c3d);
    }
;

E    
    : E '+' T
    {
        tmp = new_temp();
        c3d = $1.c3d + $3.c3d + tmp + "=" + $1.tmp + "+" + $3.tmp + '\n';
        //console.log('retornando de E->E+T: tmp:'+tmp+', c3d:'+c3d);
        $$ = {tmp:tmp, c3d:c3d}
    }
    | E '-' T
    {
        tmp = new_temp();
        c3d = $1.c3d + $3.c3d + tmp + "=" + $1.tmp + "-" + $3.tmp + '\n';
        //console.log('retornando de E->E+T: tmp:'+tmp+', c3d:'+c3d);
        $$ = {tmp:tmp, c3d:c3d}
    }
    | T
    {
        //console.log('retornando de E->T: tmp:'+$1.tmp+', c3d:'+$1.c3d);
        $$ = $1;
    }
;

T
    : T '*' F
    {
        tmp = new_temp();
        c3d = $1.c3d + $3.c3d + tmp + "=" + $1.tmp + "*" + $3.tmp + '\n';
        //console.log('retornando de E->E+T: tmp:'+tmp+', c3d:'+c3d);
        $$ = {tmp:tmp, c3d:c3d}
    }
    | T '/' F
    {
        tmp = new_temp();
        c3d = $1.c3d + $3.c3d + tmp + "=" + $1.tmp + "/" + $3.tmp + '\n';
        //console.log('retornando de E->E+T: tmp:'+tmp+', c3d:'+c3d);
        $$ = {tmp:tmp, c3d:c3d};
    }
    | F
    {
        //console.log('retornando de T->F: tmp:'+$1.tmp+', c3d:'+$1.c3d);
        $$ = $1;
    }
;

F   : '(' E ')'
    { 
        //console.log('retornando de F->(E): '+$2);
        $$ = $2;
    }
    | id
    { 
        //console.log('retornando de F->id: '+$1);
        $$ = {tmp : $1, c3d : ""};
    }
;
