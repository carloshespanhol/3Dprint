$fs=0.2;

s = 60;
w = 15;
h = 5;
num_sections=2;
letter_size = 6;
square=0;
type = 2;
notch=2;

tower();

module tower(){
    difference(){
        for(i=[0:num_sections-1]){
            translate([0,0,h*i])
            if(type == 1){
                section1();
            }else{
                section2();
            }
        }    
        /*  X axis */
        translate([s/2, w+1-.2, 1.5])
        rotate([90,0,0])
        linear_extrude(height = 1)
        text("X", size = letter_size, font="Arial:style=Bold");
        //  Y axis
        translate([w-.2, s/2, 1.5])
        rotate([90,0,90])
        linear_extrude(height = 1)
        text("Y", size = letter_size, font="Arial:style=Bold");
        /*  A */
        translate([s/2,s/2-4.5,1.5])
        rotate([90,0,50])
        linear_extrude(height = 1)
        text("A", size = letter_size, font="Arial:style=Bold");
    }
}

module section1(){
    difference(){
        union(){
            if(square){
                hull(){
                    cube([w,w,h]);    
                    translate([s-w,0,0])
                    cube([w,w,h]);    
                }
                hull(){
                    cube([w,w,h]);    
                    translate([0,s-w,0])
                    cube([w,w,h]);    
                }                
            }else{
                hull(){
                    translate([w/2,w/2,0])
                    cylinder(d=w,h=h);    
                    translate([s-w/2,w/2,0])
                    cylinder(d=w,h=h);
                }
                hull(){
                    translate([w/2,w/2,0])
                    cylinder(d=w,h=h);    
                    translate([w/2,s-w/2,0])
                    cylinder(d=w,h=h);
                }
            }

            translate([w/2,w/2,0])
            cube([w,w,h]);           
        }
        

        //========================
        translate([w*1.5,w*1.5,-1])
        cylinder(d=w,h=h+2);
        
        // X axis
        translate([s/4, -.01,-.5])
        notch(1,w/2);
        translate([s/3*2, -.01,-.5])
        notch(2, w/2);
        
        // Y axis
        translate([-.01, s/4*3,-.5])
        rotate([0,0,-90])
        notch(1, w/2);
        translate([-.01, s/3,-.5])
        rotate([0,0,-90])
        notch(2, w/2);
    }
}

module section2(){
    difference(){
        union(){
            if(square){
                hull(){
                    cube([w,w,h]);    
                    translate([s-w,0,0])
                    cube([w,w,h]);    
                }
                hull(){
                    cube([w,w,h]);    
                    translate([0,s-w,0])
                    cube([w,w,h]);    
                }                
            }else{
                hull(){
                    translate([w/2,w/2,0])
                    cylinder(d=w,h=h);    
                    translate([s-w/2,w/2,0])
                    cylinder(d=w,h=h);
                }
                hull(){
                    translate([w/2,w/2,0])
                    cylinder(d=w,h=h);    
                    translate([w/2,s-w/2,0])
                    cylinder(d=w,h=h);

                    translate([s/2,s/2+w/2,0])
                    cylinder(d=w,h=h);
                }
            }
        }
        

        //========================
        
        if(notch==1){
            // X axis
            translate([s/4, -.01,-.5])
            notch(1,w/2);
            translate([s/3*2, -.01,-.5])
            notch(2, w/2);
            
            // Y axis
            translate([-.01, s/4*3,-.5])
            rotate([0,0,-90])
            notch(1, w/2);
            translate([-.01, s/3,-.5])
            rotate([0,0,-90])
            notch(2, w/2);
        }else if(notch==2){
            // X axis
            translate([s/2, -.01,-.5])
            notch(1,w/2);
            // Y axis
            translate([-.01, s/2,-.5])
            rotate([0,0,-90])
            notch(1, w/2);
        }
    }
}

module notch(w, d){
    difference(){
        union(){
            cube([w,d,h+2]);
            
            translate([w,0,h/2+.5])
            rotate([-90,0,0])
            cylinder(d=h+2, h=d);                
        }
        
        translate([0,0,h/2+.5])
        rotate([-90,0,0])
        cylinder(d=h+2, h=d);
    }
}    
