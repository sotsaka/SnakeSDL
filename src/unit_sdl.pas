unit unit_sdl;
 
interface 

uses unit_types,sdl, sdl_image,sdl_ttf, Crt,Classes, SysUtils, dos,keyboard;

type gif = array [1..10] of psdl_surface;

var window, snakepng,wallpng,pommepng,obstaclepng,noirpng, un,deux,trois,quatre,cinq,six,sept,huit,neuf,zero,chiffrenoir, scorepng: psdl_surface;
	gif1,gif2,gif3,gif4,gif5,gif6,gif7,gif8,gif9,gif10,gold_pomme,gold_mur : psdl_surface;
	g0,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g24,g25,g26,g27,g28,g29,g30,g31,g32,g33,g34,g35,g36,blackscreen,press : psdl_surface;
	taille : tsdl_rect;
	k,l : integer;
	tabgif : gif;

procedure init_sdl(var difficulte : integer);
procedure free_sdl();

procedure afficher_tete(var i,j : integer; var direction :  string);
procedure afficher_corp(var i,j : integer; var direction,direction2 :  string);
procedure afficher_queue(var i,j : integer; var dir : string);

{procedure tetehaut(var i,j : integer);
procedure tetegauche(var i,j : integer);
procedure tetedroite(var i,j : integer);
procedure tetebas(var i,j : integer);
procedure queuehaut(var i,j : integer);
procedure queuedroite(var i,j : integer);
procedure queuegauche(var i,j : integer);
procedure queuebas(var i,j : integer);
procedure corpsvertical(var i,j : integer);
procedure corpshorizontal(var i,j : integer);
procedure tournerbasdroite(var i,j : integer);
procedure tournerbasgauche(var i,j : integer);
procedure tournerhautdroite(var i,j : integer);
procedure tournerhautgauche(var i,j : integer);}

procedure afficher_mur(var i,j : integer);
procedure afficher_mur_gold(var i,j : integer);
procedure afficher_pomme(var i,j : integer);
procedure afficher_pomme_gold(var i,j : integer);
procedure afficher_obstacle(var i,j : integer);

procedure noir(var i,j : integer);

procedure afficher_score(var score_sdl : Longint; var difficulte : integer);

procedure init_gif(var tabgif : gif);
procedure game_over();

implementation


const height=40;
	  width=40;
	 





procedure init_sdl(var difficulte : integer);
var longueur_sdl,largeur_sdl : integer;
begin
longueur_sdl:=height*3*difficulte+100;
largeur_sdl:=width*2*difficulte;

sdl_init(sdl_init_video);
window :=sdl_setvideomode(longueur_sdl, largeur_sdl, 32, sdl_swsurface);
sdl_flip(window);

snakepng:=img_load('images/snakesprites2.png');
wallpng:=img_load('images/wall.png');
pommepng:=img_load('images/pomme.png');
obstaclepng:=img_load('images/obstacle.png');
noirpng:=img_load('images/noir.png');
gold_pomme:=img_load('images/golden_apple.png');
gold_mur:=img_load('images/golden_wall.png');

un:=img_load('images/un.png');
deux:=img_load('images/deux.png');
trois:=img_load('images/trois.png');
quatre:=img_load('images/quatre.png');
cinq:=img_load('images/cinq.png');
six:=img_load('images/six.png');
sept:=img_load('images/sept.png');
huit:=img_load('images/huit.png');
neuf:=img_load('images/neuf.png');
zero:=img_load('images/zero.png');
scorepng:=img_load('images/score.png');



chiffrenoir:=img_load('images/chiffrenoir.png');
end;
procedure free_gif();
begin
sdl_freesurface(gif1);
sdl_freesurface(gif2);
sdl_freesurface(gif3);
sdl_freesurface(gif4);
sdl_freesurface(gif5);
sdl_freesurface(gif6);
sdl_freesurface(gif7);
sdl_freesurface(gif8);
sdl_freesurface(gif9);
sdl_freesurface(gif10);
end;
procedure free_sdl();
begin 


