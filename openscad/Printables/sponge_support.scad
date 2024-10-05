use <../lib.scad>
$fn=100; // recomended value for smooth circle is 60

sl=110;
sh=75;

/*******************************/
l=sl-40;
h=75;
w=22;
dist=50;
t=3;
r=5;

bp=7;
dx=40;
dy=5;
lw=.44; //lineWidth

/*
translate([t,-(sl-l)/2,t])
%cube([w,sl,h]);
translate([t*3+w+dist,-(sl-l)/2,t])
%cube([w,sl,h]);
/**/

intersection(){
    support();
    //translate([20,55,0])    cube([60,50,30]);
}

module support(){
    difference(){
        union(){
            translate([w+t,0,0])
            vrcube(dist+t*2, l-.2, h, r);

            translate([0, 0,-h/3])
            vrcubex(w*2+dist+t*4, l-.2,  h, r);
        }

        // bottom
        translate([-.1,-.1,-h])
        cube([w*2+dist+t*5, l+.2, h]);

        // sponge
        translate([t,-.1,t])
        cube([w, l, h]);
        translate([w+dist+t*3,-.1,t])
        cube([w, l, h]);
            
        // sink
        translate([t*2+w,-.1,-t])
        vrcube(dist, l, h, r-t/2);
        
        // drain cut 
        translate([-t,l/4,-t])
        vrcubex(w+t*4, l/2, h/2, r);
        translate([t+w+dist,l/4,-t])
        vrcubex(w+t*4, l/2, h/2, r);
            
    }
}
