with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings;

with Ada.Strings.Unbounded;

procedure Main is

    type Diagram_Type is array (0 .. 999, 0 .. 999) of Integer;
    type Coordinates_Type is array (0 .. 3) of Integer;
    package Coordinates_Vectors is new
        Ada.Containers.Vectors (   
            Index_Type   => Natural,
            Element_Type => Coordinates_Type);

    
    Coordinates : Coordinates_Vectors.Vector := Coordinates_Vectors.Empty_Vector;
    Diagram : Diagram_Type := (others => (others => 0));

    X_Max, Y_Max : Integer := 0;    
    procedure String_Replace(S: in out Ada.Strings.Unbounded.Unbounded_String; Pattern, Replacement: String) is
    -- example: if S is "Mary had a XX lamb", then String_Replace(S, "X", "little");
    --          will turn S into "Mary had a littlelittle lamb"
    --          and String_Replace(S, "Y", "small"); will not change S
       I : Natural;
       P : String := Pattern;
       R : String := Replacement;
   begin
      loop
         I := Ada.Strings.Unbounded.Index(S, P);
         exit when I = 0;
         Ada.Strings.Unbounded.Replace_Slice
           (Source => S, Low => I, High => I+P'Length-1,
            By => R);
      end loop;
   end String_Replace;

    procedure Read_File(
        Coordinates : in out Coordinates_Vectors.Vector
        ) is
        use Ada.Strings.Maps;
        use Ada.Strings.Unbounded;
        use Ada.Strings.Fixed;
        use Ada.Strings;
        F           : File_Type;
        File_Name   : constant String := "input";
        Line        : Unbounded_String;
        Start       : Positive;
        Finish      : Natural;
        tmp         : Coordinates_Type := (others => 0);
        Cnt         : Integer := 0;
    begin
        
        Open (F, In_File, File_Name);
        
        while not End_Of_File (F) loop
            Line    := To_Unbounded_String (Get_Line (F));
            String_Replace (S => Line, Pattern => " -> ", Replacement => ",");
            Start   := To_String (Line)'First;
            Finish  := 0;
            Cnt := 0;
            while Start <= To_String (Line)'Last loop
                Find_Token (Line, To_Set(','), Start, Ada.Strings.Outside, Start, Finish);
                exit when Start > Finish;
                tmp(Cnt) := (Integer'Value(To_String (Line)(Start .. Finish)));
                Start := Finish + 1;
                Cnt := Cnt + 1;
            end loop;
            Coordinates.Append (tmp);
            if tmp(0) > X_Max or tmp(2) > X_Max then
                if tmp(0) > tmp(2) then
                    X_Max := tmp(0);
                else
                    X_Max := tmp(2);
                end if;
            end if;

            if tmp(1) > Y_Max or tmp(3) > Y_Max then
                if tmp(1) > tmp(3) then
                    Y_Max := tmp(1);
                else
                    Y_Max := tmp(3);
                end if;
            end if;

        end loop; 
        Close(F);

    end Read_File;

begin

    Read_File (Coordinates);

    for Cords of Coordinates loop
        declare
            X1 : constant := 0;
            X2 : constant := 2;
            Y1 : constant := 1;
            Y2 : constant := 3;
            Max, Min : Integer := 0;
        begin
            if Cords(Y1) = Cords(Y2) then
                -- y equal
                if Cords(X1) > Cords(X2) then
                    Max := Cords(X1);
                    Min := Cords(X2);
                else
                    Min := Cords(X1);
                    Max := Cords(X2);
                end if;
                --Put_Line("Y: " & Integer'Image(Cords(Y1)) & "   " & "X_Min: " & Integer'Image(Min) & "   " & "X_Max: " & Integer'Image(Max));
                while Min /= (Max + 1) loop
                    Diagram(Min, Cords(Y1)) := Diagram(Min, Cords(Y1)) + 1;
                    Min := Min + 1;
                end loop;
            elsif Cords(X1) = Cords(X2) then
                -- x equal
                if Cords(Y1) > Cords(Y2) then
                    Max := Cords(Y1);
                    Min := Cords(Y2);
                else
                    Min := Cords(Y1);
                    Max := Cords(Y2);
                end if;
                --Put_Line("X: " & Integer'Image(Cords(X1)) & "   " & "Y_Min: " & Integer'Image(Min) & "   " & "Y_Max: " & Integer'Image(Max));
                while Min /= (Max + 1) loop
                    Diagram(Cords(X1), Min) := Diagram(Cords(X1), Min) + 1;
                    Min := Min + 1;
                end loop;
            else
                null;
            end if;    
        end;
    end loop;

    declare
        two_or_higher_cnt : Integer := 0;
    begin
        for Y in 0 .. Y_Max loop
            for X in 0 .. X_Max loop
                --Put(Integer'Image(Diagram(X, Y)) & " ");
                if Diagram(X, Y) > 1 then
                    two_or_higher_cnt := two_or_higher_cnt + 1;
                end if;
            end loop;
            --Put_Line(" ");
        end loop;
        Put_Line(Integer'Image(two_or_higher_cnt));        
    end;




end Main;