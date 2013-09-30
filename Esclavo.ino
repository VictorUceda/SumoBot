/*
Pequeño intento de programa que controlara el arduino micro
 Autor: Pedro Valero Mejia
 Funcion: Leer sensores y conocer en todo instante la posicion del enemigo
 Fecha creacion: 26/09/2013  20:29
Prueba de git
 */

//Librerias
#include <Wire.h>

#define FIRST 1
//Declaro los pines que voy a utilizar. Son "macros".

const int sensorNorth = A1;
const int sensorEast = A2;
const int sensorWest = A3;
const int sensorSouth = A4;

const int sonarA = A5;
const int sonarB = A6;
const int sonarC = A7;

//Distancia de los sensores al origen, suponiendo que los colocamos en los ejes
const double distA = 5;
const double distB = 5;
const double distC = 5;

const int code = 4;//Codigo como esclavo
const double sound=34.32;

//Variables globales para guardar informacion 
struct POSITION{
  double x;
  double y;
};

POSITION pos={0 , 0};

const int sensorMin=800; //Valor a partir del cual consideramos que el sensor ha localizado al rival

void sonar(){
}

void firstSonar(){
  unsigned long pulse;
  float distanceA, distanceB, distanceC;
  float tempY;
  
  //Primero vamos a leer los datos de los sensores
  pinMode(sonarA, OUTPUT); //ponemos el pin como salida
  digitalWrite(sonarA, HIGH); //lo activamos
  delayMicroseconds(10); //esperamos~habra que ver el por que de este tiempo y si se puede bajar
  digitalWrite(sonarA, LOW); //lo desactivamos
  pinMode(sonarA, INPUT); //ponemos el pin como entrada
  pulse=pulseIn(sonarA, HIGH); //Ya sabemos los microsegundos que ha tardado en llegar el sonido
  
  distanceA=((float(pulse/1000.0))*sound)/2;
  
  pinMode(sonarB, OUTPUT); //ponemos el pin como salida
  digitalWrite(sonarB, HIGH); //lo activamos
  delayMicroseconds(10); //esperamos~habra que ver el por que de este tiempo y si se puede bajar
  digitalWrite(sonarB, LOW); //lo desactivamos
  pinMode(sonarB, INPUT); //ponemos el pin como entrada
  pulse=pulseIn(sonarB, HIGH); //Ya sabemos los microsegundos que ha tardado en llegar el sonido
  
  distanceB=((float(pulse/1000.0))*sound)/2;
  
  pinMode(sonarC, OUTPUT); //ponemos el pin como salida
  digitalWrite(sonarC, HIGH); //lo activamos
  delayMicroseconds(10); //esperamos~habra que ver el por que de este tiempo y si se puede bajar
  digitalWrite(sonarC, LOW); //lo desactivamos
  pinMode(sonarC, INPUT); //ponemos el pin como entrada
  pulse=pulseIn(sonarC, HIGH); //Ya sabemos los microsegundos que ha tardado en llegar el sonido
  
  distanceC=((float(pulse/1000.0))*sound)/2;
  
  //Triangulacion con los sonares para detectar posicion y codificacion de la informacion
  pos.x=(distB*distB-distanceB+distanceC)/(-2*distC+2*distB);
  tempY=sqrt(distanceB-(pos.x-distB)*(pos.x-distB));
  
  if(pos.x*pos.x+(tempY-distA)*(tempY-distA)-distanceA>pos.x*pos.x+(-tempY-distA)*(-tempY-distA)-distanceA){
    pos.y=-tempY;
  }else{
    pos.y=tempY;
  }
  
}

void receiveEvent(int howmany)
{
  Wire.write((byte*)&pos, sizeof(pos)); //Informacion enviada al maestro
  pos.x=0; //Lo ponemos a 0, si el maestro recibe (0,0) sera que el esclavo no ha tenido tiempo de hacer los calculos
  pos.y=0;
}

void setup(){
  Wire.begin(code);//Me identifico como esclavo con codigo=code
  Wire.onReceive(receiveEvent); //Funcion a la que saltare al recibir una orden del maestro
  Serial.begin(9600);
  //Posibles cuentas para ajuste de sensores
}

void loop(){
  double dist;
  if((dist=analogRead(sensorNorth)) >= sensorMin){
    pos.y=dist;
    pos.x=0;
  }
  else if((dist=analogRead(sensorEast)) >= sensorMin){
    pos.x=dist;
    pos.y=0;
  }
  else if((dist=analogRead(sensorWest)) >= sensorMin){
    pos.x=-dist;
    pos.y=0;
  }
  else if((dist=analogRead(sensorSouth)) >= sensorMin){
    pos.y=-dist;
    pos.x=0;
  }
  else{
    if(FIRST) firstSonar();
    else sonar();
  }
}




