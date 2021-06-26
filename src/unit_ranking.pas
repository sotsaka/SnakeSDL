unit unit_ranking;

interface

uses keyboard, SysUtils, crt, unit_types, unit_deplacement;

procedure ranking(pommes_mangees,pommesdorees_mangees, obstacles_rencontres : Integer);
procedure affichranking();


implementation

procedure ranking(pommes_mangees,pommesdorees_mangees, obstacles_rencontres : Integer);

var name, points, temp1 : String;
	scor, i, k, l, temp2 : Integer;
	f : Text;
	tab1 : array [1 .. 3] of String;
	tab2 : array [1 .. 3] of Integer;

begin
	i := 1;
	assign(f, 'fichiersTextes/Scores.txt');
	reset(f);
	for i := 1 to 3 do
		begin
			Readln(f, name);
			tab1[i] := name;
			Readln(f, points);
			tab2[i] := StrtoInt(points);
		end;
	close(f);
	
	scor := score(pommes_mangees,pommesdorees_mangees, obstacles_rencontres);
	
	If scor > tab2[3] then
		begin
			tab2[3] := scor;
			Writeln('Entre ton nom de joueur : ');
			Read(tab1[3]);
		end;
	
	for k := 3 downto 2 do 
		begin
			If tab2[k] > tab2[k-1] then 
				begin
					temp1 := tab1[k-1];
					tab1[k-1] := tab1[k];
					tab1[k] := temp1;
					
					temp2 := tab2[k-1];
					tab2[k-1] := tab2[k];
					tab2[k] := temp2;
				end;
		end;
		
	assign(f, 'fichiersTextes/Scores.txt');
	rewrite(f);
	for l := 1 to 3 do 
		begin
			Writeln(f, tab1[l]);
			writeln(f, tab2[l]);
		end;
	close(f);
end;

procedure affichranking();

var f : Text;
	name : String;
	points, i : Integer;
	K : TKeyEvent;
begin
	clrscr;
	{On affiche le titre en vert}
	{textcolor(lightgreen);
	assign(titreRegle, '');
	reset(titreRegle);
	while not eof(titreRegle) do 
		begin
			readln(titreRegle, carr);
			writeln(carr);
		end;
	}
	assign(f,'fichiersTextes/Scores.txt');
	reset(f);
	for i := 1 to 3 do
		begin
			Readln(f, name);
			if i<>1 then
				Write(i,'eme : ',name)
			else
				Write('1er : ',name);
			gotoxy(20,i);
			write('            Score : ');
			Readln(f, points);
			Writeln(points);
		end;
	close(f);
	
	{ Tant que l'utilisateur n'appuie pas sur echap le joueur ne sort pas des règles}
	K:=GetKeyEvent();
	while (TranslateKeyEvent(K) <> 7181) do 
	begin
	K:=GetKeyEvent();
	K:=translatekeyEvent(K);
	end;
	clrscr;
end;

end.
