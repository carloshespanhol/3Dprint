use <../lib.scad>
$fn=100;
cl=.3;

con=9.5;
tube=4;
fila=2;
a=8;
l=60;
w=16;
h=14;
m=(h-con)/2+con/2;
cut=17;
pushfit_out=1;
echo(cut);

/**/
body();
/**
translate([0,0,h])    rotate([0,180,0])
cap();
/**/
//cutter();
//filament();

module cutter(){
    difference()
    {
        union(){
            translate([-10,0,0])
            rcube(20,27,h,2);
        }
        
        // Blade
        bw=.8;
        translate([-bw/2,9,-1])
        scube(bw, 22, 20);

        // Tube out
        translate([0,10.1,h/2])
        rotate([90,0,0])
        cylinder(h=l, d=tube+cl);
        
        /* Split tube */
        hull(){
            translate([-1.7,9,h/2-2.5])
            rotate([0,0,30])
            cube([2,10,3.1]);
            
            translate([0,10,h/2-2.5])
            rotate([0,0,-30])
            cube([2,10,3.1]);
        }
        
        /* Top Cut */
        translate([-w*1.5, 10, h*0.55])
        cube([3*w,22,h]);
    }
}

module body(){
    difference()
    //intersection()
    {
        union(){
            jig();
            
            if(pushfit_out==1){
                translate([-(w-2)/2, -3, 0])
                rcube(w-2, 7.5, h, 1);
            }
        }
        
        /* Out */
        if(pushfit_out==1){
            translate([0,5,h/2])
            rotate([90,0,0])
            cylinder(h=10.5, d=con); 
        }
        
        // Smoothing
        translate([-3, 13, 4.2])
        cube([6,4.7,5]);
        translate([-2, 10, 4.2])
        cube([4,4,5]);
        
        /* Top Cut */
       // translate([-w,0,h/2]) cube([2*w,l/3+1,h]);   
       if(pushfit_out==1){ 
           translate([-w*1.5,cut,h*0.55])
           cube([3*w,5,h]);
       }else{
           translate([-w*1.5,-0.01,h*0.55])
           cube([3*w,cut,h]);
       }       
       
       translate([51.5,4,-.1])
       cylinder(r=45, h=h+1);

       mirror([1,0,0]) 
       translate([51.5,4,-.1])
       cylinder(r=45, h=h+1);
        /**/
    }
}


module cap(){
    translate([0,0,h])
    rotate([0,180,0])
    difference(){
        intersection()
        {
            jig();
            
            // Top Cut 
            translate([-w,-0.01,h*0.55])
            cube([2*w,l/2,h]);   
        }
        
        // Smoothing
        translate([-3, 13, 4.2])
        cube([6,4.5,2.6]);
        translate([-2, 10, 4.2])
        cube([4,4,2.6]);
        
        // Slot Cut 
        #translate([-w,cut,0.5]) cube([2*w,50,h]);
        
        translate([51.5,4,-.1])
        cylinder(r=45, h=h+1);

        mirror([1,0,0]) 
        translate([51.5,4,-.1])
        cylinder(r=45, h=h+1);
    }
}


/* Jig */
module jig(){
    difference(){
        translate([-w/2,0,0])
        union(){
            rcube(w,l,h,2);

            translate([2,0,0])
            rotate([0,0,a])
            rcube(w,l,h,2);

            translate([-2,2.25,0])
            rotate([0,0,-a])
            rcube(w,l,h,2);
        }

        /* In */
        translate([-w/2,l+3,m])
        rotate([90,0,a])
        cylinder(h=10.5, d=con);
        translate([w/2,l+3,m])
        rotate([90,0,-a])
        cylinder(h=10.5, d=con);  
        
        /* Out */
        if(pushfit_out==1){
            translate([0,5,h/2])
            rotate([90,0,0])
            cylinder(h=10.5, d=con); 
        }
    
        // Tube out
        translate([0,10,h/2])
        rotate([90,0,0]){
            cylinder(h=l, d=tube);
            translate([0,0,-10])
            cylinder(h=l+20, d=fila);
        }
        
        /* Tube in */
        hull(){
            translate([-w/2-2.1,l+17,m])
            rotate([90,0,a])
            cylinder(h=l, d=tube);
            translate([-w/2-1.7,l+14,m])
            rotate([90,0,a])
            cylinder(h=l, d=fila);
        }
        hull(){
            translate([w/2+2.1,l+17,m])
            rotate([90,0,-a])
            cylinder(h=l, d=tube);
            translate([w/2+1.7,l+14,m])
            rotate([90,0,-a])
            cylinder(h=l, d=fila);
        }
        
        /* Filament path */
        translate([-w/2-2.1,l+17,m])
        rotate([90,0,a])
        cylinder(h=l+10, d=fila);
        translate([w/2+2.1,l+17,m])
        rotate([90,0,-a])
        cylinder(h=l+10, d=fila);
        
        /* Split tube */
        translate([-1.7,9,h/2-2])
        rotate([0,0,30])
        cube([2,10,4]);
        translate([0,10,h/2-2])
        rotate([0,0,-30])
        cube([2,10,4]);

        /* Screws */
        translate([-w/4*1.8, 11, -h])
        cylinder(d=4, h=30);
        translate([w/4*1.8, 11, -h])
        cylinder(d=4, h=30);
    }
    
    if(pushfit_out==0){
        for(i=[0:4]){
            translate([0,2+i,0.6])
            cylinder(h/2-tube/2,2,0.1);
        }
    }
       
}

module screws(){
        translate([-w/4*1.4,0,h+1])
        rotate([180,0,])
        Mscrew(h+1.1);
        translate([-w/4*1.4,0,-8])
        Mnut();

        translate([w/4*1.4,0,h+1])
        rotate([180,0,])
        Mscrew(h+1.1);
        translate([w/4*1.4,0,-8])
        Mnut();
}    
module filament(){
    #translate([-w/2-2.1,l+17,m])
    rotate([90,0,a])
    cylinder(h=l+13, d=fila);
    #translate([w/2+2.1,l+17,m])
    rotate([90,0,-a])
    cylinder(h=l+13, d=fila);
}

