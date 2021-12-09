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

    --Horizontal_Position : Integer_Vectors.Vector := Integer_Vectors.Empty_Vector;
    
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

    procedure Read_File is
        use Ada.Strings.Maps;
        use Ada.Strings.Unbounded;
        use Ada.Strings.Fixed;
        use Ada.Strings;
        F           : File_Type;
        File_Name   : constant String := "input";
        Line        : Unbounded_String;
        Start       : Positive;
        Finish      : Natural;
        Unice_Numbers : Natural := 0;
    begin
        
        Open (F, In_File, File_Name);
        
        while not End_Of_File (F) loop
            Line    := To_Unbounded_String (Get_Line (F));
            --String_Replace (S => Line, Pattern => " -> ", Replacement => ",");
            Start   := To_String (Line)'First;
            Finish  := 0;
            
            Find_Token (Line, To_Set('|'), Start, Ada.Strings.Outside, Start, Finish);
            declare
                Left_Side  : String := To_String(Line)(Start .. Finish);
                Right_Side : String := To_String(Line)((Finish+3) .. To_String(Line)'Length);
            begin
                Start   := Right_Side'First;
                Finish  := 0;
                while Start <= Right_Side'Last loop
                    Find_Token (Line, To_Set(' '), Start, Ada.Strings.Outside, Start, Finish);
                    exit when Start > Finish;

                    if Right_Side(Start .. Finish)'Length = 2 or
                       Right_Side(Start .. Finish)'Length = 4 or
                       Right_Side(Start .. Finish)'Length = 3 or
                       Right_Side(Start .. Finish)'Length = 7 then
                        Unice_Numbers := Unice_Numbers + 1;
                    end if;
                    Start := Finish + 1;
                end loop;
            end;
        end loop;

        Ada.Text_IO.Put_Line ( Natural'Image(Unice_Numbers) );

        Close(F);
    end Read_File;
    
begin

    Read_File;

end Main;