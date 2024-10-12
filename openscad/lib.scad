use <sc.scad>

$fn=200;
fit=0.6;
az=0.01; //anti z fight

module on_arc(radius, angle) {
    x = radius - radius * cos(angle);
    y = radius * sin(angle);
    translate([x,y,0])
        rotate([0,0,-angle])
            children(0);
}

module on_arc_example() {
    union() {
        for(a = [0 : 30 : 180]) {
            on_arc(10, a) rotate([0,45,0]) cube([3,2,1]);
        }
    }
}

module corner(t=5,w=20,lx=20,lz=20){
    vt=4.3;
    color("lightgrey")
    difference(){
        union(){
            cube([lx,w,t]);
            cube([t,w,lz]);
            for ( i = [0 : 20 : w-1] ){
                translate([t,i,t])
                fillet(lx-t,vt,lz-t);

                translate([t,20-vt+i,t])
                fillet(lx-t,vt,lz-t);
            }
        }
        //--------------------------------
        for ( i = [10 : 20 : w] ){
            translate([(lx-t)/2+t,i,5])
            Mscrew(20,5.4,v=1);
           
            if(lz == 20){
                translate([5,i,lz/2])
                rotate([0,90,0])
                Mscrew(20,5.4,v=1);
            }else{
                translate([5,i,(lz-t)/2+t])
                rotate([0,90,0])
                Mscrew(20,5.4,v=1);
            }
        }        
    }
}

module hex(s=6, h=10){
    d=s/(sqrt(3)/2);
    cylinder(d=d, h=h, $fn=6);
}

module repeat_grid(n_times_xyz, by_length_xyz, center=false) {
  I = n_times_xyz;
  B = by_length_xyz;
  c = center ? 1 : 0;
  for (x = [0:1:max(I[0]-1, 0)],
      y = [0:1:max(I[1]-1, 0)],
      z = [0:1:max(I[2]-1, 0)]) {
    translate([B[0]*(x - c*max(I[0]-1, 0)/2),
               B[1]*(y - c*max(I[1]-1, 0)/2),
               B[2]*(z - c*max(I[2]-1, 0)/2)])
      children(0);
  }
}

//Round box on all sides
module rbox(wx, wy, wz, radius) {
	hull() {
        translate([radius, radius, radius])
			sphere(r=radius);

		translate([radius, radius, wz-radius])
			sphere(r=radius);

        //--
		translate([wx-radius, radius, radius])
			sphere(r=radius);

		translate([wx-radius, radius, wz-radius])
			sphere(r=radius);

        //--
		translate([wx-radius, wy-radius,radius])
			sphere(r=radius);

		translate([wx-radius, wy-radius, wz-radius])
			sphere(r=radius);

        //--
		translate([radius,wy-radius,radius])
			sphere(r=radius);

		translate([radius, wy-radius, wz-radius])
			sphere(r=radius);
	}
}

module chamfer_r(rf=2, re=10) {
	translate([0,0,-az]){
		difference(){
			union(){
                rotate_extrude(angle=360){
                    translate([re-rf,0,0]){ 
                        difference(){
                            rotate ([0,0,180]) 
                            translate([-rf-az,-rf-az,0]) 
                            square([rf+az,rf+az]);
                            //-------------------------
                            rotate([0,0,45])
                            square(rf*2);
                        }
                    }
                }
            }
        }
    }
}

// fillet bottom
// l = length
// r = radius
module fillet_b(l,r){
    difference(){
        translate([-az,-az,-az])
        cube([l+az*2,r+az,r+az]);
        //-------------------------
        translate([-az*2,r,r])
        rotate([0,90,0])
        cylinder(r=r,h=l+az*4);
    } 
} 

// fillet_r round edge
// rf = radius of fillet
// re = radius of edge
// i= insideout 1 = outside, -1 = inside
module fillet_r(rf,re){
	translate([0,0,-az]){
		difference(){
			union(){
                rotate_extrude(angle=360){
                    translate([re-rf,0,0]){ 
                        difference(){
                            rotate ([0,0,180]) 
                            translate([-rf-az,-rf-az,0]) 
                            square([rf+az,rf+az]);
                            //-------------------------
                            translate([0,rf,0])
                            circle(rf);
                        } //end difference	
					} //end translate
                } //end extrude	
			} //end union
		} //end difference
	} //end translate	
} //end module

