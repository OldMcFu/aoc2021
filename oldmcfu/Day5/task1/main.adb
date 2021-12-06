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
    Diagram : Diagram_Type := (others => (others => -1));

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
        File_Name   : constant String := "test";
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
            Max, Min : Integer := 0;
        begin
            if Cords(1) = Cords(3) then
                -- x equal
                if Cords(0) > Cords(2) then
                    Max := Cords(0);
                    Min := Cords(2);
                else
                    Min := Cords(0);
                    Max := Cords(2);
                end if;

                while Min /= Max loop
                    Diagram(Cords(1), Min) := Diagram(Cords(1), Min) + 1;
                    Min := Min + 1;
                end loop;
            elsif Cords(0) = Cords(2) then
                -- y equal
                if Cords(1) > Cords(3) then
                    Max := Cords(1);
                    Min := Cords(3);
                else
                    Min := Cords(1);
                    Max := Cords(3);
                end if;

                while Min /= Max loop
                    Diagram(Min, Cords(0)) := Diagram(Min, Cords(0)) + 1;
                    Min := Min + 1;
                end loop;
            else
                null;
            end if;    

        end;
        
    end loop;

    for Y in 0 .. Y_Max loop
        for X in 0 .. X_Max loop
            Put(Integer'Image(Diagram(X, Y)) & " ");
        end loop;
        Put_Line(" ");
    end loop;


end Main;