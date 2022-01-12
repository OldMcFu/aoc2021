with Ada.Text_IO;

package body Child_1 is


procedure Print (This : Child_1_T) is
    
begin
    Ada.Text_IO.Put_Line("Hallo Child 1 " & Integer'Image(This.text));
end Print;

end Child_1;