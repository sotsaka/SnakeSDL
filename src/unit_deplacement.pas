unit unit_deplacement;

interface

uses keyboard, crt, unit_types, unit_creation,unit_sdl,sdl, sdl_image,sdl_ttf;

procedure deplacement(var tab : Tableau2D; var tabdirection : tableaudirection; var snake : tableau_snake; var obstacle : tableau_obstacle; var direction : string; var perdu,echap : boolean; var taille_snake, pommes_mangees, pommesdorees_mangees, obstacles_rencontres,nbre_obstacle,vitesse_init : integer; var casesParcourues : Longint; var pomme,pommedoree : coordonnee; var difficulte : integer; var pommedodovf,murgold : Boolean);
procedure lignedroite(var tab : Tableau2D; var tabdirection : tableaudirection ; direction : string; var snake : tableau_snake; var obstacle : tableau_obstacle; var taille_snake,pommes_mangees,pommesdorees_mangees,obstacles_rencontres,nbre_obstacle : integer; var casesParcourues : Longint; var pomme,pommedoree : coordonnee; var perdu : boolean;var difficulte,vitesse_init : integer; var pommedodovf,murgold : Boolean; ms : integer);
procedure changementDirection(k_string : string; var direction : string );
procedure rencontrer_pomme(var tab : Tableau2D; var tabdirection : tableaudirection; var snake : tableau_snake; var obstacle : tableau_obstacle; var direction : string; var pomme : coordonnee; var taille_snake,nbre_obstacle,pommes_mangees, pommesdorees_mangees, obstacles_rencontres : Integer; mem_queue : coordonnee; symbole : string;var difficulte : integer);
procedure rencontrer_obstacle(var tab : Tableau2D; var tabdirection : tableaudirection; var snake : tableau_snake; var obstacle : tableau_obstacle; var taille_snake,pommes_mangees, pommesdorees_mangees, obstacles_rencontres,nbre_obstacle: integer; symbole : string; var perdu : boolean;var difficulte : integer) ;
procedure rencontrer_snake(var perdu : boolean) ;
procedure rencontrer_mur(var perdu : boolean) ;
procedure rencontrer_pommedoree(var tab : Tableau2D; var snake : tableau_snake; var pommedoree : coordonnee; var pommes_mangees,pommesdorees_mangees,obstacles_rencontres, difficulte,vitesse_init : integer; var casesParcourues : Longint; var pommedodovf,murgold : boolean);
function directionValide(k_string,direction : string) : boolean;
function score(pommes_mangees,pommesdorees_mangees, obstacles_rencontres : Integer) : LongInt;


implementation

procedure deplacement(var tab : Tableau2D; var tabdirection : tableaudirection; var snake : tableau_snake; var obstacle : tableau_obstacle; var direction : string; var perdu,echap : boolean; var taille_snake, pommes_mangees,pommesdorees_mangees, obstacles_rencontres,nbre_obstacle,vitesse_init : integer; var casesParcourues : Longint; var pomme,pommedoree : coordonnee; var difficulte : integer; var pommedodovf,murgold : Boolean);
var key : psdl_event;
	ms : integer;
	k_string : string;
	positio : tsdl_rect;
