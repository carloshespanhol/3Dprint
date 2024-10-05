fit=0.5;
pressfit=0.25;
tol=0.2;

m3=3.2+tol;
m3_nut=5.5+tol;

m5=5.5;

layer_height=0.2;

axis_diam=8;
bush_width=13;
ybush_len=45;
xbush_len=50;
axis_distance=55;
thick_min=2;
r=(bush_width/2)+thick_min;
d=r*2;
dax=24; //15 center to axis

// distance from belts center to frame
upper_distance = dax + 13/2 + 3;   

/* Carriage Dimensions */
car_thick=8;
car_width=52.5;   // Min. 42mm
center_h=axis_distance-d;
thick= 6;

belt_size=6;
belt_distance=5; // internal space between belts
belt_thick=1.8;

center=axis_distance/2+r;
center_from_top= center;
center_screw_z=center_h/2-.5;

// Total height of hotend (top to nozzle tip) in mm (E3Dv6: ~63mm, Volcano: ~72mm)
hotend_height = 63;

Mountingpoint_width = 30;
