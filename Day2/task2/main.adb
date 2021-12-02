with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
procedure Main is
   F    : File_Type;
   File_Name : constant String := "input";
   Horizontal, Depth, Aim, Dummy: Integer := 0;
   Pattern1 : constant String := "forward ";
   Pattern2 : constant String := "down ";
   Pattern3 : constant String := "up ";
   Line :  Unbounded_String;

begin

   Open (F, In_File, File_Name);
   while not End_Of_File (F) loop
    Line := To_Unbounded_String(Get_Line (F));
        if Index (Line, Pattern1) > 0 then
            Dummy := Character'Pos (To_String(Line)(9)) - 48;
            Horizontal := Horizontal + Dummy;
            Depth := Depth + (Aim * Dummy);
        elsif Index (Line, Pattern2) > 0 then
            Dummy := Character'Pos (To_String(Line)(6)) - 48;
            Aim := Aim + Dummy;
            --Depth := Depth + Dummy;
        elsif Index (Line, Pattern3) > 0 then 
            Dummy := Character'Pos (To_String(Line)(4)) - 48;
            Aim := Aim - Dummy;
            --Depth := Depth - Dummy;            
        else
            null;
        end if;
    Put_Line (Integer'Image(Dummy));
   end loop;
   
   Put_Line ("Depth Value is: " & Integer'Image(Depth));
   Put_Line ("Horizontal Value is: " & Integer'Image(Horizontal));

   Put_Line ("Multi Value is: " & Integer'Image(Depth * Horizontal));

  
   Close (F);

end Main;