with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings;

with Ada.Strings.Unbounded;

procedure Main is

    type Bingo_Field_Type is array (1 .. 5, 1 .. 5) of Natural;
    package Bingo_Field_Vectors is new
        Ada.Containers.Vectors
        (Index_Type   => Natural,
            Element_Type => Bingo_Field_Type);

    package Natural_Vectors is new
        Ada.Containers.Vectors 
        (   Index_Type => Natural,
            Element_Type => Natural);

    
    Bingo_Numbers : Natural_Vectors.Vector := Natural_Vectors.Empty_Vector;
    Bingo_Fields  : Bingo_Field_Vectors.Vector := Bingo_Field_Vectors.Empty_Vector;
    Sum : Natural := 0;

    procedure Read_File(
        Bingo_Numbers : in out Natural_Vectors.Vector;
        Bingo_Fields  : in out Bingo_Field_Vectors.Vector
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
        tmp : Bingo_Field_Type;
        first_dim_cnt : Natural := 1;
        First_Empty_Line : Boolean := True;
        
    begin
        
        Open (F, In_File, File_Name);
        Line    := To_Unbounded_String (Get_Line (F));
        Start   := To_String (Line)'First;
        Finish  := 0;

        while Start <= To_String (Line)'Last loop
            Find_Token (Line, To_Set(','), Start, Ada.Strings.Outside, Start, Finish);
            exit when Start > Finish;
            Bingo_Numbers.Append (Natural'Value(To_String (Line)(Start .. Finish)));
            Start := Finish + 1;
        end loop;

        loop
            Line := To_Unbounded_String (Get_Line (F));
            declare
                second_dim_cnt : Natural := 1;
            begin
                if To_String (Line) = "" then
                    second_dim_cnt  := 1;
                    first_dim_cnt := 1;
                    if First_Empty_Line = False then 
                        Bingo_Fields.Append (tmp);
                    end if;
                    First_Empty_Line := False;
                else
                    Start := To_String (Line)'First;
                    Finish  := 0;
                    while Start <= To_String (Line)'Last loop
                        Find_Token (Line, To_Set(' '), Start, Ada.Strings.Outside, Start, Finish);
                        exit when Start > Finish;
                        tmp(first_dim_cnt, second_dim_cnt) := Natural'Value(To_String (Line)(Start .. Finish));
                        Start := Finish + 1;
                        second_dim_cnt := second_dim_cnt + 1;
                    end loop;
                    first_dim_cnt := first_dim_cnt + 1;                
                end if;
            end;
            exit when End_Of_File (F);
        end loop;
        Close(F);
    end Read_File;

begin

    Read_File (Bingo_Numbers, Bingo_Fields);

    Main_Loop:
    for BN of Bingo_Numbers loop
        for BF of Bingo_Fields loop
            for Row in 1 .. 5 loop
                Sum := 0;
                for Col in 1 .. 5 loop
                    if BN = BF(Row,Col) then 
                        BF(Row,Col) := 0;
                    end if;
                    Sum := Sum + BF(Row,Col);
                    if Sum = 0 and Col = 5 then
                        Put_Line ("------------------------------");
                        Put_Line ("---------BINGO----------------");
                        Put_Line ("------------------------------");
                        Put_Line ("Last Bingo Number: " & Natural'Image(BN));
                        
                        for X in 1 .. 5 loop
                            for XX in 1 .. 5 loop
                                Put (" " & Natural'Image(BF(X,XX)) & " ");
                                Sum := Sum + BF(X,XX); 
                            end loop;
                        Put_Line ("");
                        end loop;
                        Put_Line("");
                        Put_Line("Sum: " & Natural'Image(Sum));
                        Put_Line("Result = Sum * Called_Number: " & Natural'Image(Sum*BN));
                        exit Main_Loop;
                    end if;
                end loop;
            end loop;
        end loop;
    end loop Main_Loop;

end Main;