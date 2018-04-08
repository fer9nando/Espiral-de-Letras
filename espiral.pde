/****************************************/
/*Luis Fernando Martínez Ramos 201022797*/
/****************************************/
/*********Espiral de letras**************/
/****************************************/
PFont font;

/*Cadenas de prueba*/
//String a = "La Segunda Guerra Mundial fue un conflicto militar global que se desarrolló entre 1939 y 1945.";//necesita separacion de vueltas *2 y .3 de suma
String a = "La Segunda Guerra Mundial fue un conflicto militar global que se desarrolló entre 1939 y 1945. En él se vieron implicadas la mayor parte de las naciones del mundo, incluidas todas las grandes potencias, agrupadas en dos alianzas militares enfrentadas: los Aliados de la Segunda Guerra Mundial y las Potencias del Eje.";

/*Variables para crear la espiral*/
int X=400, Y=200;       /*Puntos para centrar la espiral*/
int vueltas=totaldevueltas(a.length());          /*Ciclos de la espiral*/

float radio=vueltas*25;      /*Tamaño (radio) de la espiral entre mas grande el radio mas grande el circulo*/
int partes=(vueltas*15)+a.length()%15;          /*letras que estaran en el primer ciclo cada ciclo se restan 15*/
float segmentos=partes*vueltas;
float disminuir=radio/segmentos;     /*Cuando disminuir por cada parte de la espiral*/
float incRadio=radio/vueltas;        /*Tanto a incrementar en el radio por cada ciclo completo*///cuanto aumenta la diferencia entre espirales
float coorX,coorY;                   /*Puntos finales de la espiral para trazo entre segmentos*/
float yA;
float angulo=360.0;                 /*Angulo inicial*/
float espacio=360.0/partes;
float nuevo= 0.0;
float diferencia =0.0;
int tam=vueltas*5+5;
float anguloletra=90.0;
float separacion=(float)(20.0/vueltas)-((int)(20/vueltas));//separacion entre ciclos
float separacionguardada=separacion;
//float separacion=.08;
int fer = 0; //contador de letras
     
void setup(){
  if(vueltas>9)
  {
    separacion=separacion*.1;
    separacionguardada=separacion;
  }
  background(255,0,51);
  println(separacion);
  size(800,400);
  smooth();
  noLoop();
  font = loadFont("Calibri-LightItalic-12.vlw");
  textFont(font);
  fill(0);
  background(255);
  frameRate(4);
}

void draw()
{
  background(255,0,51);
  for(int j=vueltas; j>0; j--)/*Controlar numero de vueltas*/
    {
      tam=tam-4;//decrementa tamaño de letra
      textSize(tam);
      for(int i=1; i<=partes; i++)         /*Controlar numero letra en el ciclo*/
       {
            coorX=(radio-i*separacion)*cos(angulo/57.3)+X;        //x(t) = r * cos(t) + j
            yA=(radio-i*disminuir)*sin(angulo/57.3)+Y;           //y(t) = r * sen(t) + k
            coorY=-yA+2*Y;                                      /*ajuste en el eje Y*/
            //ingresamos nueva letra
            pushMatrix();
            translate(coorX, coorY);
            rotate(radians(anguloletra));
            if(fer<a.length()-1)
            text(a.charAt(fer++),0,0);
            popMatrix();
            angulo-=espacio;//decrementamos el angulo
            anguloletra+=espacio;//angulo de la letra
            if(anguloletra>=360)
              anguloletra=0;
            if( angulo <= 0)/*Validar angulos negativos*/
              angulo=360.0;
            //aqui se decrementara el espacio para que no se vea el cambio de golpe
            if(j!=vueltas && espacio<nuevo)
              espacio=espacio+diferencia;
       }
       /*Terminada un ciclo, empezamos nuevamente con nuevos puntos de referencia*/
       if(j==vueltas)
         partes=(partes-15)-(a.length()%15);
       else
         partes=partes-15;//cada vuelta se quitan 15
       segmentos=partes*vueltas;
       disminuir=radio/segmentos;     /*Cuando disminuir por cada parte de la espiral*/
       if(partes!=0)
       {
          nuevo=360.0/(partes-2);
          diferencia= nuevo/(partes);
       }
       //separacion entre ciclos
       separacion=separacion+(separacion/vueltas);
       radio-=incRadio;
    }
}

int totaldevueltas(int total)
{
   int vueltas=0;
   int cont=0;
   while(cont<total)
   {
     cont=cont+(15*vueltas);
     vueltas++;
       if((cont+15)>total)
         break;
   }
   return vueltas-1;
}