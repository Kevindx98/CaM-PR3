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
orillaA = read.table("fichero_avanzado.txt", skip=archivo, nrow=1)
orillaA = as.numeric(orillaA)
while(orillaA[1] != -1){
  print("==========================================================================")
  orillaB = c()
  print(paste("Caso N�mero: ", archivo+1))
  archivo=archivo+1
  print("==========================================================================")
  if((Numero_Canibales(orillaA) + Numero_Misioneros(orillaA)) %% 3 != 0){
    print("ERROR: El n�mero de personas no es m�ltiplo de 3.")
  }else if(Numero_Canibales(orillaA) > Numero_Misioneros(orillaA)){
    print("ERROR: Hay m�s can�bales que misioneros.")
  }else{
    flag = 1;
    while (length(orillaA) != 0) {
      print(paste("Numero de Misioneros: ", Numero_Misioneros(orillaA)))
      print(paste("Numero de Can�bales: ", Numero_Canibales(orillaA)))
      print("ORILLA A -->")
      print(orillaA)
      print("ORILLA B -->")
      print(orillaB)
      iter = icombinations(orillaA,3)
      lista = iter$getnext()
      sizeFlag = length(orillaA);
      while (length(lista) != 0){
        auxA <- orillaA
        auxB <- orillaB
        for(i in 1:length(lista)){
          auxA = auxA[-match(lista[i],auxA)]
          auxB = append(auxB,lista[i])
        }
        if((Numero_Misioneros(lista) > Numero_Canibales(lista) || Numero_Misioneros(lista) == 0) &&
           Numero_Misioneros(auxA) != 1 && (Numero_Canibales(auxA) <= Numero_Misioneros(auxA) || Numero_Misioneros(auxA) == 0) &&
           Numero_Canibales(auxB) <= Numero_Misioneros(auxB)){
          print("La combinaci�n ganadora es: ")
          print(lista)
          for (j in 1:length(lista)){
            orillaA = orillaA[-match(lista[j],orillaA)]
            orillaB = append(orillaB,lista[j])
          }
          iter = icombinations(orillaA,3)
          lista = iter$getnext
          break
        }
        lista = iter$getnext()
      }
      if(length(orillaA) == sizeFlag){
        print("############################################################################")
        print("Combinaci�n Imposible de Resolver")
        print("############################################################################")
        flag = 0
        break
      }
      print("############################################################################")
    }
    if (flag == 1){ 
      print("El resultado final de la Orilla A es:")
      print(orillaA)
      print("El resultado final de la Orilla B es:")
      print(orillaB)
    }
  }
  orillaA = read.table("fichero_avanzado.txt", skip=archivo, nrow=1)
  orillaA = as.numeric(orillaA)
}
print("############################################################################")
print("FINAL DE LOS TESTS")
print("############################################################################")
