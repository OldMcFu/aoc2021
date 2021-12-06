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
    
    procedure String_Replace(S: in out Ada.Strings.Unbounded.Unbounded_String; Pattern, Replacement: Ada.Strings.Unbounded.Unbounded_String) is
    -- example: if S is "Mary had a XX lamb", then String_Replace(S, "X", "little");
    --          will turn S into "Mary had a littlelittle lamb"
    --          and String_Replace(S, "Y", "small"); will not change S
       Index : Natural;
   begin
      loop
         Index := Ada.Strings.Unbounded.Index(Source => S, Pattern => Pattern);
         exit when Index = 0;
         Ada.Strings.Unbounded.Replace_Slice
           (Source => S, Low => Index, High => Index+Pattern'Length-1,
            By => Replacement);
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
            String_Replace (S => Line, Pattern => " -> ", Replacement => Line);
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
        end loop;
        Close(F);

    end Read_File;

begin

    Read_File (Coordinates);

    for Cords of Coordinates loop
        for I in 0 ..3 loop
            for II in 0 .. 3 loop
            Put_Line (Integer'Image(Cords(I, II)));
            end loop;
        end loop;
    end loop;


end Main;