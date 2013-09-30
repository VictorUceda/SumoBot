//__RUEDA HUECA radio=2cm EJE POLOLU
module rueda(radio=25,largo=50){
color([0,0.8,0.9,0.3])
difference(){
	//--RUEDA radio=2.5cm POLOLU
	difference(){
	cylinder(r=radio, h=largo, $fn=100);

	//--Orificio del eje de los Motores Pololu
	translate([0,0,-20])
		difference(){
		cylinder(r=3/2,h=largo*3, $fn=50);
		translate([1,-1.5,-1])
			cube([3,3,100]);
		}
	}


	//--Cilindro hueco rpara el motor
	translate([0,0,5])
		cylinder(r=radio-5, h=largo, $fn=100);
}



//--Motor pololu
color([0.4,0.4,0.4])
translate([0,-1,32]) rotate([180,0,0])  union(){
	import("/Users/victor/Dropbox/RobotSumo/Estruturas3D/motor_housing.STL");

	translate([-6,4,17]) rotate([90,0,90]) import("/Users/victor/Dropbox/RobotSumo/Estruturas3D/motor.STL");
}


//--Estructura union
color("blue")
translate([-14,5,6]) cube([28,5,largo+20]);
cylinder(r=25/2,h=64);
}
rueda(radio=35);
