#Si no se tiene instalado el paquete que genera las iteraciones de combinaciones, se instala
if(! is.element("arrangements", installed.packages()[,1])){
  install.packages("arrangements")
}
library("arrangements")

#Librer�a que se iba a utilizar para coger ruta relativa a trav�s de CMD. 
#(No funciona si se ejecuta fuera de �ste)

#if(! is.element("rstudioapi", installed.packages()[,1])){
#  install.packages("rstudioapi")
#}
#library("rstudioapi")
#setwd(dirname(getActiveDocumentContext()$path))


#N�Canibales
Numero_Canibales <- function(x){
  if (length(x) == 0){
    return (0);
  }
  res <- 0
  for (i in 1:length(x)){
    if (x[i] == 2){
      res = res + 1
    }
  }
  return (res)
}

#N�Misioneros
Numero_Misioneros <- function(x){
  if (length(x) == 0){
    return (0);
  }
  res <- 0
  for (i in 1:length(x)){
    if (x[i] == 1){  
      res = res + 1
    }
  }
  return (res)
}

#Can�bales = 2
#Misioneros = 1
print("############################################################################")
print("INICIO DE LOS TESTS")
print("############################################################################")
archivo=0
#Se lee el una l�nea del fichero y se trata como un vector
orillaA = read.table("fichero_b�sico.txt", skip=archivo, nrow=1)
orillaA = as.numeric(orillaA)
#Mientras que lo que haya le�do no sea un "-1"...
while(orillaA[1] != -1){
  print("==========================================================================")
  orillaB = c()
  print(paste("Caso N�mero: ", archivo+1))
  archivo=archivo+1
  print("==========================================================================")
  #Comprobaci�n de par�metros que impedir�an el �xito del algoritmo.
  if((Numero_Canibales(orillaA) + Numero_Misioneros(orillaA)) %% 3 != 0){
    print("ERROR: El n�mero de personas no es m�ltiplo de 3.")
  }else if(Numero_Canibales(orillaA) > Numero_Misioneros(orillaA)){
    print("ERROR: Hay m�s can�bales que misioneros.")
  }else{
    flag = 1;
    #Mientras siga habiendo personas en la orilla A...
    while (length(orillaA) != 0) {
      print(paste("Numero de Misioneros: ", Numero_Misioneros(orillaA)))
      print(paste("Numero de Can�bales: ", Numero_Canibales(orillaA)))
      print("ORILLA A -->")
      print(orillaA)
      print("ORILLA B -->")
      print(orillaB)
      #Se crea el iterador y se coge la primera combinaci�n.
      iter = icombinations(orillaA,3)
      lista = iter$getnext()
      sizeFlag = length(orillaA);
      #Mientras que la combinaci�n escogida no sea nula (Exista alguna combinaci�n a�n).
      while (length(lista) != 0){
        auxA <- orillaA
        auxB <- orillaB
        #Se crean dos vectores auxiliares que simulan el crecimiento y decrecimiento de las orillas con esa combinaci�n.
        for(i in 1:length(lista)){
          auxA = auxA[-match(lista[i],auxA)]
          auxB = append(auxB,lista[i])
        }
        #Si una serie de condiciones se cumplen, la combinaci�n es v�lida.
        if((Numero_Misioneros(lista) > Numero_Canibales(lista) || Numero_Misioneros(lista) == 0) &&
           Numero_Misioneros(auxA) != 1 && (Numero_Canibales(auxA) <= Numero_Misioneros(auxA) || Numero_Misioneros(auxA) == 0) &&
           Numero_Canibales(auxB) <= Numero_Misioneros(auxB)){
          print("La combinaci�n ganadora es: ")
          print(lista)
          #Se procede a llevarla a cabo en las orillas de verdad.
          for (j in 1:length(lista)){
            orillaA = orillaA[-match(lista[j],orillaA)]
            orillaB = append(orillaB,lista[j])
          }
          #Se recoge la siguiente combinaci�n y se sale del while m�s interno.
          iter = icombinations(orillaA,3)
          lista = iter$getnext
          break
        }
        #En caso de no tener �xito, simplemente se recoge la siguiente combinaci�n.
        lista = iter$getnext()
      }
      #Si la longitud de la Orilla de A no ha cambiado con ninguna combinaci�n, es que el problema no se puede
      #resolver con la combinaci�n de personas que hay en la Orilla de A.
      if(length(orillaA) == sizeFlag){
        print("############################################################################")
        print("Combinaci�n Imposible de Resolver")
        print("############################################################################")
        flag = 0
        break
      }
      print("############################################################################")
    }
    #Si ha habido �xito, se imprimen los resultados
    if (flag == 1){ 
      print("El resultado final de la Orilla A es:")
      print(orillaA)
      print("El resultado final de la Orilla B es:")
      print(orillaB)
    }
  }
  #Se recoge el siguiente vector del fichero
  orillaA = read.table("fichero_b�sico.txt", skip=archivo, nrow=1)
  orillaA = as.numeric(orillaA)
}
print("############################################################################")
print("FINAL DE LOS TESTS")
print("############################################################################")
