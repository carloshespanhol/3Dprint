$fn=150;
use <../lib.scad>

x=45;
y=45;
total_z=20;
inner_z=10;
phone_dist=21;
phone_hole=13.5;
chanel_width=7;
chanel_depth=4;
plug_width=6;
//--------------------------
pd=phone_dist;
ph=phone_hole;
cw=chanel_width;
cd=chanel_depth;
tz=total_z;
iz=inner_z;
pw=plug_width;
t=3;

/*
minkowski()
{
    sphere(r=1);
    
    eb2();
}
/**/

eb2();

module eb2(){
    iz=8;
    ez=5;
    tz=iz+ez;
    
    translate([-x/8,-y/2-pw+.5,pw+t*1.3])
    rotate([0,90,0])
    cylinder(d=t+.7, h=x/4);

    difference(){
        union(){
            translate([-x/2,-y/2,0])
            rcube(x,y,iz,8);
            translate([-x/2,-y/2,0])
            rcube(x,y/2,iz,2);

            translate([-x/2,-y/2,0])
            scube(x,t,tz);

            // overhang
            hull(){
                translate([-x/2,-y/2,iz])
                scube(x,t,.1);
                translate([-x/2,-y/2-ez,tz-.1])
                scube(x,ez+t,.1);
            }
            
            translate([-x/8,-y/2-pw/2, 0])
            hull(){
                translate([0,0,t+pw/2])
                rotate([0,90,0])
                cylinder(d=pw+t*2, h=x/4);
                
                scube(x/4,t,t);
            }
        }
        
        //========================================
        // right ear
        translate([pd/2-sin(20)*(tz-iz/2)-1,y/4, -iz/2])
        rotate([0,20,0])
        cylinder(d=ph, h=tz*2);
        
        translate([pd/2,y/4,iz-cd])
        cylinder(d=18, h=tz);
        
        translate([pd/2-cw/2, -y/2-.1, iz-cd])
        vrcube(cw,y-ph/2,tz, 1);
        
        translate([pd/2-cw/2, -y/2-ez-.1, -1])
        vrcube(cw, ez+t*2, tz*2, 1);
        
        
        
        // left ear
        mirror([1,0,0]){
        translate([pd/2-sin(20)*(tz-iz/2)-1,y/4, -iz/2])
            rotate([0,20,0])
            cylinder(d=ph, h=tz*2);
        }
        translate([-pd/2,y/4,iz-cd])
        cylinder(d=18, h=tz);
        
        translate([-pd/2-cw/2, -y/2-.1, iz-cd])
        vrcube(cw,y-ph/2,tz,1);
        translate([-pd/2-cw/2, -y/2-ez-.1, -1])
        vrcube(cw, ez+t*2, tz*2, 1);
        

        translate([-pd/2, -y/2-ez-.1, t+pw/2])
        vrcube(pd, ez, tz*2, 1);

        // plug support
        translate([-x/4,-y/2-pw/2,t+pw/2])
        rotate([0,90,0])
        cylinder(d=pw, h=x/2);
        translate([-x/4,-y/2-pw+1,t+pw/2])
        scube(x/2,pw-1,tz);
    }    
}
module eb1(){
    translate([-x/8,-y/2-pw+.5,pw+t*1.38])
    rotate([0,90,0])
    cylinder(d=t+.7, h=x/4);

    difference(){
        union(){
            translate([0,0,tz/2])
            roundedCube(x,y,iz,2);
            
            translate([-x/2,-t/2,0])
            vrcube(x,t,tz, 2);

            translate([-x/2,-y/2,0])
            vrcube(x,t,tz, 2);

            translate([-x/8,-y/2-pw/2,0])
            hull(){
                translate([0,0,t+pw/2])
                rotate([0,90,0])
                cylinder(d=pw+t*2, h=x/4);
                
                scube(x/4,t,t);
            }
        }
        
        // right ear
        translate([pd/2-sin(20)*(tz-iz/2)+1,y/4,0])
        rotate([0,20,0])
        cylinder(d=ph, h=tz);
        
        translate([pd/2,y/4,iz*1.5-cd])
        cylinder(d=18, h=tz);
        
        translate([pd/2-cw/2, -y/2-.1, iz*1.5-cd])
        vrcube(cw,y-ph/2,tz, 1);
        translate([pd/2-cw/2, -y/2-.1, -1])
        vrcube(cw, t*2, tz/2-iz/2, 1);
        
        
        
        // left ear
        mirror([1,0,0]){
            translate([pd/2-sin(20)*(tz-iz/2)+1,y/4,0])
            rotate([0,20,0])
            cylinder(d=ph, h=tz);
        }
        translate([-pd/2,y/4,iz*1.5-cd])
        cylinder(d=18, h=tz);
        
        translate([-pd/2-cw/2, -y/2-.1, iz*1.5-cd])
        vrcube(cw,y-ph/2,tz,1);
        translate([-pd/2-cw/2, -y/2-.1, -1])
        vrcube(cw, t*2, tz/2-iz/2, 1);
        
        //
        translate([-x/4,-y/2-pw/2,t+pw/2])
        rotate([0,90,0])
        cylinder(d=pw, h=x/2);
        translate([-x/4,-y/2-pw+1,t+pw/2])
        scube(x/2,pw-1,t*2);
    }    
}
