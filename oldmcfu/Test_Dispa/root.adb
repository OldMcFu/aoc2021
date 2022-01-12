with Ada.Text_IO;
with Child_1;
with Child_2;

package body Root is

procedure Init (This : out Root_Access; Cfg : in Integer) is

begin

    if Cfg = 1 then
        This := new Child_1.Child_1_T;
    else
        This := new Child_2.Child_2_T;
    end if;
    
end Init;

end Root;