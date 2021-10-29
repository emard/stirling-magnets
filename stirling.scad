// small piston
dim_piston_worker    =  [ 10.0, 15.0    ]; // outer d, h of working piston
dim_piston_worker_stroke = 10;

// big piston
dim_cylinder_worker  =  [ 10.1, 15.0, 1 ]; // inner d, h, thickness of working cylinder


dim_piston_mixer     =  [ 70.0,  3.0    ]; // outer d, h of mixer piston
dim_cylinder_mixer   =  [ 72.0, 10.0, 1 ]; // inner d, h, thickness of mixer cylinder

pos_worker = [20,0,10];
dim_piston_worker_stroke = 6;
z_worker   = 4+dim_piston_worker_stroke/2*sin(360*$t);


pos_mixer  = [0,0,-10];
z_mixer    = sin(360*$t + 90);

module piston_worker()
{
  cylinder(d = dim_piston_worker[0], h = dim_piston_worker[1], $fn=32, center=true);
}

module cylinder_worker()
{
  difference()
  {
    cylinder(d = dim_cylinder_worker[0]+dim_cylinder_worker[2], h = dim_cylinder_worker[1], $fn=64, center=true);

    cylinder(d = dim_cylinder_worker[0], h = dim_cylinder_worker[1]+0.1, $fn=64, center=true);
  }
}

module piston_mixer()
{
  cylinder(d = dim_piston_mixer[0], h = dim_piston_mixer[1], $fn=64, center=true);
}

module cylinder_mixer()
{
  difference()
  {
    cylinder(d = dim_cylinder_mixer[0]+dim_cylinder_mixer[2], h = dim_cylinder_mixer[1], $fn=64, center=true);

    cylinder(d = dim_cylinder_mixer[0], h = dim_cylinder_mixer[1]+0.1, $fn=64, center=true);
  }
}

color(c=[0.5,0.5,0.5,0.5])
  translate(pos_worker)
    %cylinder_worker();

color(c=[1,1,1,0.9]) // rgba
  translate(pos_worker+[0,0,z_worker])
    piston_worker();

color(c=[0.5,0.5,0.5,0.5])
  translate(pos_mixer)
    %cylinder_mixer();

color(c=[0.3,0.6,0.3,0.99]) // rgba
  translate(pos_mixer+[0,0,z_mixer])
    piston_mixer();
