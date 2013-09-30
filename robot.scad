use <rampa.scad>
use <sueloChasis.scad>
module robot(numRampas=1,referenciaDimH=0, radioRuedas=25,ventilador=0){
	
	//CHASIS
	rotate([0,0,90])sueloChasis(radioRueda=radioRuedas,largoFondo=152,largoPiso=138,referenciaDimH=referenciaDimH);
	
	//RAMPA
	translate([0,-68,0])#rampa(profundidad=32,alto=60,inclinacion1=80);
	if(numRampas==2){
		mirror([0,1,0])translate([0,-65,0])#rampa(profundidad=32,alto=80);
	}
	
	//ARDUINO
	rotate([0,0,270]) translate([-35,-27,radioRuedas])  import("ArduinoMega.stl");
	
	
	//VENTILADOR
	if(ventilador==1){
	translate([0,0,2*radioRuedas+15]) union(){
		translate([0,0,5])import("Ventilador.stl");
		cube([80,80,10],center=true);
	}
	}

	//SENSOR UltraSonido
	translate([-74,30,2*radioRuedas+10]) rotate([0,0,45])   import("ultrasoundsensor.stl");
	mirror([1,0,0])translate([-74,30,2*radioRuedas+10]) rotate([0,0,45]) import("ultrasoundsensor.stl");
	mirror([0,1,0])translate([-74,30,2*radioRuedas+10]) rotate([0,0,45]) import("ultrasoundsensor.stl");
	mirror([0,1,0])mirror([1,0,0])translate([-74,30,2*radioRuedas+10]) rotate([0,0,45]) import("ultrasoundsensor.stl");


	//SENSORES IR
	translate([85,-10,2*radioRuedas-10])import("sharp.stl");
	mirror([1,0,0]) translate([85,-10,2*radioRuedas-10])import("sharp.stl");
	translate([10,74,2*radioRuedas-10]) rotate([0,0,90])import("sharp.stl");
	translate([0,-70,2*radioRuedas+10]) rotate([90,0,270])import("sharp.stl");
	
}


translate([0,40,0])
robot(numRampas=1,referenciaDimH=0,ventilador=1);