sdl_freesurface(wallpng);
sdl_freesurface(snakepng);
sdl_freesurface(pommepng);
sdl_freesurface(obstaclepng);
sdl_freesurface(noirpng);
sdl_freesurface(gold_pomme);
sdl_freesurface(gold_mur);

sdl_freesurface(un);
sdl_freesurface(deux);
sdl_freesurface(trois);
sdl_freesurface(quatre);
sdl_freesurface(cinq);
sdl_freesurface(six);
sdl_freesurface(sept);
sdl_freesurface(huit);
sdl_freesurface(neuf);
sdl_freesurface(zero);
sdl_freesurface(chiffrenoir);
sdl_freesurface(scorepng);

free_gif();

sdl_freesurface(window);

sdl_quit();
end;



procedure tetehaut(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=1;taille.y:=1;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure tetegauche(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=1;taille.y:=41;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure tetedroite(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=1;taille.y:=81;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure tetebas(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=1;taille.y:=121;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;

procedure queuehaut(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=41;taille.y:=1;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure queuegauche(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=41;taille.y:=81;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure queuedroite(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=41;taille.y:=41;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure queuebas(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=41;taille.y:=121;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;

procedure corpsvertical(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=81;taille.y:=41;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure corpshorizontal(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=81;taille.y:=81;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure tournerbasdroite(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=121;taille.y:=1;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure tournerhautdroite(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=121;taille.y:=41;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure tournerbasgauche(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=121;taille.y:=81;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;
procedure tournerhautgauche(var i,j : integer);
var taille,cursor : tsdl_rect;
begin
taille.x:=121;taille.y:=121;taille.h:=40;taille.w:=40;
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(snakepng, @taille,window,@cursor); sdl_flip(window);
end;

procedure afficher_mur(var i,j : integer);
var cursor : tsdl_rect;
begin
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(wallpng, nil,window,@cursor); sdl_flip(window);
end;


procedure afficher_pomme(var i,j : integer);
var cursor : tsdl_rect;
begin
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(pommepng, nil,window,@cursor); sdl_flip(window);
end;

procedure afficher_obstacle(var i,j : integer);
var cursor : tsdl_rect;
begin
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(obstaclepng, nil,window,@cursor); sdl_flip(window);
end;

procedure afficher_pomme_gold(var i,j : integer);
var cursor : tsdl_rect;
begin
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(gold_pomme, nil,window,@cursor); sdl_flip(window);
end;

procedure afficher_mur_gold(var i,j : integer);
var cursor : tsdl_rect;
begin
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(gold_mur, nil,window,@cursor); sdl_flip(window);
end;

procedure afficher_tete(var i,j : integer; var direction :  string);

begin
noir(i,j);sdl_flip(window);
	case direction of
	'Right': begin tetedroite(i,j) end;
	'Left' : begin tetegauche(i,j) end;
	'Up'   : begin tetehaut(i,j) end;
	'Down' : begin tetebas(i,j) end;
	end;
sdl_flip(window);
end;

procedure afficher_corp(var i,j : integer; var direction, direction2 :  string);
begin
noir(i,j);sdl_flip(window);
case  direction of
	'Right':begin
			case  direction2 of
					'Right': begin corpshorizontal(i,j) end;
					'Left' : begin {impossible} end;
					'Up'   : begin tournerbasdroite(i,j) end;
					'Down' : begin tournerhautdroite(i,j) end;
					end;
			end;
	'Left' :begin
			case  direction2 of
					'Right': begin {impossible} end;
					'Left' : begin corpshorizontal(i,j) end;
					'Down'   : begin tournerhautgauche(i,j) end;
					'Up' : begin tournerbasgauche(i,j) end;
					end;
			end;
	'Up'   :begin
			case  direction2 of
					'Right': begin tournerhautgauche(i,j) end;
					'Left' : begin tournerhautdroite(i,j) end;
					'Up'   : begin corpsvertical(i,j) end;
					'Down' : begin {impossible} end;
					end;
			end;
	'Down' :begin
			case  direction2 of
					'Right': begin tournerbasgauche(i,j) end;
					'Left' : begin tournerbasdroite(i,j) end;
					'Up'   : begin {impossible} end;
					'Down' : begin corpsvertical(i,j) end;
					end;
			end;
end;
sdl_flip(window);
end;
procedure afficher_queue(var i,j : integer; var dir :  string);
begin
noir(i,j);sdl_flip(window);
	case dir of
	'Right': begin queuedroite(i,j) end;
	'Left' : begin queuegauche(i,j) end;
	'Up'   : begin queuebas(i,j) end;
	'Down' : begin queuehaut(i,j) end;
	end;
sdl_flip(window);
end;

procedure noir(var i,j : integer);
var cursor : tsdl_rect;
begin
cursor.x:=1+(i-1)*width; cursor.y :=1+(j-1)*height;cursor.h:=40;cursor.w:=40;
sdl_blitsurface(noirpng, nil,window,@cursor); sdl_flip(window);
end;

procedure init_gif(var tabgif : gif);
	
begin
gif1:=img_load('images/gif1.png');
gif2:=img_load('images/gif2.png');
gif3:=img_load('images/gif3.png');
gif4:=img_load('images/gif4.png');
gif5:=img_load('images/gif5.png');
gif6:=img_load('images/gif6.png');
gif7:=img_load('images/gif7.png');
gif8:=img_load('images/gif8.png');
gif9:=img_load('images/gif9.png');
gif10:=img_load('images/gif10.png');

tabgif[1]:=gif1;
tabgif[2]:=gif2;
tabgif[3]:=gif3;
tabgif[4]:=gif4;
tabgif[5]:=gif5;
tabgif[6]:=gif6;
tabgif[7]:=gif7;
tabgif[8]:=gif8;
tabgif[9]:=gif9;
tabgif[10]:=gif10;

end;

procedure game_over();
var tabgo : array [0..36] of psdl_surface;
	i : integer;
	go : tsdl_rect;
	cle : psdl_event;
begin
g0:=img_load('images/go/0.png');
g1:=img_load('images/go/1.png');
g2:=img_load('images/go/2.png');
g3:=img_load('images/go/3.png');
g4:=img_load('images/go/4.png');
g5:=img_load('images/go/5.png');
g6:=img_load('images/go/6.png');
g7:=img_load('images/go/7.png');
g8:=img_load('images/go/8.png');
g9:=img_load('images/go/9.png');
g10:=img_load('images/go/10.png');
g11:=img_load('images/go/11.png');
g12:=img_load('images/go/12.png');
g13:=img_load('images/go/13.png');
g14:=img_load('images/go/14.png');
g15:=img_load('images/go/15.png');
g16:=img_load('images/go/16.png');
g17:=img_load('images/go/17.png');
g18:=img_load('images/go/18.png');
g19:=img_load('images/go/19.png');
g20:=img_load('images/go/20.png');
g21:=img_load('images/go/21.png');
g22:=img_load('images/go/22.png');
g23:=img_load('images/go/23.png');
g24:=img_load('images/go/24.png');
g25:=img_load('images/go/25.png');
g26:=img_load('images/go/26.png');
g27:=img_load('images/go/27.png');
g28:=img_load('images/go/28.png');
g29:=img_load('images/go/29.png');
g30:=img_load('images/go/30.png');
g31:=img_load('images/go/31.png');
g32:=img_load('images/go/32.png');
g33:=img_load('images/go/33.png');
g34:=img_load('images/go/34.png');
g35:=img_load('images/go/35.png');
g36:=img_load('images/go/35.png');
blackscreen:=img_load('images/go/blackscreen.png');
press:=img_load('images/go/press.png');

tabgo[0]:=g0;
tabgo[1]:=g1;
tabgo[2]:=g2;
tabgo[3]:=g3;
tabgo[4]:=g4;
tabgo[5]:=g5;
tabgo[6]:=g6;
tabgo[7]:=g7;
tabgo[8]:=g8;
tabgo[9]:=g9;
tabgo[10]:=g10;
tabgo[11]:=g11;
tabgo[12]:=g12;
tabgo[13]:=g13;
tabgo[14]:=g14;
tabgo[15]:=g15;
tabgo[16]:=g16;
tabgo[17]:=g17;
tabgo[18]:=g18;
tabgo[19]:=g19;
tabgo[20]:=g20;
tabgo[21]:=g21;
tabgo[22]:=g22;
tabgo[23]:=g23;
tabgo[24]:=g24;
tabgo[25]:=g25;
tabgo[26]:=g26;
tabgo[27]:=g27;
tabgo[28]:=g28;
tabgo[29]:=g29;
tabgo[30]:=g30;
tabgo[31]:=g31;
tabgo[32]:=g32;
tabgo[33]:=g33;
tabgo[34]:=g34;
tabgo[35]:=g35;
tabgo[36]:=g36;


go.x:=1;go.y:=1;
sdl_blitsurface(blackscreen,nil,window,@go);sdl_flip(window);
go.y:=250;
sdl_blitsurface(press,nil,window,@go);sdl_flip(window);
new(cle);
go.y:=1;
repeat
	for i:=0 to 36 do
		begin
		sdl_blitsurface(tabgo[i],nil,window,@go);sdl_flip(window);
		sdl_delay(25);
		end;
until SDL_POLLEVENT(cle)=1;
dispose(cle);

sdl_freesurface(g0);
sdl_freesurface(g1);
sdl_freesurface(g2);
sdl_freesurface(g3);
sdl_freesurface(g4);
sdl_freesurface(g5);
sdl_freesurface(g6);
sdl_freesurface(g7);
sdl_freesurface(g8);
sdl_freesurface(g9);
sdl_freesurface(g10);
sdl_freesurface(g11);
sdl_freesurface(g12);
sdl_freesurface(g13);
sdl_freesurface(g14);
sdl_freesurface(g15);
sdl_freesurface(g16);
sdl_freesurface(g17);
sdl_freesurface(g18);
sdl_freesurface(g19);
sdl_freesurface(g20);
sdl_freesurface(g21);
sdl_freesurface(g22);
sdl_freesurface(g23);
sdl_freesurface(g24);
sdl_freesurface(g25);
sdl_freesurface(g26);
sdl_freesurface(g27);
sdl_freesurface(g28);
sdl_freesurface(g29);
sdl_freesurface(g30);
sdl_freesurface(g31);
sdl_freesurface(g32);
sdl_freesurface(g33);
sdl_freesurface(g34);
sdl_freesurface(g35);
sdl_freesurface(g36);
sdl_freesurface(blackscreen);
sdl_freesurface(press);
end;

procedure afficher_score(var score_sdl : longint;var difficulte : integer);
var a,b : Longint;
	i : integer;
	position :  tsdl_rect;

begin
position.x:=height*difficulte*3+82;
position.y:=50;
a:=score_sdl;
if (a>= 100000) then begin a:=99999; end;
	
		for i:=1 to 5 do
		begin
		b := a mod 10;
		
			case b of
						0 : sdl_blitsurface(zero,nil, window, @position);
						1 : sdl_blitsurface(un,nil, window, @position);
						2 : sdl_blitsurface(deux,nil, window, @position);
						3 : sdl_blitsurface(trois,nil, window, @position);
						4 : sdl_blitsurface(quatre,nil, window, @position);
						5 : sdl_blitsurface(cinq,nil, window, @position);
						6 : sdl_blitsurface(six,nil, window, @position);
						7 : sdl_blitsurface(sept,nil, window, @position);
						8 : sdl_blitsurface(huit,nil, window, @position);
						9 : sdl_blitsurface(neuf,nil, window, @position);
					end;
		sdl_flip(window);
		a := a div 10;
		position.x:=position.x-20;
		end;
	
		
End;


end.
