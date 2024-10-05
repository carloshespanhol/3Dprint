$fn = 32;

quick = false;

w_sight = 32;
l_sight = 30;
h_sight = 18;
th_sight = 2;
l_offset_sight = l_sight/2 - 12;

aperture_r = 2.5;
aperture_f = 3.5;
w_crosshairs = 1;
l_crosshairs = 3;

r_fillet = 1;
r_inner_sight = 3;
r_outer_sight = r_inner_sight + th_sight;

w_foot = 18.1;
l_foot = 20;
h_foot = 1.99;
r_foot = 2;

w_leg = 12.5;
h_leg = 2;



foot ();
translate ([0, l_sight/2 - l_offset_sight, h_sight/2 + th_sight + h_foot + h_leg])
    rotate ([90, 0, 0])
        sight (r_fillet);

module foot ()
{
    translate ([0, 0, h_foot])
        linear_extrude (h_leg)
            square ([w_leg, l_foot], center = true);

    linear_extrude (h_foot)
    {
        minkowski ()
        {
            square ([w_foot - 2* r_foot, l_foot - 2 * r_foot], center = true);
            circle (r_foot);
        }
    }
}

module sight (r)
{
    translate ([0, - h_sight/2 - 0.001, l_sight/2 - l_offset_sight])
        hull ()
        {
            translate ([0, - th_sight + 0.001, 0])
                cube ([w_leg, 0.001, l_foot], center = true);
            
            cube ([w_leg, 0.001, l_foot], center = true);
            
        }
    
    translate ([0, 0, l_sight - l_crosshairs])
        crosshairs (aperture_f);
    
    crosshairs (aperture_r);
    
    difference ()
    {
        sight_body (r);

        translate ([0, 0, -1])
            linear_extrude (l_sight + 2)
                minkowski ()
                {
                    square ([w_sight - 2 * r_inner_sight, h_sight - 2 * r_inner_sight], center = true);
                    circle (r = r_inner_sight);
                }
    }
}

module sight_body (rr)
{
    if (!quick)
    {
        hull ()
            for (k=[0, 1])
            {
                translate ([0, 0, rr + k * (l_sight - 2 * rr)])
                {
                    for (i=[-1, 1])
                    {
                        translate ([0, i * (h_sight/2 - r_inner_sight), 0])
                        for (j=[-1, 1])
                        {
                            translate ([j * (w_sight/2 - r_inner_sight), 0, 0])
                                rotate_extrude ()
                                {
                                    translate ([r_outer_sight - rr, 0, 0])
                                        circle (rr);
                                }
                        }
                    }
                }
            }
    }
    else
        linear_extrude (l_sight)
            {

                minkowski ()
                {
                    square ([w_sight - 2 * r_inner_sight, h_sight - 2 * r_inner_sight], center = true);
                    circle (r_outer_sight);
                }
            }
}

module crosshairs (r)
{
    linear_extrude (l_crosshairs)
        difference ()
        {
            union ()
            {
                square ([w_sight, w_crosshairs], center = true);
                square ([w_crosshairs, h_sight], center = true);
                circle (r + w_crosshairs);
            }
            circle (r);
        }
}