use <../lib.scad>
$fn=64;

//translate([0,0,7]) import("/home/hespanhol/Downloads/guitarra_01.stl");


s=170;
h=100;
fh=30;
gt=100;

%translate([-10,17,8.6]) nccube(20,20,100);

base();
top();

module top(){
    difference(){
        translate([0,22,103.6])
        cylinder(d=45,h=15); 
     
        // Guitar cut
        translate([-s/2,-s*.7+20,15])
        rotate([-5,0,0])
        nccube(s,gt,s);        
    }
}

module base(){
    intersection(){
    translate([0,s*.7,-s/2])
    rotate([-15,0,0])
    cylinder(r=s*1.5,h=s);

    difference(){
        hull(){
            difference(){
                translate([0,-s*.67,0])
                isotriangle(s,h,25,s+50);
                //----------------------------------------
                translate([-s/2,10,-.1])
                nccube(s,s/2,s);
            }
            translate([0,16,0])
            cylinder(d=55,h=h);
        }
        
        //------------------------------------------------------
        // upper cut
        translate([-s/2,0,15])
        nccube(s,s/2,s);
        translate([-s/2,-s*.7,fh])
        nccube(s,s/2,s);

        // Guitar cut
        translate([-s/2,-s*.7+20,15])
        rotate([-5,0,0])
        nccube(s,gt,s);
        
        // inner cut
        hull(){
            translate([0,2,-.1])
            cylinder(d=20,h=s);
            
            translate([-s/2,-s,-.1])
            nccube(s,5,s);
        }
        // aluminium profile
        translate([-10.5,17,8.6])
        nccube(21,21,170);    
        // screw hole
        translate([0,27.5,-.1])
        cylinder(d=5.5, h=50);
        translate([0,27.5,-.1])
        cylinder(d=13, h=4.6);
    }    
    }
}