module fillet_90(s){
    at=60;
	translate([0,0,-az]){
		difference(){
			union(){
                rotate_extrude(angle=90)
                {
                    translate([0,0,0]){ 
                        difference(){
                            rotate ([0,0,180]) 
                            translate([-s,-s]) 
                            square([s,s]);
                            //-------------------------
                            h=sqrt(s^2+s^2);        
                            r=((h/2)/cos(at));
                            a=180-(acos(s/h)+at);
                            translate([s+r*cos(a)+az,sin(a)*r+az])
                            circle(r);
                        } //end difference	
					} //end translate
                } //end extrude	
			} //end union
		} //end difference
	} //end translate	
} //end module

module fcylinder(r,h,f=1){
    difference(){
        cylinder(r=r,h=h);
        //-------------------
        fillet_r(f,r);
        
        Tz(h)
        mirror([0,0,1])
        fillet_r(f,r);
    }
}

module fcube(x,y,z,f=1){
    difference(){
        cube([x,y,z]);
        //-------------------
        fillet_b(x,f);
        
        translate([0,y,0])
        mirror([0,1,0])
        fillet_b(x,f);

        rotate([0,0,90])
        mirror([0,1,0])
        fillet_b(y,f);

        translate([x,0,0])
        rotate([0,0,90])
        fillet_b(y,f);
    }
}

module rcube(length,width,height,r=.5){ 
    l=length-2*r;
    w=width-2*r;    
    translate([r,r,0]){
        cylinder(r=r,h=height);    
        translate([0,w,0])
        cylinder(r=r,h=height);    
        translate([l,0,0])
        cylinder(r=r,h=height);    
        translate([l,w,0])
        cylinder(r=r,h=height);    
    }
    // Inner cubes
    translate([0,r,0])
    cube([length,w,height]);
    translate([r,0,0])
    cube([l,width,height]);
}

// bottom fillet round cube
module frcube(length,width,height,r=.5,f=.8){ 
    l=length-2*r;
    w=width-2*r;    
    translate([r,r,0]){
        fcylinder(r,height,f);    
        translate([0,w,0])
        fcylinder(r,height,f);    
        translate([l,0,0])
        fcylinder(r,height,f);    
        translate([l,w,0])
        fcylinder(r,height,f);    
    }
    difference(){
        // Inner cubes
        union(){
            translate([r,0,0])
            cube([l,width,height]);
            translate([0,r,0])
            cube([length,w,height]);
        }
        //-------------------------------
        translate([r,0,0]){
            fillet_b(l,f);
            translate([0,width,0])
            mirror([0,1,0])
            fillet_b(l,f);        
        }
        translate([0,r,0]){
            rotate([0,0,90])
            mirror([0,1,0])
            fillet_b(w,f);
            translate([length,0,0])
            rotate([0,0,90])
            fillet_b(w,f);
        }
    }
}

module round_plane(x,y,t){
    x=x-t*2;
    y=y-t*2;
    
    translate([t,t,0])
    difference(){
        union(){
            for( a =[[0,0],[x,0],[0,y],[x,y]] ){
                translate(a)
                sphere(r=t);
            }
            for( a =[[0,0],[0,y]] ){
                translate(a)
                rotate([0,90,0])
                cylinder(r=t, h=x);
            }
            for( a =[[0,0],[x,0]] ){
                translate(a)
                rotate([-90,0,0])
                cylinder(r=t, h=y);
            }
            cube([x,y,t]);
        }
        //------------------------------
        translate([-t*2,-t*2,-t-az])
        cube([x+t*4,y+t*4,t+az]);
    }
}

module roundcube(x,y,z,r=1){
    x=x-r*2;
    y=y-r*2;
    z=z-r*2;
    
    translate([r,r,r])
    difference(){
        union(){
            // Spheres
            for( a =[ [0,0],[x,0],[0,y],[x,y],
                      [0,0,z],[x,0,z],[0,y,z],[x,y,z] ] ){
                translate(a)
                sphere(r=r);
            }
            // X cylinder
            for( a =[ [0,0],[0,y],
                      [0,0,z],[0,y,z] ] ){
                translate(a)
                rotate([0,90,0])
                cylinder(r=r, h=x);
            }
            // Y cylinder
            for( a =[ [0,0],[x,0],
                      [0,0,z],[x,0,z] ] ){
                translate(a)
                rotate([-90,0,0])
                cylinder(r=r, h=y);
            }
            // Z cylinder
            for( a =[ [0,0],[x,0],
                      [0,y],[x,y] ] ){
                translate(a)
                cylinder(r=r, h=z);
            }
            // Inner cubes
            translate([-r,0,0])
            cube([x+r*2,y,z]);
            
            translate([0,-r,0])
            cube([x,y+r*2,z]);
            
            translate([0,0,-r])
            cube([x,y,z+r*2]);
        }
    }
}

