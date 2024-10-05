/* SuperSlicer */
fit=0.3;
pressfit=0.2;
tol=0.2;
/* PrusaSlicer *
fit=0.5;
pressfit=0.4;
tol=0.3;
/**/
m3=3.2+tol;
m3_nut=5.5+tol;

m5=5.25;
fc=5.25;   // frame chanel

layer_height=0.28;

/* Carriage Dimensions */
tbd=27; //top bottom depth
tbw=44;

car_thick=8;
car_width=44;   // Min. 42mm

axis_diam=8;
bush_width=15;
ybush_len=45;   //LM8LUU
xbush_len= car_width-4;
axis_distance=55;
thick_min=2;
r=(bush_width/2)+thick_min;
d=r*2;
dax=24; //15 center to axis

// distance from belts center to frame
upper_distance = dax + 13/2 + 3;   

center_h=axis_distance-d;
thick= 6;

belt_size=6;
belt_distance=3; // internal space between belts
belt_thick=1.4;

center=axis_distance/2+r;
center_from_top= center;
center_screw_z=center_h/2-.5;

// Total height of hotend (top to nozzle tip) in mm (E3Dv6: ~63mm, Volcano: ~72mm)
hotend_height = 72.6;

Mountingpoint_width = 30;
