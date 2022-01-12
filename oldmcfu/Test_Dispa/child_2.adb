with Ada.Text_IO;

package body Child_2 is


procedure Print (This : Child_2_T) is
    
begin
    Ada.Text_IO.Put_Line("Hallo Child 2 " & Integer'Image(This.text));
end Print;

end Child_2;