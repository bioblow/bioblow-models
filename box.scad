
fan_width = 60;bore_hole_offset = 5; bore_hole_diameter = 4;
//fan_width = 70;bore_hole_offset = 4.25; bore_hole_diameter = 4;
//fan_width = 80;bore_hole_offset = 4.25; bore_hole_diameter = 4;
//fan_width = 120;bore_hole_offset = 7.5; bore_hole_diameter = 4;


nut_width = 7;
bore_depth = 3;
air_foil_depth = 15;
wall_thickness = 2;
floor_thickness = 1.5;
outlet_height = 7;
tube_diameter = 4;
nub_height=1.5;
box_height = air_foil_depth+floor_thickness;
union() {
 difference() {
  translate([fan_width/2, fan_width/2 , 0]) roundedRect(size = [fan_width, fan_width, box_height], radius = bore_hole_diameter/2+2);
  translate([fan_width/2, fan_width/2, floor_thickness]) cylinder(r=fan_width/2-wall_thickness, h=air_foil_depth+1, $fn=500);
  translate([0, 0, outlet_height]) rotate([90,0,135])  cylinder(r=(tube_diameter + 0.1)/2, h=fan_width, $fn=100 );
  translate([fan_width - bore_hole_offset, bore_hole_offset, 0]) bore_hole();
  translate([bore_hole_offset, fan_width - bore_hole_offset, 0]) bore_hole();
 }
 translate([bore_hole_offset, bore_hole_offset, 0]) nub();
 translate([fan_width - bore_hole_offset, fan_width - bore_hole_offset, 0]) nub();
}

module nub() {
 translate([0, 0, box_height-1]) union() {
  cylinder(r=bore_hole_diameter/2, h=nub_height+1, $fn=100 );
  translate([0,0,nub_height+1])sphere(r=bore_hole_diameter/2,  $fn=100);
 }
};

module bore_hole() {
 translate([0, 0, -0.1]) roundedRect([nut_width+0.1, nut_width+0.1, box_height-bore_depth+0.2], radius=2);
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