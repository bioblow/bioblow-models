fan_width = 60;bore_hole_offset = 5;
//fan_width = 70;bore_hole_offset = 4.25;
//fan_width = 80;bore_hole_offset = 4.25;
//fan_width = 120;bore_hole_offset = 7.5;

bore_hole_diameter = 4;


air_foil_depth = 15;
wall_thickness = 10;
floor_thickness = 2;
outlet_height = 7;
tube_diameter = 4;
nub_height=1.5;
box_height = air_foil_depth+floor_thickness;
union() {
 difference() {
  cube(size = [fan_width, fan_width, box_height]);
  translate([wall_thickness, wall_thickness, floor_thickness]) cube(size = [fan_width-wall_thickness*2, fan_width-wall_thickness*2, air_foil_depth+1]);
  translate([fan_width/2, wall_thickness + 1, outlet_height]) rotate([90,0,0])  cylinder(r=(tube_diameter + 0.1)/2, h=wall_thickness+2, $fn=100 );
 }
 translate([bore_hole_offset, bore_hole_offset, 0]) nub();
 translate([fan_width - bore_hole_offset, bore_hole_offset, 0]) nub();
 translate([bore_hole_offset, fan_width - bore_hole_offset, 0]) nub();
 translate([fan_width - bore_hole_offset, fan_width - bore_hole_offset, 0]) nub();
}

module nub() {
 translate([0, 0, box_height-1]) union() {
  cylinder(r=bore_hole_diameter/2, h=nub_height+1, $fn=100 );
  translate([0,0,nub_height+1])sphere(r=bore_hole_diameter/2,  $fn=100);
 }
};