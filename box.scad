
fan_width = 60;bore_hole_offset = 5; bore_hole_diameter = 4; nut_width = 7;
//fan_width = 70;bore_hole_offset = 4.25; bore_hole_diameter = 4; nut_width = 7;
//fan_width = 80;bore_hole_offset = 4.25; bore_hole_diameter = 4; nut_width = 7;
//fan_width = 120;bore_hole_offset = 7.5; bore_hole_diameter = 4; nut_width = 7;


bore_depth = 3;
air_foil_depth = 15;
wall_thickness = 2;
floor_thickness = 1.5;
outlet_height = 7;
tube_diameter = 4;
nub_height=1.8;
box_height = air_foil_depth+floor_thickness;
union() {
 difference() {
  translate([fan_width/2, fan_width/2 , 0]) roundedRect(size = [fan_width, fan_width, box_height], radius = bore_hole_diameter/2+2);
  translate([fan_width/2, fan_width/2, floor_thickness]) cylinder(r=fan_width/2-wall_thickness, h=air_foil_depth+1, $fn=500);
  translate([0, 0, outlet_height]) rotate([90,0,135])  cylinder(r=(tube_diameter + 0.1)/2, h=fan_width, $fn=100 );
  translate([fan_width - bore_hole_offset, bore_hole_offset, 0]) bore_hole();
  translate([bore_hole_offset, fan_width - bore_hole_offset, 0]) bore_hole();
   translate([fan_width-5, fan_width-5, 0]) rotate([0,0,45]) translate([1,-20,box_height/4]) cube([2,40,box_height/2]);
  bottom_pattern();
 }
 translate([bore_hole_offset, bore_hole_offset, 0]) nub();
 translate([fan_width - bore_hole_offset, fan_width - bore_hole_offset, 0]) nub();
}

//bottom_pattern();
module bottom_pattern(){
 union() {
  difference(){
   translate([-fan_width/2, -fan_width/2,0]) checkers();
   translate([10, 10,-0.1]) cube([fan_width*0.7, fan_width/4, 0.6]);
  }
  translate([15,21,0.5]) rotate([0,180,0])  linear_extrude(height = 0.6) text("bioblow.com", size=4, halign="right");
  translate([15,16,0.5]) rotate([0,180,0])  linear_extrude(height = 0.6) text("© 2018 Tim Hobbs", size=3, halign="right");
  translate([15,11,0.5]) rotate([0,180,0])  linear_extrude(height = 0.6) text("CC-BY 4.0", size=3, halign="right");
 }
}

module checkers() {
  rotate_about_pt(45, 0, [fan_width, fan_width,0])ribs();
  rotate_about_pt(-45, 0, [fan_width, fan_width,0])ribs();
}

module rotate_about_pt(a, v, pt) { //https://stackoverflow.com/questions/45826208/openscad-rotating-around-a-particular-point
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}

module ribs() {
//rotate([0,0,45]) 
for (i = [0:(fan_width*2/7)]) {
 translate([0, i*7, -0.1]) cube([fan_width*2,1,0.6]);
}
}


module nub() {
 translate([0, 0, box_height-1]) union() {
  cylinder(r=bore_hole_diameter/2, h=nub_height+1, $fn=100 );
  translate([0,0,nub_height+1])sphere(r=bore_hole_diameter/2,  $fn=100);
 }
};

module bore_hole() {
 translate([0, 0, -0.1]) rotate([0,0,45]) roundedRect([nut_width+0.1, nut_width+0.1, box_height-bore_depth+0.2], radius=2);
 translate([0, 0, box_height-bore_depth]) union() {
  cylinder(r=bore_hole_diameter/2+0.3, h=bore_depth+1, $fn=100);
 }
};

module roundedRect(size, radius) // https://www.thingiverse.com/thing:9347
{
x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
hull()
{
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius), (-y/2)+(radius), 0])
    circle(r=radius, $fn=100);

    translate([(x/2)-(radius), (-y/2)+(radius), 0])
    circle(r=radius, $fn=100);

    translate([(-x/2)+(radius), (y/2)-(radius), 0])
    circle(r=radius, $fn=100);

    translate([(x/2)-(radius), (y/2)-(radius), 0])
    circle(r=radius, $fn=100);
}
}