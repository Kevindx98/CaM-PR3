from time import time
import itertools
"""
Misioneros 1
Canibales  2
"""
def numero_misioneros(lista):
    aux = 0
    for l in lista:
        if l == 1:aux=aux+1
    return aux

def numero_canibales(lista):
    aux = 0
    for l in lista:
        if l == 2:aux=aux+1
    return aux

if __name__ == '__main__':
    orillaA = [1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

    orillaB = []
    print(numero_misioneros(orillaA))
    print(numero_canibales(orillaA))
    if len(orillaA)%3 != 0:print("NO ES MUTIPLO DE TRES");exit(1)
    print(len(orillaA))
    start_time = time()
    while orillaA != []:
        print("ORILLA_A -->" + str(orillaA))
        for elemento in itertools.combinations(orillaA,3):
            #casteo de tupla a lista
            it = list(elemento)
            #copia auxiliar
            aux = orillaA.copy()
            auxB = orillaB.copy()
            print(it)
            #simulación de la siguente lista posible
            for i in it:aux.remove(i)
            for i in it:auxB.append(i)
            #condiciones
            if (numero_misioneros(it) > numero_canibales(it) or numero_misioneros(it) == 0) \
                    and numero_misioneros(aux) != 1 and (numero_canibales(aux) <= numero_misioneros(aux) or numero_misioneros(auxB) == 0)\
                    and numero_canibales(auxB) <= numero_misioneros(auxB) or numero_misioneros(auxB):
                print(it)
                #simulación del bote
                for i in it:
                    orillaA.remove(i)
                    orillaB.append(i)
                break;
    elapsed_time = time() - start_time
    print(orillaA)
    print(orillaB)
    print(elapsed_time)