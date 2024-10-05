// Necks & Caps for DIY projects
// Xavan June 2016
//https://www.thingiverse.com/thing:1654620
//***** ************   *****
$fn=100;

module screw (Sta,End,Pas,Ray){ 
    // filet - thread
Ste=5;//pas angulaire
//Pas mm/360°
//Ray rayon centre du motif
//Sta angle de départ
//End angle de fin   
for (Rz = [Sta:Ste:End]) {//Rz rotation Z
    a= Rz>Sta ? 1: 0;
    b= Rz<End ? 1: 0;
Ap=Pas*(Rz-Sta)/360;//Ap avancement du pas en Z
Ap1=Ap+Pas*Ste/360;//Ap1 avancement du pas en Z+1
hull (){
    rotate ([0,0,Rz])translate([Ray,0,Ap])motif (a);
    rotate ([0,0,Rz+Ste]) translate([Ray,0,Ap1])motif (b);
}
}
}
  

module motif (a){//trapeze - threadform
//$Z1 largeur base
//$Z2 largeur sommet
//$X1 distance base sommet  
// dans le plan x-z
cube([0.1,0.1,$Z1],true);
translate([-a*$X1,0,0]) cube([0.1,0.1,$Z2],true);
} 


module bouchon (Rb,Hb,Ep,Nc){//cap
//Rb ray bouchon interieur
//Hb haut bouchon interieur
//Eb epais bouchon
//Nc nb crans
    ich=2.5; //inner chamfer
    och=1;  //outer chamfer
    difference(){
        union(){
            cylinder(och, r2=Rb+Ep,r1=Rb+Ep-och);
            translate ([0,0,och])
            cylinder(Hb+Ep, r=Rb+Ep);
        }
        
        translate ([0,0,Ep])
        cylinder(h=ich, r1=Rb-ich, r2=Rb);     

        translate ([0,0,Ep+ich-.1])
        cylinder(Hb, r=Rb);     
    }
}
 
difference(){
    quechua_1L ();
    /**
    translate([-50,-50,-20+2.1])
    #cube([100,100,20]);
    *
    translate([-50,0,-20+2.1])
    cube([100,100,50]);
    /**/
}

/****************BOUCHONS-CAPS*********************
difference(){
    union(){
        5L_galoon();
        cylinder(d=13,h=8);
    }
    
    translate([0,0,-.1])
    cylinder(d=11.5,h=20);
}  
/**/
module quechua_1L () {
    tol=0.5;//tolerance
    Ray=44/2+tol;//radius
    Pas=4;//step
    
    Ep=2.8;//thickness
    Ej=5;//inner bottom to screw
    Dd=Ej+(Pas/3)/2;//distance from base
    Df=6;//distance to end
        
    $Z1=2;//largeur base
    $Z2=0.4;//largeur sommet
    $X1=1.8;//distance base sommet (std 1.0)

    translate([0,0,Ep+Dd]){
        screw (0,720,Pas,Ray);
       // screw (120,250,Pas,Ray);
       // screw (240,370,Pas,Ray);
    }
    bouchon (Ray,Dd+Pas+Df,Ep,0);
}
module 5L_galoon () {
    jeu=0.5;//jeu
    Ray=47/2+jeu;//rayon centre du motif
    Pas=9;//pas de vis
    
    Ep=1.8;//épaisseur bouchon
    Ej=3;//épaisseur joint gasket
    Dd=Ej+(Pas/3)/2;//distance from base
    Df=1;//distance to end
        
    $Z1=2;//largeur base
    $Z2=0.35;//largeur sommet
    $X1=1;//distance base sommet (std 1.0)

    translate([0,0,Ep+Dd]){
        screw (0,130,Pas,Ray);
        screw (120,250,Pas,Ray);
        screw (240,370,Pas,Ray);
    }
    bouchon (Ray,Dd+Pas/2+Df,Ep,0);
}
