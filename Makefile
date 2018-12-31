model-60-3mm.stl: box.scad
	openscad -o "model-60.stl" -D "fan_width=60; screw_hole_offset=5; screw_hole_diameter=3; nut_width=5.5;" box.scad

model-60-4mm.stl: box.scad
	openscad -o "model-60.stl" -D "fan_width=60; screw_hole_offset=5; screw_hole_diameter=4; nut_width=7;" box.scad

model-70-3mm.stl: box.scad
	openscad -o "model-70.stl" -D "fan_width=70; screw_hole_offset=4.25; screw_hole_diameter=3; nut_width=5.5;" box.scad

model-70-4mm.stl: box.scad
	openscad -o "model-70.stl" -D "fan_width=70; screw_hole_offset=4.25; screw_hole_diameter=4; nut_width=7;" box.scad
