with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings;

with Ada.Strings.Unbounded;

procedure Main is

    package Lanternfish_Timer_Vectors is new
        Ada.Containers.Vectors (   
            Index_Type   => Natural,
            Element_Type => Integer);

    
    Lanternfish_Timer : Lanternfish_Timer_Vectors.Vector := Lanternfish_Timer_Vectors.Empty_Vector;
    
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
        Lanternfish_Timer : in out Lanternfish_Timer_Vectors.Vector
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
                Lanternfish_Timer.Append(Integer'Value(To_String (Line)(Start .. Finish)));
                Start := Finish + 1;
            end loop;
        end loop; 
        Close(F);

    end Read_File;

    
begin

    Read_File (Lanternfish_Timer);
    declare
        subtype Days is Integer range 1 .. 80;
        Zero        : constant := 0;
        Reset_Value : constant := 6;
        Add_Num     : constant := 8;  
        Add_Cnt : Integer := 0;
        
    begin
        for Day in Days loop
        Add_Cnt := 0;
            for Timer of Lanternfish_Timer loop
                --Put(Integer'Image(Timer) & " ");   
                if Timer /= 0 then
                    Timer := Timer - 1;
                else 
                    Timer := Reset_Value;
                    Add_Cnt := Add_Cnt + 1;
                end if; 
            end loop;
            --Put_Line("");

            for i in 1 .. Add_Cnt loop
                Lanternfish_Timer.Append(Add_Num);        
            end loop;
        end loop;    
    end;
    
    declare
        Vec_Size : Integer := 0;
    begin
        for Timer of Lanternfish_Timer loop
            Vec_Size := Vec_Size + 1;
            --Put(Integer'Image(Timer) & " ");
        end loop;
        Put_Line("Amount of Lantern Fishs: " & Integer'Image(Vec_Size));
    end;

end Main;