module ring(ro,ri,h){
    difference(){
        cylinder(r=ro, h=h);
        
        translate([0,0,-.1])
        cylinder(r=ri, h=h+1);
    }
}    
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180/n])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module pin(length, width, height, type=0, slack=0, tension = 3, bulge=0.8)
{
    radius = min(width/2+bulge+slack, length/2);
    echo(radius);
    w=width+slack*2;
    difference(){
        union(){
            translate([0,-w/2,0])
            cube([length-radius, w, height]);
            cylinder(d=radius*2, h=height, $fn=100);
        }
        
        if(type==0){
            translate([w/2, 1, -.1])
            hull()  {
                cylinder(d=0.5, h=height+1, $fn=50);

                translate([0,length,-.1])
                cylinder(d=tension, h=height+1, $fn=50);
            }    
        }
    }
}

module rpol(d, h, s=6, r=2){
    difference(){
        a=360/s;
        l=(d/2 - r) / cos(360/s/2);
        
        for(i=[1:s]){
            hull(){
                x=cos(a)*l;
                y=sin(a)*l;
                translate([x,y,0])
                cylinder(r=r, h=h);
                
                x2=cos(a*(i+1))*l;
                y2=sin(a*(i+1))*l;
                translate([x2,y2,0])
                cylinder(r=r, h=h);

                x3=cos(a*(i+2))*l;
                y3=sin(a*(i+2))*l;
                translate([x3,y3,0])
                cylinder(r=r, h=h);
            }
        }
    }        
}

module spacer(di, do, h){
    difference(){
        cylinder(d=do, h=h);
        translate([0,0,-.1])
        cylinder(d=di, h=h+1);
    }        
}

// rotate as per a, v, but around point pt
module rotate_z(a, pt) {
    translate(pt)
        rotate([0,0,a])
            translate(-pt)
                children();   
}

            
/*** Supports ***/
module support(x,y,z,lineWidth=0.4,m=0,c=0){
    lw=lineWidth*0.9;
    if(c==1){
        difference(){
            scube(x,y,.2);
            
            translate([lw,lw,-.1])
            scube(x-lw*2,y-lw*2,.4);
        }
    }
    if(x > y){
        if(m > 0){
            translate([x,0,0])
            mirror([1,0,0])
            supportx(x,y,z,lw);
        }else{
            supportx(x,y,z,lw);
        }
    }else{        
        if(m > 0){
            translate([x,0,0])
            mirror([1,0,0])
            supporty(x,y,z,lw);
        }else{
            supporty(x,y,z,lw);
        }
    }
}    
module supporty(x,y,z,lw){
    ini_dist = 1.2;
    ui  = lw*2+ini_dist*2;
    iy = floor(multiple(ui, y)); 
    n  = floor(iy / ui);

    sup_dist = (iy - ((n*lw*2)+lw)) / (n*2) ;
    echo(sup_dist);
    u = lw*2+sup_dist*2;
    
    color("cyan")
    difference(){
        scube(x,y,z);

        for(i=[0:n-1]){
            translate([0,u*i,0]){
                translate([lw, lw, -.5]) 
                scube(x, sup_dist, z+1);
                
                translate([-lw, lw*2+sup_dist, -.5]) 
                scube(x, sup_dist, z+1);
            }
        }
    }
}
module supportx(x,y,z,lw){
    ini_dist = 1.2;
    ui  = lw*2+ini_dist*2;
    ix = floor(multiple(ui, x)); 
    n  = floor(ix / ui);

    sup_dist = (ix - ((n*lw*2)+lw)) / (n*2) ;
    echo(sup_dist);
    u = lw*2+sup_dist*2;
    
