use <../lib.scad>
use <../honeycomb.scad>
$fn=100;

w=93;
l=76;
h=26;
t=3;
d=10;
p=75;
ph=18;   //
dp=30;   // drain position
g=3;
nl=45;
nt=2;

//tray();
//lower_grid();
//net();
shoe();

/*
difference(){
    union(){
        tray();
        
        translate([0,l-t-30,0])
        nccube(w,t,h);
    }

    translate([-50,l-t*2-30-200,-1])
#    nccube(w+100,t+200,h*2);
}
/*****/
module shoe(){
    nccube(w,10,5);
    nccube(w,50,0.8);
}    
module net(){
    difference(){
        nccube(w,nl, nt);
     
        translate([nt,nt,-1])   
        nccube(w-2*nt,nl-2*nt, 10);        
    }
    // Honeycomb fill
    linear_extrude(nt) {
        honeycomb(w, nl, 7, 1);
    }
}

module lower_grid(){
    translate([t+.3,-p+t*2+.3,ph-g]){
        
        difference(){
            nccube(w-2*t-.6,p+t, g);
            
            translate([-t,p-2*t-1,-1])
            nccube(w, p-t*3-1, ph); 
         
            translate([t,t,-1])   
            roundCube(w-4*t-1,p-5*t, g*2,4*t);
            
            /* Grid stop */
            translate([-.5,p-t*3.5,-1])
            nccube(2*t+1,t+1,ph);
            translate([w-4*t-1,p-t*3.5,-1])
            nccube(2*t+1,t+1,ph);
            
        }
       
        intersection(){
            translate([t,t,-1])   
            roundCube(w-4*t-1,p-5*t, g*2,4*t);

            // Honeycomb fill
            linear_extrude(g) {
                honeycomb(w, p, 5, 1);
            }
        }
    }
}

module tray(){

// Rear Slot
difference(){
    translate([w/2-(t+1),l-10-t,0])
    nccube(2+t*2,10+t,10+t);

    translate([w/2-1,l-9.99,-.01])
    nccube(2,10,10);
}

difference(){
    union(){
        // Main body
        translate([0,-p/2,0])
        cube([w,l+p/2,h]);
        
        // Drain
        translate([-15,-30,0])
        nccube(15,11,4);
        
        /* Pingadeira */
        translate([0,-p+t,0])
        nccube(w,p,ph);        
    }
    /***************/  
    //Rear width
    translate([-1,l-10,-1])
    nccube(2,11,h*2);
    translate([w-1,l-10,-1])
    nccube(2,11,h*2);

    // Rear Slot
    translate([w/2-1,l-9.99,-.01])
    nccube(2,10,5);

    // Drain
    translate([-16,-28.5,1])
    nccube(20,8,2);
    
    translate([t,-34,1])
    nccube(15,20,10);
    
    // Pingadeira 
    translate([t,-p+2*t,t])
    nccube(w-2*t,p*1.5,ph);
    translate([-1,-p-1,ph])
    cube([w+2,p+2,ph]);
    // Upper net
    translate([-w/2,-.01,ph-t])
    rotate([15,0,0])
    cube([w*2,l,h]);
    //main body
    translate([t,-.01,t])
    cube([w-2*t,l-t,h*2]);

}

/* Apoio grade lateral */
translate([t,-p+12,0])
quad(ph-g,t,1.5*t,12);
translate([t,-18,0])
quad(ph-g,t,1.5*t,12);

translate([w-t,-18+12,0])
rotate([0,0,180])
quad(ph-g,t,1.5*t,12);
translate([w-t,-p+24,0])
rotate([0,0,180])
quad(ph-g,t,1.5*t,12);

/* apoio grade frontal */
translate([w/2+(p-8*t)/2,-p/4,0])
rotate([0,0,90])
quad(ph-g,ph-g,t,p-8*t);

translate([w/2+(p-8*t)/2,-p/4*3,0])
rotate([0,0,90])
quad(ph-g,ph-g,t,p-8*t);

/* Reforço */
difference(){
    union(){
        translate([0,-p+t*2,t]){
            xrtriangle(5,5,w);
            
            translate([1,l+p-t*3,0])
            rotate([90,0,0])
            xrtriangle(5,5,w-2);
        }    
        translate([t,-p+t,t]){
            yrtriangle(5,5,l+p-t);

            translate([w-t*2,0,0])
            rotate([0,-90,0])
            yrtriangle(5,5,l+p-t);
        }
    }
     // Drain           
     translate([-t,-34,1-t])
    nccube(15,20,10);
    // Rear Slot
    translate([w/2-1,l-9.99,-.01])
    nccube(2,10,5);
}

/* Grid stop */
translate([0,-t,0])
nccube(3*t,t,ph);
translate([w-3*t,-t,0])
nccube(3*t,t,ph);

}