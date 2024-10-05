use <../lib.scad>
$fn=200;

s=130;  // tamanho da caixa
t=2;
r=2;

// Tomada
tw=52;  
th=36;

dp=103; // distancia dos parafusos
dt=21;  // distancia da tomada pra borda

ac=5;   // acabamento

echo(s+ac*2);

difference(){
    translate([-s/2-ac,-s/2-ac,0])
    hull(){
        translate([0,0,t])
        rcube(s+ac*2, s+ac*2, .1, r);
        
        translate([t,t,0])
        rcube(s-2*t+ac*2, s-2*t+ac*2, .1, r);
    }

    // tomada
    translate([-tw/2, s/2-th-dt, -.1])
    rcube(tw,th,10, 2);
    
    // parafusos
    translate([-s/2+(s/2-dp/2), -s/2+(s/2-dp/2), -.1])
    cylinder(d1=3+t*2, d2=3.5, h=t+.3);

    translate([s/2-(s/2-dp/2), -s/2+(s/2-dp/2), -.1])
    cylinder(d1=3+t*2, d2=3.5, h=t+.3);

    translate([s/2-(s/2-dp/2), s/2-(s/2-dp/2), -.1])
    cylinder(d1=3+t*2, d2=3.5, h=t+.3);

    translate([-s/2+(s/2-dp/2), s/2- (s/2-dp/2), -.1])
    cylinder(d1=3+t*2, d2=3.5, h=t+.3);
}
