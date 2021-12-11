with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings;

with Ada.Strings.Unbounded;

procedure Main is
    type Dumbo_Octopus_Type is array(0 .. 11, 0 .. 11) of Natural;
    Dumbo_Octopus : Dumbo_Octopus_Type;
    
    procedure Read_File is
        use Ada.Strings.Maps;
        use Ada.Strings.Unbounded;
        use Ada.Strings.Fixed;
        use Ada.Strings;
        F           : File_Type;
        File_Name   : constant String := "input";
        Row         : Positive := 1;
    begin
        
        Open (F, In_File, File_Name);
        
        while not End_Of_File (F) loop
            
            declare
                Str : String := Get_Line (F);
                Start : Positive := Str'First;
                Finish : Natural := Str'Last;
            begin

                while Start /= Finish+1 loop
                    Dumbo_Octopus(Row, Start) := Natural'Value((1 => Str(Start)));
                    Start := Start + 1;
                end loop;
                Row := Row + 1;                
            end;
        end loop; 
        
        Close(F);

        for i in 1 .. 10 loop
            for ii in 1 .. 10 loop
                Ada.Text_IO.Put (Natural'Image(Dumbo_Octopus(i, ii)));
            end loop;
            Ada.Text_IO.Put_Line("");
        end loop;

    end Read_File;

    procedure Increment_Window (Arr : in out Dumbo_Octopus_Type; i, ii : in Integer) is

    begin
        Dumbo_Octopus(i, ii) := Dumbo_Octopus(i, ii) + 1;
        if Dumbo_Octopus(i, ii) = 10  and i > 0 and i < 11 and ii > 0 and ii < 11 then
            Increment_Window (Arr => Dumbo_Octopus, i => i-1, ii => ii);
            Increment_Window (Arr => Dumbo_Octopus, i => i+1, ii => ii);
            Increment_Window (Arr => Dumbo_Octopus, i => i, ii => ii-1);
            Increment_Window (Arr => Dumbo_Octopus, i => i, ii => ii+1);

            Increment_Window (Arr => Dumbo_Octopus, i => i-1, ii => ii-1);
            Increment_Window (Arr => Dumbo_Octopus, i => i+1, ii => ii+1);

            Increment_Window (Arr => Dumbo_Octopus, i => i+1, ii => ii-1);
            Increment_Window (Arr => Dumbo_Octopus, i => i-1, ii => ii+1);
        end if;

    end Increment_Window;

    
begin

    Read_File;

    declare
        Steps : constant Positive := 100;
        Flash_Cnt : Natural := 0;
    begin
    for S in 1 .. Steps loop
        
-- Step 1: the energy level of each octopus increases by 1.
-- Step 2: any octopus with an energy level greater than 9 flashes
        for i in 1 .. 10 loop
            for ii in 1 .. 10 loop
                Increment_Window (Arr => Dumbo_Octopus, i => i, ii => ii);               
            end loop;
        end loop;
-- Finally, any octopus that flashed during this step has its energy level set to 0, as it used all of its energy to flash.
        for i in 1 .. 10 loop
            for ii in 1 .. 10 loop
                if Dumbo_Octopus(i, ii) > 9 then
                    Dumbo_Octopus(i, ii) := 0;
                    Flash_Cnt := Flash_Cnt + 1;
                end if;
            end loop;
        end loop;

        if S = 3 then
        Ada.Text_IO.Put_Line("Step 3:");
            for i in 1 .. 10 loop
                for ii in 1 .. 10 loop
                    Ada.Text_IO.Put (Natural'Image(Dumbo_Octopus(i, ii)));
                end loop;
            Ada.Text_IO.Put_Line("");
        end loop;
        end if;

    end loop;
    
    Ada.Text_IO.Put_Line ("Total of Flashes: " & Natural'Image(Flash_Cnt));
    end;


end Main;