    color("cyan")
    difference(){
        scube(x,y,z);

        for(i=[0:n]){
            translate([u*i,0,0]){
                translate([lw, lw, -.5]) 
                scube(sup_dist, y, z+1);
                
                translate([lw*2+sup_dist, -lw, -.5]) 
                scube(sup_dist, y, z+1);
            }
        }
    }
}
//--------------------------------------------------
module letter(l) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = letter_height) {
		text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
	}
}

function multiple(Size,Unit) = Unit * ceil(Size / Unit);

module rough_skin(w,l,h,base,top){
    for(i=[0:(l/base)-1]){
        translate([w/2,base/2+base*i,h/2])
        quady(base,top,h,w,true);
    }    
}
module show_planes(planes){
    size=len(planes);
    for(i=[0:size-1]){
        translate( [planes[i][1],planes[i][2],planes[i][3]])
        rotate([planes[i][0],0,0])
        rcube(planes[i][4],planes[i][5],planes[i][6]);        
    }    
}

module oval(w,h, height, center = false) {
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}


// mounting plate for nema 17
module nema17_mount(base_height,extruder=true)
{
// avoid openscad artefacts in preview
epsilon = 0.01;
// increase this if your slicer or printer make holes too tight
extra_radius = 0.1;
// nema 17 dimensions
nema17_width = 42.3;
nema17_hole_offsets = [
	[-15.5, -15.5, 1.5],
	[-15.5,  15.5, 1.5],
	[ 15.5, -15.5, 1.5],
	[ 15.5,  15.5, 1.5 ]
];
drive_gear_outer_radius = 8.00 / 2;
    
// major diameter of metric 3mm thread
m3_major = 3;
m3_radius = m3_major / 2 + extra_radius;
m3_wide_radius = m3_major / 2 + extra_radius + 0.2;

// diameter of metric 3mm hexnut screw head
m3_head_radius = 3 + extra_radius;

    
	// settings
	width = nema17_width;
	height = base_height;
	edge_radius = 27;
	axle_radius = drive_gear_outer_radius + 1 + extra_radius;

	difference()
	{
		// base plate
		translate([0, 0, height / 2])
			intersection()
			{
				cube([width, width, height], center = true);
                if(extruder){
				cylinder(r = edge_radius, h = height + 2 * epsilon, $fn = 128, center = true);
                }
			}
		
		// center hole
		translate([0, 0, -epsilon]	)
			cylinder(r = 11.25 + extra_radius, h = height+1, $fn = 32);

		/* axle hole */
		translate([0, 0, -epsilon])
			cylinder(r = axle_radius, h = height + 2 * epsilon, $fn = 32);

		/* mounting holes */
		for (a = nema17_hole_offsets)
			translate(a)
			{
				cylinder(r = m3_radius, h = height * 4, center = true, $fn = 16);
				cylinder(r = m3_head_radius, h = height + epsilon, $fn = 16);
			}
	}
}

module joint(Breite, Tiefe, Radius)  {
	translate([0, -Radius, 0])
	difference()  {
		cube([Radius*2+Breite, Radius, Radius+Tiefe]);

		for (x=[0, Radius*2+Breite]) {		// left and right
			translate([x, 0, -0.01])
			rotate([0, 0,  90])
			cylinder(Radius+Tiefe, Radius, Radius);
		}

		translate([0, 0, Tiefe+Radius])		// front
		rotate([0, 90, 0])
		cylinder(Radius*2+Breite, Radius, Radius);
	}
}

module semi_circle(d=2, h=2){
    difference(){
        cylinder(d=d, h=h);
    
        translate([-d,-d, -.1])
        scube(d*2, d, h+1);
    }
}

module circle_arrange(d1,d2,len,var=0,n=3,a=0){
    for (i=[0:n-1])
    {
        rotate([0,0,i*360/n+a])
        translate([d2/2+d1/2+var,0,0])
        cylinder(d=d1, h=len);
    }
}    
/* Cubes */
module scube(x,y,z){
    cube([x,y,z]);
}
module cube45(x,y,z){
    hull(){
        cube([x,y,z]);
        
        translate([x+y,0,0])
        cube([.1,.1,z]);
    }
}

