$fn=100;

shrink=1.06; // PETG shrink factor
fit=shrink+0.01; // % fit tolerance
thick=2.5;
slot=0.5;
diam=7;

grommet();
//translate([30,0,0]) filter();

module grommet(){
    echo(diam*shrink);
    
    
    
    
    difference(){
        union(){
            translate([0,0,1.5])
            rotate([0,10,0])
            cylinder(d=diam*shrink,h=diam*1.2);  
          
          
            cylinder(d=diam*2.5,h=3);   
           
            
        }
        
        translate([-.2,0,-.5])
        rotate([0,10,0])
        cylinder(d=4*fit,h=30);
        
        translate([diam,-diam,-.1])
        cube([diam,diam*2,diam]);
    }
}    

module filter(){
    echo(diam*fit);
    translate([thick,0,30-thick])
    cube([15,20,0.5]);  

    difference(){
        union(){
            cube([20,20,30]);    
        }
        translate([thick,-thick,thick])
        cube([15,20,25]);  
        
        translate([10,10,-.1])
        cylinder(d=diam*fit,h=33); 
        
        // Slots
        translate([20-thick-1,thick,-.1])
        rotate([0,0,45])
        cube([slot,19.5,thick+1]);    

        translate([thick,thick+1,-.1])
        rotate([0,0,-45])
        cube([slot,19,thick+1]);    
        
    }    
}