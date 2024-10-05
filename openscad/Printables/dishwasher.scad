$fn=100;
d1=36;
d2=22;
l=170;
t=5;
tz=7;
h=14;
open=1;


//tube_support();

washer();


module washer(){
    difference(){
        union(){
            cylinder(d=d1+t*2, h=8);
                
        }
        //--------------------------------
        translate([0,0,-.1])
        cylinder(d=d1, h=10);
    }
}    

module tube_support(){
    difference(){
        union(){
            hull(){
                cylinder(d=d1+t*2, h=tz);
                
                translate([l,0,0])
                cylinder(d=d2+t*2, h=tz); 
            }
            // reinforce
            cylinder(d=d1+t*2, h=h);
            hull(){
                translate([d1/2,0,0])
                cylinder(d=t*2, h=tz*2);
                
                translate([l/2,0,0])
                cylinder(d=t, h=tz); 
            }
        }
        //----------------------------
        if(open==1){
            translate([0,0,-.1])
            cylinder(d=d1, h=tz*3);
        }else{
            translate([0,0,-tz/2])
            cylinder(d=d1, h=tz*2);
        }
        translate([l,0,-.1])
        cylinder(d=d2, h=tz*2); 
        
        translate([l,-t,-.1])
        cube([d2,t*2,tz*2]);
    }
    
    // round end
    translate([l+d2/2+t/2-1,t, 0])
    cylinder(d=t+.5, h=tz*2); 
    translate([l+d2/2+t/2-1,-t, 0])
    cylinder(d=t+.5, h=tz*2); 
    
    difference(){
        hull(){
            cylinder(d=d1+t*2, h=tz*2);
            
            translate([l,0,0])
            cylinder(d=d2+t*2, h=tz*2); 
        }

        hull(){
            translate([0,0,-.1])
            cylinder(d=d1, h=tz*3);
            
            translate([l,0,-.1])
            cylinder(d=d2, h=tz*3); 
        }
        //cut
        translate([l,-t,-.1])
        cube([d2,t*2,tz*3]);
    }
}