module vcube45(x,y,z){
    hull(){
        cube([x,y,z]);
        
        translate([x+z,0,0])
        cube([.1,y,.1]);
    }
}
/*
module vrcubex(x,y,z,radius=.5,chamfer=0){
    translate([x,0,0]) 
    rotate([0,0,90])
    vrcube(y, x, z, radius,chamfer);
} 
*/   
module vrcube(x,y,z,radius=.5,chamfer=0){
    translate([x,0,0]) 
    rotate([90,0,180])
    rcube(x, z, y,radius);
}    
module rccube(length,width,height,radius=.5,chamfer=0){    
    translate([-length/2, -width/2, -height/2])
    rcube(length,width,height,radius);
}
/* Cylinders */
//pcylinder(d=16.34, h=4*4, v=1);   
module pcylinder(d,h, v=1){
    if(v==1){
        rotate([-90,0,180])
        vcylinder(d,h);
    }else{
        cylinder(d=d,h=h);
    }
}
module vcylinder(d,h){
    rotate([90,0,0])
    difference(){
        hull(){
            translate([0,d*.6,0])
            cylinder(h=h,d=d/10);
            
            cylinder(h=h,d=d);
        }    
        
        translate([-d/2,d/2,-.1])
        cube([d,d,h+1]);
    }
}

/* Chamfers and Fillets */
module chamfer(s=1, t=1) {
    hull() {
        cube([s, t, .1]);
        
        cube([.1, t, s]);
    }
}
module fillet(sx=1, t=1, sz=0) {
    if(sz==0){
        sz=sx;
        _fillet(sx,t,sz);
    }else{
        _fillet(sx,t,sz);
    }
}
/* Condition: sx > sz *
module _fillet(sx, t, sz) {
    difference() {
        cube([sx, t, sz]);
        r=(sz^2+sx^2)/sz/2;
        translate([sx,-0.1,r])
        rotate([-90,0,0])
        cylinder(r=r, h=t*2);
    }
}
/**/
module _fillet(sx, t, sz) {
    at=60;
    difference() {
        cube([sx, t, sz]);
        //----------------------
        h=sqrt(sx^2+sz^2);        
        r=((h/2)/cos(at));
        a=180-(acos(sx/h)+at);
        translate([sx+r*cos(a),-0.1,sin(a)*r])
        rotate([-90,0,0])
        cylinder(r=r, h=t*2);
    }
}

/* Triangles */
module rtriangle(base,depth,angle=45,maxheight=100) {  
    difference(){
        cube([base,maxheight,depth]);
        
        translate([base,0,-0.1]) 
        rotate([0,0,angle]) 
            cube([base*15,maxheight*10,depth*2]);
    }
}

module eqtriangle(size, depth){
    h=(size* sqrt(3))/2;
    r=size/sqrt(3);
    translate([size/2,h/3,0])
    rotate([0,0,-30])
    cylinder(r=r, h=depth, $fn=3);
} 

module isotriangle(base,depth,angle=45,maxheight=100) {  
    translate([-.01,0,0])
    rtriangle(base/2,depth,angle,maxheight);
    mirror([1,0,0])
    rtriangle(base/2,depth,angle,maxheight);
}

module oblong(len,width,height){
    translate([width/2,0,0])
    union(){
        cube([len-width,width,height]);
        translate([0,width/2,0]) cylinder(h=height, d=width);
        translate([len-width,width/2,0]) cylinder(h=height, d=width);
    }
}

/* Screws and Nuts */
module Mscrew(l=10, d = "undefined", b=0, v=0, hh=4, he=true){
    // Cap Screw
    if (d == "undefined") {
        screw(l, 3, b, v,hh,he);
    }else{
        screw(l, d, b, v,hh,he);
    }
}    

module screw(length=10, d=3, b=0, v=0, hh=4, he=true){    
    //head_height = 1.2*d;
    head_height = hh;
    head_width = 2*d;  
    
    difference(){
        union(){
    translate([0,0, head_height])
    rotate([180,0,0]){
        pcylinder(h=length+head_height, d=d+fit, v=v); 
        // head
        pcylinder(h=head_height, d=head_width+fit, v=v);
        
        if(he){
            translate([0,0,-length])
            pcylinder(h=length+head_height, d=head_width+fit, v=v);
        }
    }
        }
    // Bridge
    if(b){
        translate([0,0,0])
        #pcylinder(h=.24, d=head_width+fit, v=v);        
    }
    }    
}

module Mnut(b=true, di="undefined", l=12, pos=0){
    if (di == "undefined") {
        nut(b, 3, l, pos);
    }else{
        nut(b, di, l, pos);
    }
}   

