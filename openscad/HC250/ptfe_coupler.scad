// Threading.scad - library for threadings
// Autor: Rudolf Huttary, Berlin 2016 

use <../threads.scad> // http://www.thingiverse.com/thing:900137

// examples 
//showexample = 2;   // choose your example number
$fn=200;
dt=12;
t=4;
cf=.4;  // Fit
cl=.3;  // Cleareance

ct=.3;  // Thread

// Detail
//bolt();
//translate([-25,0,0])  nut();

coupler6();

// Fine
//translate([20,0,0]) cone(); 

module coupler6(){
    h1=3.5;
    h2=6;
    h3=6;
    
    difference(){
        union(){
            cylinder(d=15.5+cf, h=h1);
            
            cylinder(d=11.5+cf, h=h1+h2+cl);
            
            translate([0,0,h1+h2+cl])
            cylinder(d=15.5+cf, h=h3+2);
        } 
        
        translate([0,0,-.1])
        cylinder(d1=5, d2=2.5, h=h1+h2+3);
        
        translate([0,0,h1+h2+2])
        cylinder(d=5.8-ct, h=h3+3); 
    }     
}

module coupler10(){
    h1=3.5;
    h2=6;
    h3=10;
    
    difference(){
        union(){
            cylinder(d=15.5+cl, h=h1);
            cylinder(d=11.5, h=h1+h2+cl);
            
            translate([0,0,h1+h2+cl])
            cylinder(d=15.5+cf, h=h3+2);
        } 
        
        translate([0,0,-.1])
        cylinder(d1=4.5, d2=5, h=h1+h2+3);
        
        translate([0,0,h1+h2+2])
        cylinder(d=9.8-ct, h=h3+3); 
    }     
}

module bolt(){
    difference(){
        union(){
            translate([0,0,12])
            metric_thread (diameter=dt, pitch=2, length=10, angle=45);
            
            cylinder(d=16, h=3.7);
            cylinder(d=12, h=3.7+6);
            translate([0,0,3.7+6])
            cylinder(d=16, h=3);
        } 
        
        translate([0,0,-.1])
        cylinder(d=4+cl,h=50);

        translate([0,0,5])
        cylinder(d=6,h=50);
    }     
}

module nut(){
    difference(){
        cylinder(d=dt+t*2, h=15, $fn=8);
        
        translate([0,0,2])
        metric_thread (diameter=dt+cl, pitch=2, length=20, angle=45);
        
        translate([0,0,-.1])
        cylinder(d=4+cl,h=50);
    }
}

module cone(){
    g=3; //gap
    h=14;
    difference(){
        cylinder(d1=7,d2=5.8,h=h);
                                
        translate([0,0,-.1])
        cylinder(d=4,h=50);
        
        translate([0,0,-.5])
        cylinder(d=3,h=50);
        
        translate([0,-g/2,-.1])
        cube([10,g,50]);
    }
    // Rings
    difference(){
        union(){
     //       translate([0,0,h/4]) ring();
            translate([0,0,2*h/4]) ring();
     //       translate([0,0,3*h/4]) ring();
        }
        
        translate([0,-g/2,-.1])
        cube([10,g,50]);
    }
    /**/
}

module ring(){
    difference(){
        cylinder(d=4,h=2);
        translate([0,0,-.1])
        cylinder(d1=4.1,d2=3,h=2.2);
    }
}
        
module nut_thread(D = 0, pitch = 1.25, d = 12, windings = 10, helices = 1, angle = 60, edges=40, left = false)
{
  R = D==0?d/2+pitch/PI:D/2; 
  translate([0,0,-pitch])
  difference()
  { 
    translate([0,0,pitch]) 
    cylinder (r=R, h =pitch*(windings-helices), $fn = edges); 
    threading(pitch, d, windings, helices, angle, true, left, $fn = $fn); 
  }
}

module threading(pitch = 1.25, d = 12, windings = 10, helices = 1, angle = 60, full = true, left=false)
{  // tricky: glue two 180° pieces together to get a proper manifold  
  r = d/2;
  ccw = left?1:-1; 
  Steps = $fn?$fn/2:180/$fa; 
  Pitch = pitch*helices; 
  if(full) cylinder(r = r-.5-pitch/PI, h=pitch*(windings+helices), $fn=$fn); 
  translate([0,0,(helices*.5+windings)*pitch]) 
  {
    sweep(gen_dat());   // half screw
    rotate([0, 0, 180]) translate([0, 0, Pitch/2])
    sweep(gen_dat());   // half screw
  }
  function gen_dat() = let(ang = 180, bar = R_(180, -90, 0, Ty_(-r+.5, vec3D(pitch/PI* Rack(windings, angle)))))
        [for (i=[0:Steps]) Tz_(-i/2/Steps*Pitch, Rz_(ccw*i*ang/Steps, bar))]; 

  function Rack(w, angle) = 
     concat([[0, 2]], 
            [for (i=[0:windings-1], j=[0:3]) 
              let(t = [ [0, 1], [2*tan(angle/2), -1], [PI/2, -1], [2*tan(angle/2)+PI/2, 1]])
              [t[j][0]+i*PI, t[j][1]]], [[w*PI, 1], [w*PI, 2]]);
     
  function rev(L) = let(N=len(L)) [for(x = [1:N]) x[N-i]];  
}

