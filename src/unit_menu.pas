unit unit_menu;

interface 

uses crt, keyboard;
 

procedure affichage_Menu();
procedure regleJeu();
procedure creditsJeu();
function choix_diff() : integer;


implementation 


{On affiche le menu principal où les joueur arriveront avant chaque début de partie}

procedure affichage_Menu();
var carr:string;
	dessinAscii:text;

BEGIN

	GotoXY(10,1);
	Textcolor(lightgreen);
	assign(dessinAscii, 'fichiersTextes/dessinSnake.txt');
	reset(dessinAscii);
	while not eof(dessinAscii) do 
		begin
			readln(dessinAscii, carr);
			writeln(carr);
		end;
	Textcolor(white);
	GotoXY(60,16);
	Writeln('PLAY');
	GoToXY(60,19);
	Writeln('RULES');
	GotoXY(60,22);
	Writeln('CREDITS');
	GotoXY(60,25);
	Writeln('CLASSEMENT');
	gotoxy(60,28);
	writeln('EXIT');
END;


procedure regleJeu();

var carr:string;
	regle,titreRegle:text;
	K: TKeyEvent;
begin
	clrscr;
	{On affiche le titre en vert}
	textcolor(lightgreen);
	assign(titreRegle, 'fichiersTextes/titreRegle.txt');
	reset(titreRegle);
	while not eof(titreRegle) do 
		begin
			readln(titreRegle, carr);
			writeln(carr);
		end;
		
	{On affiche les règles en blanc}
	textcolor(white);
	writeln();
	writeln();
	assign(regle, 'fichiersTextes/regle.txt');
	reset(regle);
	while not eof(regle) do 
		begin
			readln(regle, carr);
			writeln(carr);
		end;
		
	{Tant que l'utilisateur n'appuie pas sur echap le joueur ne sort pas des règles}
	K:=GetKeyEvent();
	while (TranslateKeyEvent(K) <> 7181) do 
	begin
	K:=GetKeyEvent();
	K:=translatekeyEvent(K);
	end;
	clrscr;
end;


procedure creditsJeu();

var carr:string;
var credits:text;
var K: TKeyEvent;

begin
	clrscr;
	{On affiche le titre en vert}
	textcolor(lightgreen);
	assign(credits, 'fichiersTextes/titreCredits.txt');
	reset(credits);
	while not eof(credits) do 
		begin
			readln(credits, carr);
			writeln(carr);
		end;
	writeln();
	writeln();
	
	{On affiche les règles en blanc}
	textcolor(white);
	assign(credits, 'fichiersTextes/credits.txt');
	reset(credits);
	while not eof(credits) do 
		begin
			readln(credits, carr);
			writeln(carr);
		end;
	
	{Tant que l'utilisateur n'appuie pas sur echap le joueur ne sort pas des règles}
	K:=GetKeyEvent();
	while (TranslateKeyEvent(K) <> 7181) do 
	begin
	K:=GetKeyEvent();
	K:=translatekeyEvent(K);
	end;
	clrscr;


end;

function choix_diff(): integer;

var	carr : String;
	dessinAscii:text;
	y : integer;
	K : TKEYEVENT;
begin
clrscr;
GotoXY(10,1);
	Textcolor(lightgreen);
	assign(dessinAscii, 'fichiersTextes/dessinSnake.txt');
	reset(dessinAscii);
	while not eof(dessinAscii) do 
		begin
			readln(dessinAscii, carr);
			writeln(carr);
		end;
	Textcolor(white);
	GotoXY(52,16);
	write('CHOISIR DIFFICULTE :');
	gotoxy(60,19);
	write('FACILE');
	gotoxy(60,21);
	write('MOYEN');
	gotoxy(60,23);
	write('DIFFICILE');
	y:=19;
	gotoxy(57,y);
	write('->');
	repeat
	K := GetKeyEvent();
			K := TranslateKeyEvent(K);
			GotoXY(57,y);
			write('  '); {efface la flèche pour la réafficher sur une autre option}
			if (KeyEventToString(K) = 'Up') and (y>19) then
				y := y - 2;
			if (KeyEventToString(K) = 'Down') and (y<23)then
				y := y + 2;
			gotoXY(57,y);
			Write('->');
				
			{permet de choisir l'option du menu que l'on souhaite}
			case y of 
				19 : begin choix_diff:=10 end;
				21 : begin choix_diff:=7 end;
				23 : begin choix_diff:=4 end;
			end;
	 until TranslateKeyEvent(k)=7181;
end;


end.
