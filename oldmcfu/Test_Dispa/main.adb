With Ada.Text_IO;
with Root;
with Child_1;
with Child_2;

procedure Main is
    Obj : Root.Root_Access;
begin
    Root.Init(Obj, 1);
    Root.Print(Obj.all);

    Root.Init(Obj, 4);
    Root.Print(Obj.all);
  
end Main;