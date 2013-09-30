//Rampa

module rampa(inclinacion1=80,profundidad=40,ancho=200,alto=100,lonRampa2=20,grosor=5,porCientoRampa=0.1){

	lon1=(1-porCientoRampa)*alto/sin(inclinacion1);
	prof1=(1-porCientoRampa)*alto/tan(inclinacion1);
	

	lon2=sqrt(pow((porCientoRampa*alto),2)+pow((profundidad-prof1),2));
	a2=sqrt(pow(lon2,2)-pow(porCientoRampa*alto,2));
	inclinacion2=asin(porCientoRampa*alto/lon2);
	a1=lon1*cos(inclinacion1);
	translate([0,-a1,0]) union(){
		translate([-ancho/2,0,alto*porCientoRampa]) rotate([inclinacion1,0,0]) cube([ancho,lon1,grosor]);
	
		translate([-ancho/2,-a2,0]) rotate([inclinacion2,0,0]) cube([ancho,lon2,grosor]);
	}
}

rampa(inclinacion1=80,profundidad=50,alto=100,porCientoRampa=0.1);