with Ada.Text_IO; use Ada.Text_IO;


procedure Main is

    F    : File_Type;
    File_Name : constant String := "input";
    Index_1, Index_2 : Positive_Count := 1;
    Cnt: Integer := 0;

    Value_1, Value_2 : Integer := 0;

    type Index is range 1 .. 4;
    Arr_Cnt : Index := 1;
    type My_Int_Array is
        array (Index) of Integer;
    Arr : My_Int_Array := (0, 0, 0, 0);

begin

    Open (F, In_File, File_Name);
    Arr(1) := Integer'Value (Get_Line (F));
    Arr(2) := Integer'Value (Get_Line (F));
    Arr(3) := Integer'Value (Get_Line (F));
    Arr(4) := Integer'Value (Get_Line (F));
    while not End_Of_File (F) loop

        if Arr(1) < Arr(4) then
            Cnt := Cnt + 1;
        end if;

        Arr (1 .. 3) := Arr (2 .. 4);
        Arr (4) := Integer'Value (Get_Line (F));

    end loop;
    if Arr(1) < Arr(4) then
        Cnt := Cnt + 1;
    end if;
   Put_Line ("Cnt Value is: " & Integer'Image(Cnt));
   Close (F);

end Main;