begin 
	if pommes_mangees>=0 then
						ms:=vitesse_init;
					if pommes_mangees>=10 then
						ms:=(vitesse_init*3) div 4;
					if pommes_mangees>=20 then
						ms:=vitesse_init div 2;
					if pommes_mangees>=30 then
						ms:=vitesse_init div 4;
	
	if (casesParcourues>0)and(pommedodovf = false)and(CasesParcourues mod ((vitesse_initiale div ms)*100) = 0) then			{une fois toute les 100 cases la pomme doree apparait}
	begin
		creationpomme(tab,pommedoree,difficulte,'doree');
		afficher_pomme_gold(pommedoree.x,pommedoree.y);
		pommedodovf :=true;
		casesParcourues:=0;
	end;
	if (pommedodovf=true)and(casesParcourues=75) then
	begin
		casesParcourues:=0;
		pommedodovf:=false;
		tab[x(pommedoree),y(pommedoree)]:='vide';
		noir(pommedoree.x,pommedoree.y);
	end;
	
	indicegif := indicegif +1; if indicegif=11 then indicegif:=1;

	positio.x:=difficulte*3*height+10;
	positio.y:=100;
	sdl_blitsurface(tabgif[indicegif],nil,window,@positio );
	new(key);	
		IF SDL_POLLEVENT(key)=1 THEN
			begin
				case  key^.type_  of
		
				SDL_KEYDOWN :	begin
								ms:=0;
								case key^.key.keysym.sym of
									273 : k_string:='Up';
									274 : k_string:='Down';
									275 : k_string:='Right';
									276 : k_string:='Left';
								end;
							
							
							
								if ((k_string='Left') or (k_string='Right') or (k_string='Up') or (k_string='Down'))and(directionValide(k_string,direction)) then
									changementDirection(k_string,direction);
								if key^.key.keysym.sym = 27 then
									echap:=true;
								end;
								
								
			{SDL_MOUSEMOTION: ;}
								
			{SDL_KEYUP: ;}
			
			{SDL_MOUSEBUTTONDOWN:;
			SDL_MOUSEBUTTONUP: ;}
					
			end;
				
			
		end;
		
		
		
		
		
		IF SDL_POLLEVENT(key)<>1 THEN
				begin
					if pommes_mangees>=0 then
						ms:=vitesse_init;
					if pommes_mangees>=10 then
						ms:=(vitesse_init*3) div 4;
					if pommes_mangees>=20 then
						ms:=vitesse_init div 2;
					if pommes_mangees>=30 then
						ms:=vitesse_init div 4;
				lignedroite(tab,tabdirection,direction ,snake,obstacle,taille_snake,pommes_mangees,pommesdorees_mangees, obstacles_rencontres,nbre_obstacle,casesParcourues,pomme,pommedoree,perdu,difficulte,vitesse_init,pommedodovf,murgold,ms);
					
				delay(ms);
				dispose(key);
				end
				else
				begin
					
				end;
	{283=échap}


end;


procedure lignedroite(var tab : Tableau2D; var tabdirection : tableaudirection; direction : string; var snake : tableau_snake; var obstacle : tableau_obstacle; var taille_snake, pommes_mangees, pommesdorees_mangees, obstacles_rencontres,nbre_obstacle : integer; var casesParcourues : Longint; var pomme,pommedoree : coordonnee; var perdu : boolean;var difficulte,vitesse_init : integer; var pommedodovf,murgold : Boolean; ms : integer);
var indice_x,indice_y,i,j,k,l : Integer;
	symbole,cQueLaTeteRencontre : string;
	mem_queue : coordonnee;
	xtete,ytete,xvide,yvide,xqueue,yqueue,xcorp,ycorp : integer;
