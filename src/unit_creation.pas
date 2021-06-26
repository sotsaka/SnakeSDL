unit unit_creation;

interface

uses unit_types,unit_sdl,crt;

procedure creationpomme (var tab : tableau2D; var pomme : coordonnee; var difficulte : integer; normalOuDoree : string);
procedure creationObstacle (var tab : tableau2D; var obstacle : tableau_obstacle; var nbre_obstacle : integer; var coord : coordonnee; var difficulte : integer);
procedure afficherTab(tab : tableau2D);
function genererCoordonnee (tab : Tableau2D; var difficulte : integer) : coordonnee;

implementation

procedure afficherTab(tab : tableau2D);
var i,j,k,l,x_,y_ : integer;
	d : string;
begin
clrscr;

for i:=1 to longueur do
for j:=1 to largeur do
	begin
	gotoxy(2*i,j);
	k:=i;l:=j; { obligation de faire ce changement de variable sinon -> erreur de compilation (for-loop)}
	case tab[i,j] of
		'mur' : begin  afficher_mur(k,l); end;
		'pomme' : begin afficher_pomme(k,l); end;
		'obstacle' : begin afficher_obstacle(k,l); end;
	end;
	end;
	x_:=2;y_:=2;d:='Right';
	afficher_queue(x_,y_,d);x_:=x_+1;
	afficher_corp(x_,y_,d,d); x_:=x_+1;
	afficher_tete(x_,y_,d);
end;

procedure creationpomme (var tab : tableau2D; var pomme : coordonnee; var difficulte : integer; normalOuDoree : string);

var a, b : Integer;

begin
	randomize;
	repeat
		a := random(difficulte*3-2)+2;
		b := random(difficulte*2-2)+2;
	until tab[a,b]='vide';
	case normalOuDoree of
		'normale' : tab[a,b] := 'pomme';
		'doree' : tab[a,b] := 'pommedoree';
	end;
	pomme.x := a;
	pomme.y := b;
end;
	
procedure creationObstacle (var tab : tableau2D; var obstacle : tableau_obstacle; var nbre_obstacle : integer; var coord : coordonnee; var difficulte : integer);
begin
	coord:=genererCoordonnee(tab, difficulte);
	tab[x(coord),y(coord)] := 'obstacle';
	nbre_obstacle:=nbre_obstacle+1;
	fixer_xy(obstacle[nbre_obstacle],x(coord),y(coord));
end;

function genererCoordonnee (tab : Tableau2D; var difficulte : integer) : coordonnee;
var a,b : integer;
begin
	randomize;
	repeat
		a := random(difficulte*3-2)+2;
		b := random(difficulte*2-2)+2;
	until tab[a,b]='vide';
	fixer_xy(genererCoordonnee,a,b);
end;


end.

