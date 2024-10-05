use <path_extrude.scad>;

length=25;
P=2; // pitch
H=sqrt(3)/2 * P; // height of triangle
R=H/(P/2);
ppr=200; // points per revolution
loops=length/P;
D=16;
xw=0.4; // extrude width

myPoints = [ [-H/2-xw+0.1*R,-P/2+0.1], [1/4*H-xw,-P/8], [1/4*H-xw,P/8],
    [-H/2-xw+0.1*R,P/2-0.1] ];
myPath = [ for(t = [-(180/loops):(360/(ppr*loops)):360+(180/loops)]) 
    [(D/2)*cos(loops*t),(D/2)*sin(loops*t), P*(loops*t)/360] ];

difference(){
    union(){
        translate([0,0,-xw]) rotate(180) cylinder(h=length+xw*2, r=D/2-3/8*H-xw/2, $fn=ppr);
        path_extrude(exShape=myPoints, exPath=myPath, preRotate=false);
        translate([0,0,-7]) 
        minkowski(){
            rotate(180) cylinder(r=(24 / cos(30) - xw)/2-1, h=6, $fn=6);
            sphere(r=1, $fn=8);
        }
    }
    translate([0,0,length-2]) rotate_extrude($fn=60)
        polygon([[D/2-4,4],[D/2+4,4],[D/2+4,-2]]);

}