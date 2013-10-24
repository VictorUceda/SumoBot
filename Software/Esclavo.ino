/*
Pequeño intento de programa que controlara el arduino micro
 Autor: Pedro Valero Mejia
 Funcion: Leer sensores y conocer en todo instante la posicion del enemigo
 Fecha creacion: 26/09/2013  20:29
 */

//Librerias
#include <Wire.h>
#include <stdlib.h>
#include <stdio.h>

#define FIRST 1
//Declaro los pines que voy a utilizar. Son "macros".

const int sensorNorth = A0;
const int sensorEast = A1;
const int sensorWest = A2;
const int sensorSouth = A3;

const int sonarA = A4;
const int sonarB = A5;
const int sonarC = A6;
const int sonarD = A7;

//Distancia de los sensores al origen, suponiendo que los colocamos en los ejes
const double posSonarA = 5;
const double posSonarB = 5;
const double posSonarC = 5;
const double posSonarD = 5;

const int code = 4;//Codigo como esclavo
const double sound=34.32;

//Variables globales para guardar informacion 
struct POSITION{
  double x;
  double y;
};

POSITION pos={
  0 , 0};

const int sensorMin=80; //Valor a partir del cual consideramos que el sensor ha localizado al rival
const int sonarMax=300; //Valor a partir del cual consideramos que el sensor ha localizado al rival
#define CM(sonar)  sonar/10
//#define PITAGORAS(H, C)  sqrt(H*H-C*C) // NO se si esto valdria

/*
Metodo de comparacion de doubles.
 Devuelve un un numero negativo, cero, o positivo
 en caso de que arg1 sea menor, igual o mayor que arg2,
 respectivamente
 */
int comp_double(const void *arg1, const void *arg2){
  if (*(double*)arg1 < *(double*)arg2) return -1;
  else if (*(double*)arg1 > *(double*)arg2) return 1;
  else return 0;
}


/*
Devuelve la mediana de un array de doubles.
 Recibe un puntero a double, o nombre del array
 y el numero de elementos del array.
 */
double median_double(double *array, size_t num){
  qsort((void *) array, num, sizeof(double), comp_double);
  return array[(num - 1) / 2];
}

/*
Funcion que analiza los sensores de ultrasonidos
 No devuelve nada y actualiza directamente los valores de la estructura pos
 */
void sonar(){
  float distanceA, distanceB, distanceC, distanceD;

  if(pos.y>0){
    distanceA=analogRead(sonarA);
    if(distanceA<sonarMax){
      pos.x=-sqrt(CM(distanceA)*CM(distanceA)-pos.y*pos.y);//Pitagoras
    }
    else{ 
      distanceB=analogRead(sonarB);
      if(distanceB<sonarMax){
        pos.x=sqrt(CM(distanceB)*CM(distanceB)-pos.y*pos.y);//Pitagoras
      }
    }
  }
  else if(pos.y<0){
    distanceD=analogRead(sonarD);
    if(distanceD<sonarMax){
      pos.x=-sqrt(CM(distanceD)*CM(distanceD)-pos.y*pos.y);//Pitagoras
    }
    else{ 
      distanceC=analogRead(sonarC);
      if(distanceC<sonarMax){
        pos.x=sqrt(CM(distanceC)*CM(distanceC)-pos.y*pos.y);//Pitagoras
      }
    }
  }
  else{ // El enemigo esta en un lateral
    if(pos.x>0){
      distanceB=analogRead(sonarB);
      if(distanceB<sonarMax){
        pos.y=sqrt(CM(distanceB)*CM(distanceB)-pos.x*pos.x);//Pitagoras
      }
      else if(pos.x<0){
        distanceC=analogRead(sonarC);
        if(distanceC<sonarMax){
          pos.y=-sqrt(CM(distanceC)*CM(distanceC)-pos.x*pos.x);//Pitagoras
        }
      }
      else {//Esta en el otro lado
        distanceD=analogRead(sonarD);
        if(distanceD<sonarMax){
          pos.y=-sqrt(CM(distanceD)*CM(distanceD)-pos.x*pos.x);//Pitagoras
        }
        else{
          distanceA=analogRead(sonarA);
          if(distanceA<sonarMax){
            pos.y=sqrt(CM(distanceA)*CM(distanceA)-pos.x*pos.x);//Pitagoras
          }
        }
      }
    }
  }
  /*Mide como poco  11 y como maximo unos 100 y algo. De 11 no baja nunca y empieza a marcar 11 cuando esta  amenos de 14 cm. Es bastante direccional,
   no cubre toda una esfera realmente sino un arco mas bien
   Serial.println(analogRead(1));*/

}

/*
Metodo de comunicacion con maestro
 Envia al maestro la informacion sobre la posicion del rival relativa
 */
void receiveEvent(int howmany)
{
  Wire.write((byte*)&pos, sizeof(pos)); //Informacion enviada al maestro
}

/*
Metodo de analisis de sensores infrarrojos.
 Recorre todos los sensores infrarrojos hasta localizar al rival.
 Actualiza el valor de pos.
 Devuelve :
 0 encontro al rival
 1 si fallo en la busqueda
 */
int infrarrojo(){
  double dist;
  double distances[50];
  double distance;
  int i;

  if((dist=analogRead(sensorNorth)) >= sensorMin){
    for(i=0;i<50;i++){
      distances[i]=dist;
      dist=analogRead(sensorNorth);
    }

    pos.y=4800/(median_double(distances, 50)-20);
    pos.x=0;
    //Serial.println(pos.y);
    //delay(100);
  }
  else if((dist=analogRead(sensorEast)) >= sensorMin){
    for(i=0;i<50;i++){
      distances[i]=dist;
      dist=analogRead(sensorEast);
    }
    pos.x=4800/(median_double(distances, 50)-20);
    pos.y=0;
  }
  else if((dist=analogRead(sensorWest)) >= sensorMin){
    for(i=0;i<50;i++){
      distances[i]=dist;
      dist=analogRead(sensorWest);
    }
    pos.x=-4800/(median_double(distances, 50)-20);
    pos.y=0;
  }
  else if((dist=analogRead(sensorSouth)) >= sensorMin){
    for(i=0;i<50;i++){
      distances[i]=dist;
      dist=analogRead(sensorSouth);
    }
    pos.y=-4800/(median_double(distances, 50)-20);
    pos.x=0;
  }
}

void setup(){
  Wire.begin(code);//Me identifico como esclavo con codigo=code
  Wire.onReceive(receiveEvent); //Funcion a la que saltare al recibir una orden del maestro
  Serial.begin(9600);

  delayMicroseconds(10);
  //Posibles cuentas para ajuste de sensores
}

void loop(){

  if(infrarrojo()!=0){
    sonar();
  }
}
















