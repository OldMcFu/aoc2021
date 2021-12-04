with Ada.Text_IO, Ada.Containers.Indefinite_Vectors, Ada.Strings.Fixed, Ada.Strings.Maps;
use Ada.Text_IO, Ada.Containers, Ada.Strings, Ada.Strings.Fixed, Ada.Strings.Maps;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Main is
    package String_Vectors is new Indefinite_Vectors (Positive, String);
    use String_Vectors;
   
    F    : File_Type;
    File_Name : constant String := "input";
    Line :  Unbounded_String;
    Str_Vec : Vector := Empty_Vector;
    Match_Cnt : Integer := 0;
    Array_Index : Integer := 0;
    type Unbounded_String_Array_Type is array(0 .. 4) of Unbounded_String;
    Buffer : Unbounded_String_Array_Type;
    Sub : Integer := 0;
    Last_Match_Number : Unbounded_String;

    procedure Tokenize(Input : in String; Deliminiter : in Character; Output : in out Vector) is
        Start  : Positive := Input'First;
        Finish : Natural  := 0;
        begin
        while Start <= Input'Last loop
            Find_Token (Input, To_Set (Deliminiter), Start, Outside, Start, Finish);
            exit when Start > Finish;
            Output.Append (Input (Start .. Finish));
            Start := Finish + 1;
        end loop;
    end Tokenize;
    
    First : Boolean := True;
begin

    Open (F, In_File, File_Name);
    Main_Cycle:
    while not End_Of_File (F) loop
        Line := To_Unbounded_String (Get_Line (F));
        if First = True then
            Tokenize (To_String(Line), ',', Str_Vec);
            First := False;
        else
            if To_String (Line) = "" then
                Array_Index := 0;
                exit Main_Cycle when Match_Cnt = 5;
            else
                Buffer(Array_Index) := Line;
                Array_Index := Array_Index + 1;
                Match_Cnt := 0;
                for S of Str_Vec loop
                    declare
                        Max_Match_Cnt : constant Integer := 5;
                    begin
                        if Index (To_String(Line), S) > 0 then
                            Match_Cnt := Match_Cnt + 1;
                            if Match_Cnt = Max_Match_Cnt then
                                Put_Line ("Last Match Number is: " & S);
                                Put_Line ("Line String is: " & To_String(Line));
                                Last_Match_Number := To_Unbounded_String (S);
                                while To_String (Line) /= "" loop
                                    Line := To_Unbounded_String (Get_Line (F));
                                    If To_String (Line) /= "" then 
                                        Buffer(Array_Index) := Line;
                                        Array_Index := Array_Index + 1;
                                    end if;
                                end loop;
                                exit Main_Cycle when To_String (Line) = "";
                            end if;
                        end if;
                    end;
                end loop;
            end if;      
        end if;
    end loop Main_Cycle; 
    Close (F);

    declare
        Sum : Integer := 0;
        Vec: Vector;
        Match : Boolean := False;
    begin
        for S of Buffer loop
            Tokenize (To_String(S), ' ', Vec);
            for I of Vec loop
                Loop_Over_Header:
                for X of Str_Vec loop
                    if X = I then 
                        Match := True;
                    end if;
                    exit Loop_Over_Header when X = Last_Match_Number;
                end loop Loop_Over_Header;
                if Match = False then Sum := Sum + Integer'Value(I); end if;
                Match := False;
            end loop;
        end loop;

        Sum := Sum - Sub;
        Sum := Sum * Integer'Value(To_String(Last_Match_Number));

        Put_Line ("Sum is: " & Integer'Image(Sum));

    end;
end Main;