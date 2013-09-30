translate([0,0,-5])
union(){
union(){
union(){
translate([50,170,0])
	rotate([90,0,0])
		import("/Users/victor/Dropbox/RobotSumo/Estruturas3D/rueda.stl");

translate([150,170,0])
	rotate([90,0,0])
		import("/Users/victor/Dropbox/RobotSumo/Estruturas3D/rueda.stl");
}
translate([50,-30,0])
	rotate([90,0,180])
		import("/Users/victor/Dropbox/RobotSumo/Estruturas3D/rueda.stl");
}
translate([150,-30,0])
	rotate([90,0,180])
		import("/Users/victor/Dropbox/RobotSumo/Estruturas3D/rueda.stl");
}



cube([200,140,5]);


translate([0,-30,-150])
	cube([200,200,5]);

