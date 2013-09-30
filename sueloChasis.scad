use <rueda.scad>
module sueloChasis(distanciaEntreRuedas=30, radioRueda=25, largoRueda=40,alturaPiso=10, referenciaDimH=0, largoFondo=180,largoPiso=150){

distanciaER=distanciaEntreRuedas+radioRueda*2;
translate([0,0,radioRueda-6])
union(){	
	//Ruedas derecha
	rotate([0,180,0]) union(){
		translate([-(distanciaER/2),100,-7.5]) rotate([90,0,0]) rueda(radioRueda,largoRueda);
		translate([(distanciaER/2),100,-7.5]) rotate([90,0,0]) rueda(radioRueda,largoRueda);	
	}	
	
	//Ruedas Izquierda
	mirror([0,1,0])  rotate([0,180,0]) union(){
		translate([-(distanciaER/2),100,-7.5]) rotate([90,0,0]) rueda(radioRueda,largoRueda);
		translate([(distanciaER/2),100,-7.5]) rotate([90,0,0]) rueda(radioRueda,largoRueda);	
	}
	
	//--FONDO PLANO
	color("blue")
	difference(){
		cube([largoFondo,180,5],center=true);
	
		translate([distanciaER/2,100-largoRueda/2-5,0]) cube([radioRueda*2+10,largoRueda+10,40],center=true);
		translate([-distanciaER/2,100-largoRueda/2-5,0]) cube([radioRueda*2+10,largoRueda+10,40],center=true);
		mirror([0,1,0]){
			translate([distanciaER/2,100-largoRueda/2-5,0]) cube([radioRueda*2+10,largoRueda+10,40],center=true);
			translate([-distanciaER/2,100-largoRueda/2-5,0]) cube([radioRueda*2+10,largoRueda+10,40],center=true);
		}
		
	}
	
	//CUBO DE REFERENCIA
	if(referenciaDimH>0){
		color([0,1,0,0.3])
		translate([0,0,referenciaDimH/2-radioRueda+6]) cube([200,200,referenciaDimH],center=true);
	}

	//columnas apoyo
	translate([distanciaER/2,100-largoRueda-10,0]) difference(){
		cylinder(r=5,radioRueda+alturaPiso,$fn=100);
		translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
	}
	translate([-distanciaER/2,100-largoRueda-10,0]) difference(){
		cylinder(r=5,radioRueda+alturaPiso,$fn=100);
		translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
	}
	mirror([0,1,0]){
		translate([distanciaER/2,100-largoRueda-10,0]) difference(){
			cylinder(r=5,radioRueda+alturaPiso,$fn=100);
			translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
		}
		translate([-distanciaER/2,100-largoRueda-10,0]) difference(){
			cylinder(r=5,radioRueda+alturaPiso,$fn=100);
			translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
		}
	}

	//2º PISO
	difference(){
		translate([0,0,radioRueda+alturaPiso+2.5]) cube([largoPiso,160,5],center=true);
		translate([distanciaER/2,100-largoRueda-10,0]) translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
		translate([-distanciaER/2,100-largoRueda-10,0]) translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
		mirror([0,1,0]){
			translate([distanciaER/2,100-largoRueda-10,0]) translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
			translate([-distanciaER/2,100-largoRueda-10,0]) translate([0,0,-10])cylinder(r=3,h=radioRueda+alturaPiso+200,$fn=3);
		cube([50,120,100+alturaPiso*2],center=true);
		rotate([0,0,90])cube([55,120,100+alturaPiso*2],center=true);
		}
	}
}
}
sueloChasis();
//sueloChasis(distanciaEntreRuedas=40,radioRueda=20,largoRueda=30);