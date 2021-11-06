// https://www.youtube.com/watch?v=ed7T2NG7j38 Magnet LTD Ringbom Stirling engine
// https://www.youtube.com/watch?v=TzweLbneAXg Low Temperature Stirling Motor with neodym magnet
// https://www.youtube.com/watch?v=wGRmcvxB_dk How A Stirling Engine Works

// animate time=1 fps=25 steps=25 [x] Dump Pictures
// convert 'frame*.png' -set delay 1x25 animated.gif
// mpv -loop animated.gif

// small piston
dim_piston_worker    =  [ 10.0, 15.0    ]; // outer d, h of working piston

// big piston
dim_cylinder_worker  =  [ 10.1, 15.0, 1 ]; // inner d, h, thickness of working cylinder


dim_piston_mixer     =  [165.0, 10.0    ]; // outer d, h of mixer piston
dim_cylinder_mixer   =  [170.0, 25.0, 1 ]; // inner d, h, thickness of mixer cylinder
dim_magnet_mixer     =  [10, 5]; // d,h

pos_worker = [0,0,10];
dim_piston_worker_stroke = 6;
z_worker   = 4+dim_piston_worker_stroke/2*sin(360*$t);


pos_mixer  = [0,0,-10];
dim_piston_mixer_stroke = 5;
//if(dim_piston_mixer_stroke >= dim_piston_worker_stroke)
  print("warning: magnet won't detach because of dim_piston_mixer_stroke >= dim_piston_worker_stroke");
delta = 0.05;
smoothsq = (dim_piston_mixer_stroke/360)*atan(sin(360*$t+90)/delta);
//smoothsq = sign(sin(360*$t));
z_mixer    = dim_piston_mixer_stroke/2*smoothsq;

include <magnet.scad>

module piston_worker()
{
  //cylinder(d = dim_piston_worker[0], h = dim_piston_worker[1], $fn=32, center=true);
  magnet(d = dim_piston_worker[0], h = dim_piston_worker[1]);
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
  color(c=[0.3,0.6,0.3,0.99]) // rgba
  difference()
  {
    cylinder(d = dim_piston_mixer[0], h = dim_piston_mixer[1], $fn=64, center=true);
    cylinder(d = dim_magnet_mixer[0]+0.1, dim_piston_mixer[1]+0.1,center=true);
  }
  magnet(d=dim_magnet_mixer[0], h=dim_magnet_mixer[1]);
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

//color(c=[1,1,1,0.9]) // rgba
  translate(pos_worker+[0,0,z_worker])
    piston_worker();

color(c=[0.5,0.5,0.5,0.5])
  translate(pos_mixer)
    %cylinder_mixer();

  translate(pos_mixer+[0,0,z_mixer])
    piston_mixer();
