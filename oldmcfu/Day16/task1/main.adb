-- test unbounded string with vector

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
With Ada.Text_IO.Unbounded_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure ubt is
   package My_Vector is new Ada.Containers.Vectors (Natural,
     Unbounded_String);
   use My_Vector;
   package SUIO renames Ada.Text_IO.Unbounded_IO;

   -- read input file and add each line into str_pool till file end
   procedure read_input (str_pool : in out My_Vector.Vector;
                         File     : File_Type) is
   begin
      loop
         str_pool.Append (SUIO.Get_Line (File));
      end loop;
   exception
      when End_Error =>
         null;
   end read_input;

   File : File_Type;
   str_pool : My_Vector.Vector;
begin
   Put_Line ("Argument 1 is : " & Argument (1));
   Open (File, In_File, Argument (1));
   read_input (str_pool, File);
   Close (File);

   Put_Line ("Total line: " & str_pool.Length'Img);
   Put_Line ("File content:");
   for i in  0 .. Integer(str_pool.Length) - 1 loop
      SUIO.Put_Line (str_pool.Element(Integer(i)));
   end loop;

   str_pool.Clear;
end ubt;