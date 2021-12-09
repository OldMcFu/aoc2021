with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings;

with Ada.Strings.Unbounded;

procedure Main is

    package Integer_Vectors is new
        Ada.Containers.Vectors (   
            Index_Type   => Natural,
            Element_Type => Integer);

    
    Horizontal_Position : Integer_Vectors.Vector := Integer_Vectors.Empty_Vector;
    
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
        My_Vector : in out Integer_Vectors.Vector
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
    begin
        
        Open (F, In_File, File_Name);
        
        while not End_Of_File (F) loop
            Line    := To_Unbounded_String (Get_Line (F));
            --String_Replace (S => Line, Pattern => " -> ", Replacement => ",");
            Start   := To_String (Line)'First;
            Finish  := 0;

            while Start <= To_String (Line)'Last loop
                Find_Token (Line, To_Set(','), Start, Ada.Strings.Outside, Start, Finish);
                exit when Start > Finish;
                My_Vector.Append(Integer'Value(To_String (Line)(Start .. Finish)));
                Start := Finish + 1;
            end loop;
        end loop; 
        Close(F);

    end Read_File;

    
begin

    Read_File (Horizontal_Position);
    declare
        Fuel : Natural := 0;
        N : Natural := 0;
        Min_Fuel : Natural := (2**31)-1;
        Min_Position : Integer := 0;
        Cnt : Integer := 0;
    begin
        --Init Array
        for Position of Horizontal_Position loop
            Fuel := 0;
            for I of Horizontal_Position loop
                N := abs(I - Cnt);
                Fuel := Fuel + ((N * (N + 1))/2);
            end loop;
            --Put_Line ("Total Fuel: " & Natural'Image(Fuel) & " for Position: " & Integer'Image(Cnt));

            if Fuel < Min_Fuel then
                Min_Fuel := Fuel;
                Min_Position := Cnt;
            end if;    
            Cnt := Cnt + 1;        
        end loop;
        Put_Line ("Min Fuel: " & Natural'Image(Min_Fuel) & " for Position: " & Integer'Image(Min_Position));
    end;

end Main;