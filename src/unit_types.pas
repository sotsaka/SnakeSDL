unit unit_types;


INTERFACE
uses keyboard,crt,sdl, sdl_image,sdl_ttf;

const longueur = 30;
	  largeur = 20;
	  height=40;
	  width=40;
	  taille_init_snake = 3;
	  obstacle_init = 0;
	  max_obstacle= (longueur-2)*(largeur-2)-1;
	  vitesse_initiale=400	;	{modifier ici la valeur de la vitesse initiale}
	  
Type coordonnee = record
                    x : Integer;
                    y : Integer;
                  end;                  
     
	 tableau2D = array[1..longueur,1..largeur] of string;
	 tableau_obstacle = array[1..max_obstacle] of coordonnee;				{pour laisser un peu d'espace au snake dans le cas extreme}
	 tableau_snake = array[1..longueur*largeur] of coordonnee;				{corps[1] représente la corps la plus proche de la tete, et corps[taille_du_corps] représente l'avant derniere corps, c'est à dire la corps la plus proche de queue}
	 tableaudirection  = array [1..longueur*largeur] of string;
	 
var	key : psdl_event;
	posY:integer;
	perdu:boolean;
	indicegif,longueur_sdl,largeur_sdl: integer;
	

	  
function x(xy : coordonnee) : integer;
function y(xy : coordonnee) : integer;
procedure fixer_xy(var xy : coordonnee; valeurx,valeury : Integer);

IMPLEMENTATION

procedure fixer_xy(var xy : coordonnee; valeurx,valeury : Integer);
begin
	xy.x:=valeurx;
	xy.y:=valeury;
end;

function x(xy : coordonnee) : integer;    {xy désigne un objet comme pomme ou tete peu importe c'est la variable que j'ai appelé comme ça}
begin
	x:=xy.x;
end;

function y(xy : coordonnee) : integer;			{xy désigne un objet comme pomme ou tete peu importe c'est la variable que j'ai appelé comme ça}
begin
	y:=xy.y;
end;

end.