begin
	case direction of
		'Right': begin indice_x:=1; indice_y:=0; symbole:='>' end;
		'Left' : begin indice_x:=-1; indice_y:=0; symbole:='<' end;
		'Up'   : begin indice_x:=0; indice_y:=-1; symbole:='^' end;
		'Down' : begin indice_x:=0; indice_y:=1; symbole:='v' end;
		end;
	{symbole:='=';}
	cQueLaTeteRencontre:=tab[x(snake[1])+indice_x,y(snake[1])+indice_y];			{snake[1] coordonnée de la snake[1] du snake}
	
	fixer_xy(mem_queue,x(snake[taille_snake]),y(snake[taille_snake]));				{stock les coordonnées de la queue       }     								
	
	tab[x(snake[1])+indice_x,y(snake[1])+indice_y]:=tab[x(snake[1]),y(snake[1])];
		
	tab[x(snake[1]),y(snake[1])]:='snake';
	xtete:=(x(snake[1])+indice_x);
	ytete:=y(snake[1])+indice_y;
	afficher_tete(xtete,ytete,direction);
		
	tab[x(snake[taille_snake]),y(snake[taille_snake])]:='vide';
	xvide:=x(snake[taille_snake]);
	yvide:=y(snake[taille_snake]);
	noir(xvide,yvide);

	if taille_snake >2 then
		begin
		xcorp :=x(snake[1]);
		ycorp :=y(snake[1]);
		afficher_corp(xcorp,ycorp,direction,tabdirection[1]);
		end;
	
	tab[x(snake[taille_snake-1]),y(snake[taille_snake-1])]:='snake';  				{snake[taille_snake] correspond aux coordonnées de la queue}
	xqueue:=x(snake[taille_snake-1]);
	yqueue:=y(snake[taille_snake-1]);
	if taille_snake>2 then	
		afficher_queue(xqueue,yqueue,tabdirection[taille_snake-2]);
	
	
	if taille_snake > 1 then
		for i:=taille_snake downto 2 do						{le serpent bouge, le snake bouge aussi, tout est décalé de 1}
		begin
			fixer_xy(snake[i],x(snake[i-1]),y(snake[i-1]));
			tabdirection[i]:=tabdirection[i-1];
		end;
		fixer_xy(snake[1] ,x(snake[1])+indice_x, y(snake[1])+indice_y);
		tabdirection[1]:=direction;
		
	if taille_snake =2 then
		afficher_queue(xqueue,yqueue,tabdirection[1]);
	
	if (murgold=true)and(CasesParcourues mod ((vitesse_initiale div ms)*55) = 0) then
	begin
		for i:=1 to longueur do
		for j:=1 to largeur do
		begin
		k:=i;l:=j; { obligation de faire ce changement de variable sinon -> erreur de compilation (for-loop)}
		if tab[i,j] = 'mur' then
			afficher_mur(k,l);
		end;
		murgold:=false;
		vitesse_init:=vitesse_initiale;
	end;
		
		case cQueLaTeteRencontre of				
			'pomme' : rencontrer_pomme(tab,tabdirection,snake,obstacle,direction,pomme,taille_snake,nbre_obstacle,pommes_mangees,pommesdorees_mangees, obstacles_rencontres,mem_queue,symbole,difficulte);
			'obstacle' : rencontrer_obstacle(tab,tabdirection,snake,obstacle,taille_snake,pommes_mangees,pommesdorees_mangees, obstacles_rencontres,nbre_obstacle,symbole,perdu,difficulte);
			'snake' : begin rencontrer_snake(perdu); xtete:=x(snake[1]); ytete:=y(snake[1]); afficher_tete(xtete,ytete,direction); end;
			'mur' : rencontrer_mur(perdu);
			'pommedoree' : rencontrer_pommedoree(tab,snake,pommedoree,pommes_mangees,pommesdorees_mangees,obstacles_rencontres, difficulte,vitesse_init,casesParcourues,pommedodovf,murgold);
		end;
end;
	
procedure changementDirection(k_string : string; var direction : string );
begin
	direction := k_string;
end;

function score(pommes_mangees,pommesdorees_mangees, obstacles_rencontres : Integer) : LongInt;

begin
	score := pommes_mangees * 10 - obstacles_rencontres * 10 + 100*pommesdorees_mangees;		
end;


procedure rencontrer_pommedoree(var tab : Tableau2D; var snake : tableau_snake; var pommedoree : coordonnee; var pommes_mangees,pommesdorees_mangees,obstacles_rencontres, difficulte,vitesse_init : integer; var casesParcourues : Longint; var pommedodovf,murgold : boolean);
var i,j,k,l : integer;
	scor : LongInt;
begin
	vitesse_init := vitesse_init*3 div 5;
	pommesdorees_mangees := pommesdorees_mangees + 1;
	scor := score(pommes_mangees, pommesdorees_mangees, obstacles_rencontres);
	afficher_score(scor,difficulte);
	casesParcourues := 0;
	pommedodovf := false;
	for i:=1 to longueur do
	for j:=1 to largeur do
	begin
	k:=i;l:=j; { obligation de faire ce changement de variable sinon -> erreur de compilation (for-loop)}
	if tab[i,j] = 'mur' then
		afficher_mur_gold(k,l);		
	end;
	murgold:=true;
	
end;

