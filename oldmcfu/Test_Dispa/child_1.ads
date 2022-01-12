with Root;

package Child_1 is

type Child_1_T is new Root.Root_T with record
    text : Integer := 1;
end record;

overriding 
procedure Print(This : Child_1_T);

end Child_1;