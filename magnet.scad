
module magnet(d,h)
{
  color([0.5,0.5,1]) // blue, north
  translate([0,0,h/4])
    cylinder(d=d,h=h/2,$fn=32,center=true);
  color([1,0.5,0.5]) // red, south
  translate([0,0,-h/4])
    cylinder(d=d,h=h/2,$fn=32,center=true);
}

