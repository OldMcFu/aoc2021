with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Integer_Text_IO;

procedure Main is
    F    : File_Type;
    File_Name : constant String := "input";
    Line, O2, CO2: String  := "000011000111";
    
    type index_type is range 0 .. 1000;
    type my_array_type is array (index_type) of Boolean;
    O2_array, CO2_array : my_array_type := (others => True);
    O2_Eliminate, CO2_Eliminate : Character := '1';
    O2_Cnt_High, O2_Cnt_All, CO2_Cnt_High, CO2_Cnt_All, Cnt_Index: index_type := 0;
    O2_Finish, CO2_Finish : Boolean := False;
begin

    for I in 0 .. 12 loop
        Open (F, In_File, File_Name);
        if O2_Cnt_High >= O2_Cnt_All/2 then
            O2_Eliminate := '0';
        else
            O2_Eliminate := '1';
        end if;

        if CO2_Cnt_High >= CO2_Cnt_All/2 then
            CO2_Eliminate := '1';
        else
            CO2_Eliminate := '0';
        end if;
        O2_Cnt_All := 0;
        O2_Cnt_High := 0;
        CO2_Cnt_All := 0;
        CO2_Cnt_High := 0;
        Cnt_Index := 0;
        while not End_Of_File (F) loop
            Line := Get_Line (F);
            if I = 0 then
                if Line(1) = '1' then
                    O2_Cnt_High := O2_Cnt_High + 1;
                    CO2_Cnt_High := CO2_Cnt_High + 1;
                end if;
                O2_Cnt_All := O2_Cnt_All + 1;
                CO2_Cnt_All := CO2_Cnt_All + 1;
            else
                if O2_array(Cnt_Index) = True and O2_Finish = False then
                    if O2_Eliminate = Line(I) then
                        O2_array(Cnt_Index) := False;
                    else
                        O2_Cnt_All := O2_Cnt_All + 1;
                        O2 := Line;
                    end if;

                    if O2_array(O2_Cnt_All) = True and Line(I) = '1' then
                        O2_Cnt_High := O2_Cnt_High + 1;
                    end if;
                end if;

                if CO2_array(Cnt_Index) = True and CO2_Finish = False then
                    if CO2_Eliminate = Line(I) then
                        CO2_array(Cnt_Index) := False;
                    else
                        CO2_Cnt_All := CO2_Cnt_All + 1;
                        CO2 := Line;
                    end if;

                    if CO2_array(CO2_Cnt_All) = True and Line(I) = '1' then
                        CO2_Cnt_High := CO2_Cnt_High + 1;
                    end if;
                end if;
            end if;
            Cnt_Index := Cnt_Index + 1;
        end loop;
        Close (F);
        if O2_Cnt_All = 1 then O2_Finish := True; end if;
        if CO2_Cnt_All = 1 then CO2_Finish := True; end if;
    end loop;    

    Put_Line (O2 & "    " & index_type'Image(O2_Cnt_All));    
    Put_Line (CO2 & "    " & index_type'Image(CO2_Cnt_All));   
    
    Put("Result: " & Integer'Image( Integer'Value("2#"&O2&"#") * Integer'Value("2#"&CO2&"#")  ) ); 

end Main;