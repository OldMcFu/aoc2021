
package Root is

type Root_T is abstract tagged null record;

type Root_Access is access all Root_T'Class;

procedure Init (This : out Root_Access; Cfg : in Integer);

procedure Print (This : Root_T)
is abstract;
    
end Root;