procedure rencontrer_pomme(var tab : Tableau2D; var tabdirection : tableaudirection; var snake : tableau_snake; var obstacle : tableau_obstacle; var direction : string; var pomme : coordonnee; var taille_snake, nbre_obstacle, pommes_mangees, pommesdorees_mangees, obstacles_rencontres : Integer; mem_queue : coordonnee; symbole : string; var difficulte : integer);
var	coord : coordonnee;
	scor : Longint;
	xx,yy,xxx,yyy,resultat,i : integer;
begin
	pommes_mangees := pommes_mangees + 1;
	taille_snake:=taille_snake+1;
	fixer_xy(snake[taille_snake], x(mem_queue), y(mem_queue));
	
		tab[x(snake[taille_snake]),y(snake[taille_snake])]:='snake';
		
		xx:=x(snake[taille_snake]);
		yy:=y(snake[taille_snake]); 	{pour l'affichage}
			tabdirection[taille_snake]:=tabdirection[taille_snake-1];
			afficher_queue(xx,yy,tabdirection[taille_snake]);
		xxx:=x(snake[taille_snake-1]);
		yyy:=y(snake[taille_snake-1]);
			afficher_corp(xxx,yyy,tabdirection[taille_snake-2],tabdirection[taille_snake-1]);
		
	creationpomme(tab,pomme,difficulte,'normale');
	afficher_pomme(pomme.x,pomme.y);
	if (pommes_mangees mod 5 = 0) then
	begin
		resultat := pommes_mangees div 5;
		for i:=1 to resultat do
		begin
			creationObstacle(tab,obstacle,nbre_obstacle,coord, difficulte);
			afficher_obstacle(coord.x,coord.y);
		end;
	end;
	scor := score(pommes_mangees, pommesdorees_mangees, obstacles_rencontres);
	afficher_score(scor,difficulte);
end;

procedure rencontrer_obstacle(var tab : Tableau2D; var tabdirection : tableaudirection; var snake : tableau_snake; var obstacle : tableau_obstacle; var taille_snake, pommes_mangees, pommesdorees_mangees, obstacles_rencontres,nbre_obstacle : Integer; symbole : string; var perdu : boolean;var difficulte : integer) ;
var i,indice : integer;
	scor : LongInt;
	xtete,ytete,xvide,yvide : integer;
begin
	obstacles_rencontres := obstacles_rencontres + 1;
	if taille_snake=1 then
	begin
		perdu:=true;
		xtete:=x(snake[1]);
		ytete:=y(snake[1]);
		afficher_obstacle(xtete,ytete);
	end
	else
	begin
			tab[x(snake[taille_snake]),y(snake[taille_snake])]:='vide';
			xvide:=x(snake[taille_snake]);
			yvide:=y(snake[taille_snake]);
			noir(xvide,yvide);
		fixer_xy(snake[taille_snake], 0, 0);
		tabdirection[taille_snake]:='noDirection';
		taille_snake:=taille_snake-1;
		for i:=1 to nbre_obstacle do
		begin
			if (x(snake[1])=x(obstacle[i]))and(y(snake[1])=y(obstacle[i])) then
				indice:=i;
		end;
		for i:=indice to nbre_obstacle do
		begin
			fixer_xy(obstacle[i],x(obstacle[i+1]),y(obstacle[i+1]));
		end;
		fixer_xy(obstacle[nbre_obstacle],0,0);
		nbre_obstacle:=nbre_obstacle-1;
	end;
	scor := score(pommes_mangees,pommesdorees_mangees, obstacles_rencontres);
	afficher_score(scor,difficulte);
end;

procedure rencontrer_snake(var perdu : boolean);
begin
	perdu:=true;
end;

procedure rencontrer_mur(var perdu : boolean) ;
begin
	perdu:=true;
end;

function directionValide(k_string,direction : string) : boolean;
var bool : boolean;
begin
	bool:=true;
	case direction of
		'Up' : if k_string= 'Down' then bool:=false;
		'Down' : if k_string= 'Up' then bool:=false;
		'Right' : if k_string='Left' then bool:=false;
		'Left' : if k_string='Right' then bool:=false;
	end;
	directionValide:=bool;
end;

end.
