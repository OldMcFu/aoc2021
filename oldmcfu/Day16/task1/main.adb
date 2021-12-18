with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Containers;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings;
with Ada.Integer_Text_IO;

with Ada.Strings.Unbounded;

procedure Main is

    procedure Eval_Literal_Value (Str: in String; Start : in out Positive) is
        Finish   : Positive := Str'Last;
    begin
        while Str(Start) = '1'  loop
            Start := Start + 5;
        end loop;
        Start := Start + 5;        
        
    end Eval_Literal_Value;

    procedure Eval_Operator (Str: in String; Start : in out Positive) is
        Finish   : Positive := Str'Last;
    begin
        
        if Str(Start) = '0' then
            Start := Start + 1;
            declare
                L : Positive := Integer'Value("2#" &Str ( Start .. Start+15) & "#");
            begin
                Start := Start + 15;
            end;
        else
            Start := Start + 1;
            declare
                L : Positive := Integer'Value("2#" &Str ( Start .. Start+11) & "#");
            begin
                Start := Start + 11;
            end;
        end if;
    end Eval_Operator;

   procedure Eval1 (Str : in String) is
      Start    : Positive := Str'First;
      Finish   : Positive := Str'Last;
      V, T, Res : Integer := 0;
   begin
        
        while Start < Finish loop
            V := Integer'Value("2#" &Str ( Start .. Start+2) & "#");
            Res := Res + V;
            Start := Start + 3;
            
            T := Integer'Value("2#" &Str ( Start .. Start+2) & "#");
            Start := Start + 3;

            if T = 4 then
                Eval_Literal_Value(Str, Start);
            else
                Eval_Operator(Str, Start);
            end if;
        end loop;

        Put_Line ("Sum of Versions: " & Integer'Image(Res));
   end Eval1;

    function Hex_To_Bin (Hex : in Character) return String is
    begin
        case Hex is
            when '0' => return "0000";
            when '1' => return "0001";
            when '2' => return "0010";
            when '3' => return "0011";
            when '4' => return "0100";
            when '5' => return "0101";
            when '6' => return "0110";
            when '7' => return "0111";
            when '8' => return "1000";
            when '9' => return "1001";
            when 'A' => return "1010";
            when 'B' => return "1011";
            when 'C' => return "1100";
            when 'D' => return "1101";
            when 'E' => return "1110";
            when 'F' => return "1111";
            when others => return "FUCK";
        end case;   
    end Hex_To_Bin;

    procedure Read_File is
        use Ada.Strings.Maps;
        use Ada.Strings.Unbounded;
        use Ada.Strings;
        F           : File_Type;
        File_Name   : constant String := "test";
    begin
        
        Open (F, In_File, File_Name);            
        declare
            Str : String := Get_Line (F);
            U_Str : Unbounded_String;
            Finish : Positive := Str'Last;
        begin

            for i in 1 .. Finish loop
                U_Str := U_Str & Hex_To_Bin (Str(i));
            end loop;
            Eval1(To_String(U_Str));
        end;
        Close(F);
    end Read_File;
    
begin

    Read_File;
end Main;