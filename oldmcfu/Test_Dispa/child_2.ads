with Root;

package Child_2 is

type Child_2_T is new Root.Root_T with record
    text : Integer := 2;
end record;

overriding 
procedure Print(This : Child_2_T);

end Child_2;