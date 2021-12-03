with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Integer_Text_IO;

procedure Main is
   F    : File_Type;
   File_Name : constant String := "input";
   High : constant Character := '1';
   Line :  String := "XXXXXXXXXXXX";
   Gamma_Rate, Epsilon_Rate : String  := "XXXXXXXXXXXX";

begin

   Open (F, In_File, File_Name);
   
   declare
    type Index_Type is range 1 .. Line'Length;
    type Int_Array_Type is array (Index_Type) of Integer;
    Arr : Int_Array_Type := (others => 0);
    Cnt : Integer := 0;
   begin

        while not End_Of_File (F) loop
            Line := Get_Line (F);
            Cnt := Cnt + 1;
            for I in 1 .. Integer(Line'Length) loop
                if Line(I) = High then
                    Arr(Index_Type(I)) := Arr(Index_Type(I)) +  1;
                else
                    null;
                end if;
            end loop;
        end loop;
        Gamma_Rate := Line;
        for I in Index_Type loop
            Put_Line(Integer'Image(Arr(I)));
            if Arr(I) > (Cnt/2) then
                Epsilon_Rate(Integer(I)) := High;
            else
                Epsilon_Rate(Integer(I)) := '0';
            end if;
        end loop;
    end;
    Put_Line ("Gamma_Rate: " & Gamma_Rate);
    Put_Line ("Epsilon_Rate: " & Epsilon_Rate);
    Put("Power: " & Integer'Image( Integer'Value("2#"&Gamma_Rate&"#") * Integer'Value("2#"&Epsilon_Rate&"#")  ) ); 
    Close (F);

end Main;