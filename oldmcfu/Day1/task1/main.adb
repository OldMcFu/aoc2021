with Ada.Text_IO; use Ada.Text_IO;


procedure Main is

   F    : File_Type;
   File_Name : constant String := "input";
   Last_Value, Actual_Value : Integer;
   Cnt : Integer := 0;
   First_Value : Boolean := True;

begin

   Open (F, In_File, File_Name);
   Put_Line("Page Length is: " & Count'Image(Page_Length));
   while not End_Of_File (F) loop
        if First_Value = True then
            Last_Value := Integer'Value (Get_Line (F));
            First_Value := False;
        else
            Actual_Value := Integer'Value (Get_Line (F));
            if Actual_Value > Last_Value then
                Cnt := Cnt + 1;
            end if;
            Last_Value := Actual_Value;
        end if;
   end loop;
   Put_Line ("Cnt Value is: " & Integer'Image(Cnt));
   Close (F);

end Main;