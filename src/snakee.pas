program snakee;

uses crt,keyboard, unit_types, unit_deplacement, unit_creation, unit_menu, unit_ranking, unit_sdl,sdl, sdl_image,sdl_ttf;


var exit : boolean;

procedure initmap(var tab : tableau2D; var pomme: coordonnee ; var obstacle : tableau_obstacle ; var nbre_obstacle,obstacle_rencontres : integer; var difficulte : integer);

var i,j,n,larg,long : integer;
	coord : coordonnee;

begin
long:=difficulte*3;
larg:=difficulte*2;
	for i:=1 to longueur do
	for j:=1 to largeur do
		begin
		tab[i,j]:='vide';
		if (i=1) or (i=long) then
			for n:=1 to larg do
			tab[i,n]:='mur';
		if (j=1) or (j=larg) then
			for n:=1 to long do
			tab[n,j]:='mur';
		end;
	for i:=1 to max_obstacle -3 do
		fixer_xy(obstacle[i],0,0);

	nbre_obstacle:=0;
	obstacle_rencontres:=0;
	creationpomme(tab,pomme,difficulte,'normale');
	
	for i:=1 to obstacle_init do
		creationobstacle(tab,obstacle,nbre_obstacle,coord, difficulte);
end;


procedure initsnake(var tab : tableau2D; var tabdirection : tableaudirection; var i_snake : tableau_snake; var taille_snake : integer; var direction : string; var difficulte : integer);
var i : integer;
begin
	taille_snake:=taille_init_snake;
	for i:=1 to (difficulte*difficulte*6) do		{initialisation du tableau avec que des coordonnées (0,0)}
	begin
		fixer_xy(i_snake[i],0,0);
		tabdirection[i]:='noDirection';
	end;		{initialement le serpent est de taille 3 donc une tete, un corps et 1 queue, donc le tableau corps a une seule valeur, ce max sera modifié avec les pommes. Pour etre clair taille_du_corps = taille du serpent -2}

	direction:='Right';
	for i:=1 to taille_snake do 
	begin
		tab[x(i_snake[i]),y(i_snake[i])]:='snake';
		fixer_xy(i_snake[i],5-i,2);
		tabdirection[i]:=direction;
	end;
end;


procedure partie(var perdu : boolean;var difficulte : integer);

var	tab : tableau2D;
	snake : tableau_snake;
	taille_snake,nbre_obstacle,pommes_mangees,pommesdorees_mangees,obstacles_rencontres,vitesse_init : integer;
	casesParcourues,scr : Longint;
	echap,pommedodovf,murgold : boolean; 		{pommedodovf savoir si une pomme dorée est sur le plateau}
	direction : string;
	pomme,pommedoree : coordonnee;
	obstacle : tableau_obstacle;
	tabDirection : tableaudirection;
	position : tsdl_rect;
begin
		initsnake(tab,tabdirection,snake,taille_snake,direction,difficulte);
		initmap(tab, pomme, obstacle,nbre_obstacle,obstacles_rencontres,difficulte);
		
		
		
		{fin initsnake}
		init_sdl(difficulte);
		
		init_gif(tabgif);
		
		afficherTab(tab);
		
		vitesse_init := vitesse_initiale;
		delay(vitesse_init);
		echap:=false;
		perdu:=false;
		murgold:=false;
		nbre_obstacle:=obstacle_init;
		pommes_mangees := 0;
		pommesdorees_mangees := 0;
		obstacles_rencontres := 0;
		casesParcourues := 0;
		position.x:=height*3*difficulte+5;position.y:=10;
		sdl_blitsurface(scorepng,nil,window,@position);sdl_flip(window);
		scr:=0;
		pommedodovf := false;
		afficher_score(scr,difficulte);
		while (perdu = false) and (echap=false) do 
			begin
				deplacement(tab,tabdirection,snake,obstacle,direction,perdu,echap,taille_snake,pommes_mangees,pommesdorees_mangees, obstacles_rencontres,nbre_obstacle,vitesse_init,casesParcourues,pomme,pommedoree,difficulte,pommedodovf,murgold);
				casesParcourues := casesParcourues+1 ;
			end;
		gotoxy(1, largeur+2);
		textcolor(white);
		if perdu = true then begin game_over()	end;
		free_sdl();
		ranking(pommes_mangees,pommesdorees_mangees,obstacles_rencontres);
end;

procedure	navigation_menu(var exit,perdu : boolean);
var K :  TKeyEvent;
	difficulte:	integer;
begin
	   exit:=false;
			{permet de se déplacer sur les différentes options du menu}
			K := GetKeyEvent();
			K := TranslateKeyEvent(K);
			gotoxy(1,1);
			GotoXY(57,posY);
			write('  '); {efface la flèche pour la réafficher sur une autre option}
			if (KeyEventToString(K) = 'Up') and (posY>16) then
				posY := posY - 3;
			if (KeyEventToString(K) = 'Down') and (posY<28)then
				posY := posY + 3;
			gotoXY(57,posY);
			Write('->');	
				
			{permet de choisir l'option du menu que l'on souhaite}
			case posY of 
			
				{Lance la partie}
					16 : if (K =7181) then 
							begin
								difficulte:=choix_diff();
								partie(perdu,difficulte);
							end;
						
					{Lance les règles}
					19: if (K =7181) then 
							begin
								regleJeu();
								affichage_Menu();
								gotoXY(57,19);
								write('->️');
							end;
							
					{Lance les crédits}	
					22: if (K =7181) then 	
							begin
								creditsJeu();
								affichage_Menu();
								gotoXY(57,22);
								write('->');
							end;
					
					{Lance le classement}	
					25: if (K =7181) then 	
							begin
								affichranking();
								affichage_Menu();
								gotoXY(57,25);
								write('->');
							end;
					28: if (K =7181) then 	
							begin
								exit:=true;
							end;
			end;

		end;

BEGIN

initkeyboard;
	
affichage_Menu();


posY:=16;
GotoXY(57,posY);
Write('->');
perdu:=false;
exit:=false;
while ((perdu = false) and (exit=false)) do navigation_menu(exit,perdu);



donekeyboard;
END.
