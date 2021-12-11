with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings;

with Ada.Strings.Unbounded;

procedure Main is
    
    procedure Read_File is
        use Ada.Strings.Maps;
        use Ada.Strings.Unbounded;
        use Ada.Strings.Fixed;
        use Ada.Strings;
        F           : File_Type;
        File_Name   : constant String := "input";
        Max_Lines   : Positive := 1;
        Len         : Positive := 1;
        Row         : Positive := 1;
    begin
        
        Open (F, In_File, File_Name);
        Len := Get_Line(F)'Length;
        while not End_Of_File (F) loop
            Max_Lines := Max_Lines + 1;
            declare
            dummy : String := Get_Line(F);
            begin
            null;
            end;
        end loop;
        Close(F);
        declare
            Sum : Natural := 0;
            Content     : array(1 .. Max_Lines, 1 .. Len) of Natural;
        begin
            Open (F, In_File, File_Name);
            while not End_Of_File (F) loop
                declare
                    Line : String := Get_Line (F);
                    Start       : Positive := Line'First;
                    Finish      : Natural  := Line'Last;
                begin
                    while Start < Finish + 1 loop
                        Content(Row, Start) := Natural'Value((1 => Line(Start)));
                        Start := Start + 1;
                    end loop;                       
                end;
                Row := Row + 1;
            end loop;    
            Close(F);

            for i in 1 .. Max_Lines loop
                for ii in 1 .. Len loop
                    declare
                        Lowest_Point : Boolean := True;
                        Left : constant Natural := ii - 1;
                        Rigth : constant Natural := ii + 1;
                        Up : constant Natural := i - 1;
                        Down : constant Natural := i + 1;
                    begin
                        if Left > 0 then
                            if Content(i,ii) >= Content(i, Left) then
                                Lowest_Point := False;
                            end if;
                        end if;
                        if Rigth <= Len then
                            if Content(i,ii) >= Content(i, Rigth) then
                                Lowest_Point := False;
                            end if;
                        end if;
                        if Up > 0 then
                            if Content(i,ii) >= Content(Up, ii) then
                                Lowest_Point := False;
                            end if;
                        end if;
                        if Down <= Max_Lines then
                            if Content(i,ii) >= Content(Down, ii) then
                                Lowest_Point := False;
                            end if;
                        end if;

                        if Lowest_Point = True then
                            Sum := Sum + Content(i,ii) + 1;
                        end if;
                    end;
                end loop;
            end loop;

            Put_Line ("Sum: " & Natural'Image(Sum));
        end;


        
    end Read_File;
    
begin

    Read_File;

end Main;