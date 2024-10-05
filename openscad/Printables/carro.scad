$fn=100;
use <../lib.scad>
t=3;

// Limite
*translate([-5,0,-18]) 
%cube([180,.5,120]);

// Chassis
c=165;
l=85;
r=10;
translate([0,-2,0])
difference(){
    union(){
        vrcube(c,15,l,r);
        
        // Reforço traseiro
        translate([22,0,0])
        cylinder(d=24, h=t);
        translate([22,0,l-t])
        cylinder(d=24, h=t);

        // Reforço frente
        translate([22+120,0,0])
        cylinder(d=24, h=t);
        translate([22+120,0,l-t])
        cylinder(d=24, h=t);
    }
    translate([t,-t,t])
    vrcube(c-t*2,15,l-t*2,r-t);
    
    translate([10,0,5])
    cube([45,14,12]);
    
    translate([22,0,4]){
    // Eixo
    translate([0,0,-20.1])
    cylinder(d=6, h=117);
    // Eixo
    translate([120,0,-20.1])
    cylinder(d=6, h=117);

    // Motor
    translate([48.5 * 0.4,0,2]) {
        translate([0,0,74-57])
        cylinder(d=27.15, h=57);
        cylinder(d=6, h=74);
    }
    }
}



/*
//Pilha
translate([60,-10,13])
cube([58.5,15,58.5]);

translate([22,0,4]){
difference(){
    scale([0.4,0.4,0.4]){
          
    // Frente    
    // roda esquerda
    translate([300,0,-50]){
    translate([0,0,260])  
    translate([-41,-4.4,-97.2])
    import("/home/hespanhol/Downloads/Rc_Car_Part10_7.stl");        
    // roda direita 
    translate([-41,-4.4,-97.2])
    import("/home/hespanhol/Downloads/Rc_Car_Part10_7.stl");
        
    }
    
    // Traseira    
    // roda esquerda
    translate([0,0,210])  
    translate([-41,-4.4,-97.2])
    import("/home/hespanhol/Downloads/Rc_Car_Part10_7.stl");        
    // roda direita 
    translate([0,0,-50])  
    translate([-41,-4.4,-97.2])
    import("/home/hespanhol/Downloads/Rc_Car_Part10_7.stl");

    // Engrenagem Motor    
    translate([48.5,0,10])    
    translate([7.4,-3.5,-51.07])
    rotate([0,0,1.2])
    import("/home/hespanhol/Downloads/Rc_Car_Drive_Gear_3.stl");

    // Engrenagem Eixo
    translate([-41,-4.4,-51.07+10])
    rotate([0,0,1])
    import("/home/hespanhol/Downloads/Rc_Car_Dummy_Gear_2.stl");   
        
    }

    *translate([0,0,-.1])
    cylinder(d=6, h=74);
    
    *translate([-30,-30, -10])
    cube([60,60,10]);
}

// Eixo
translate([0,0,-20.1])
cylinder(d=6, h=117);
// Eixo
translate([120,0,-20.1])
cylinder(d=6, h=117);

// Motor
translate([48.5 * 0.4,-2,2]) {
    translate([0,0,74-57])
    cylinder(d=27.15, h=57);
    cylinder(d=6, h=74);
}
}
/**/