module nut(b=true, di, l=12, pos=0){    
    do=2*di;
    difference(){
        union(){
            // Nut
            translate([0,0,pos])
            cylinder(h=l, d=do+fit, $fn=6);
            // screw
            translate([0,0,-l*2])
            cylinder(h=l*6, d=di+fit);
        }
        
        // Bridge
        if(b){
            translate([0,0,pos+l])
            cylinder(h=.3, d=do+fit);        
            translate([0,0,pos])
            cylinder(h=.3, d=do+fit);        
        }
    }
}

module MnutPocket(s=15, di=3, b=0){
    do=2*di;
    w=1.9*di;
    l=1.1*di;  
    difference(){  
        union()
        {
            //Nut
            rotate([0,0,30])
            cylinder(h=l, d=do+fit, center=false, $fn=6);
            
            // Pocket
            translate([-w/2,0,0])
            cube([w,4*w,l]);
            
            if(s>0){
                translate([0,0,-s/2])
                cylinder(h=s,d=di+fit);
            }
        }

        // Bridge
        if(b>0){
            translate([0,0,-.2])
            cylinder(h=.3, d=do+fit);        

            if(b>1){
                translate([0,0,l])
                cylinder(h=.3, d=do+fit);        
            }
        }
    }
}

module roundedCube(len,width,height,radius=.5){
    translate([-len/2,-width/2,-height/2])
    if( height<(2*radius) ){
        intersection(){
            translate([radius,radius,radius])
            minkowski()
            {
              cube([len-(2*radius),width-(2*radius),height-radius]);
              sphere(r=radius);
            }
            cube([len,width,height]);            
        }
    }else{
        translate([radius,radius,radius])
        minkowski()
        {
          cube([len-(2*radius),width-(2*radius),height-(2*radius)]);
          sphere(r=radius);
        }
    }
}    

/*******************************************
module quad(l1,l2,h,d,c=false){
    quadz(l1,l2,h,d,c);
}
/*
module quadz(l1,l2,h,d,c=false){
        hull(){
            if(c==true){
                translate([0,-h/2,0])
                cube([l1,.01,d],true);    
            }else{
                cube([l1,.01,d],false);    
            }
            if(c==true){
                translate([0,h/2,0])
                cube([l2,.01,d],true);  
            }else{
                translate([0,h,0])
                cube([l2,.01,d],false);  
            }
        }  
}
 module quadx(l1,l2,h,d,c=false){
        mirror([1,0,0])
        rotate([0,-90,0])
        hull(){
            if(c==true){
                translate([0,0,-h/2])
                cube([l1,d,.01],true);    
            }else{
                cube([l1,d,.01],false);    
            }
            if(c==true){
                translate([0,0,h/2])
                cube([l2,d,.01],true);  
            }else{
                translate([0,0,h])
                cube([l2,d,.01],false);  
            }
        }  
}
module quady(l1,l2,h,d,c=false){
        hull(){
            if(c==true){
                translate([0,0,-h/2])
                cube([d,l1,.01],true);    
            }else{
                cube([d,l1,.01],false);    
            }
            if(c==true){
                translate([0,0,h/2])
                cube([d,l2,.01],true);  
            }else{
                translate([0,0,h])
                cube([d,l2,.01],false);  
            }
        }  
}

/*
module cylinderZ(d,h,c=true){
    translate([0,h,0])
    rotate([90,0,0])
    if(c){
        hull(){
            translate([0,d*.5,0])
            cylinder(h=h,d=d/10);
            
            cylinder(h=h,d=d);
        }    
    }else{
        cylinder(h=h,d=d);
    }
}
module hcylinder(d,h,c=true){
    if(c){
        hull(){
            translate([0,d*.5,0])
            cylinder(h=h,d=d/10);
            
            cylinder(h=h,d=d);
        }    
    }else{
        cylinder(h=h,d=d);
    }
}
//xcylinder(h=10, d=5);

module xcylinder(d,h,c=true){
    rotate([0,90,0])
    rotate([0,0,90])
    hcylinder(d,h,c);
}    
module ycylinder(d,h,c=true){
    rotate([90,0,0])
    hcylinder(d,h,c);
}    
module zcylinder(d,h){
    cylinder(h=h,d=d);
}
/*
module roundCube(length,width,height,radius=.5,center=false){
    if(center == false){
        translate([radius,radius,0])
        minkowski()
        {
            cube([length-(2*radius),width-(2*radius),height/2],false);
            cylinder(h=height/2,r=radius);
        }
    }else{
        translate([-length/2+radius,-width/2+radius,-height/2])
        minkowski()
        {
            cube([length-(2*radius),width-(2*radius),height/2],false);
            cylinder(h=height/2,r=radius);
        }
    }
}    

module roundCubeZ(height,width,length,radius=1,center=false){
    translate([height,0,0])
    rotate([0,-90,0])
    if(center == false){
        translate([radius,radius,0])
        minkowski()
        {
            cube([length-(2*radius),width-(2*radius),height/2],false);
            cylinder(h=height/2,r=radius);
        }
    }else{
        translate([-length/2+radius,-width/2+radius,-height/2])
        minkowski()
        {
            cube([length-(2*radius),width-(2*radius),height/2],false);
            cylinder(h=height/2,r=radius);
        }
    }
}    

module roundedCube(len,width,height,radius=1){
    translate([-len/2,-width/2,-height/2])
    if( height<(2*radius) ){
        intersection(){
            translate([radius,radius,radius])
            minkowski()
            {
              cube([len-(2*radius),width-(2*radius),height-radius]);
              sphere(r=radius);
            }
            cube([len,width,height]);            
        }
    }else{
        translate([radius,radius,radius])
        minkowski()
        {
          cube([len-(2*radius),width-(2*radius),height-(2*radius)]);
          sphere(r=radius);
        }
    }
}    


module roundcCube(len,width,height,radius=1){
    radius = radius/2;
    translate([-len/2,-width/2,-height/2])
    difference()
    {    
        roundCube(len,width,height,radius*2);
     
        // Top
        translate([0,0,height]){
            translate([-radius*1.5,0,0])  rotate([0,45,0])
            cube([radius*2,width,radius*2]);
            translate([len-radius*1.5,0,0])  rotate([0,45,0])
            cube([radius*2,width,radius*2]);
            
            translate([0,0,-radius*1.5])  rotate([45,0,0])
            cube([len,radius*2,radius*2]);
            translate([0,width,-radius*1.5])  rotate([45,0,0])
            cube([len,radius*2,radius*2]);
        }
        // Bottom
        translate([-radius*1.5,0,0])  rotate([0,45,0])
        cube([radius*2,width,radius*2]);
        translate([len-radius*1.5,0,0])  rotate([0,45,0])
        cube([radius*2,width,radius*2]);
        
        translate([0,0,-radius*1.5])  rotate([45,0,0])
        cube([len,radius*2,radius*2]);
        translate([0,width,-radius*1.5])  rotate([45,0,0])
        cube([len,radius*2,radius*2]);    
    }    
}    
*/
/*
module xrtriangle(base,depth,angle=45,maxheight=100) { 
    rotate([90,0,90])
    rtriangle(base,depth,angle,maxheight);
}
module yrtriangle(base,depth,angle=45,maxheight=100) { 
   translate([0,depth,0]) 
    rotate([90,0,0])
    rtriangle(base,depth,angle,maxheight);
}
/*
module xeqtriangle(size, depth){
    rotate([90,0,0])
    rotate([0,90,0])
    eqtriangle(size, depth);
}    
module yeqtriangle(size, depth){
    translate([0,depth,0])
    rotate([90,0,0])
    eqtriangle(size, depth);
} 
/**//*
module xisotriangle(base,depth,angle=45,maxheight=100) {  
    rotate([90,0,0])
    rotate([0,90,0])
    isotriangle(base,depth,angle,maxheight);
}
module yisotriangle(base,depth,angle=45,maxheight=100) {  
    translate([0,depth,0])
    rotate([90,0,0])
    isotriangle(base,depth,angle,maxheight);
}
/**//*
module xoblong(len,width,height){
    translate([height,0,0])
     rotate([0,-90,0])
    oblong(len,width,height);
}
module yoblong(len,width,height){
     rotate([-90,0,0])
     rotate([0,0,-90])
    oblong(len,width,height);
}    
module xnut(l=5){
    rotate([0,90,0])
    rotate([0,0,30])
    cylinder(h=l, r=3.5, center=true, $fn=6);
}    
module ynut(l=5){
    rotate([90,0,0])
    cylinder(h=l, r=3.5, center=true, $fn=6);
}   

/**/