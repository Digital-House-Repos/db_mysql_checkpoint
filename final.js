// Final JavaScript
// Jean Franco Tineo Atunca - Camada 02

// * Ejercicio 01
let paises = [
  {
    nombre: "Argentina",
    continente: "Sudamérica",
    poblacion: 40000000
  },
  {
    nombre: "Colombia",
    continente: "Sudamérica",
    poblacion: 50372000
  },

  {
    nombre: "Brasil",
    continente: "Sudamérica",
    poblacion: 300000000
  },
  {
    nombre: "Etiopía",
    continente: "África",
    poblacion: 15000000
  },
  {
    nombre: "Chile",
    continente: "Sudamérica",
    poblacion: 10000000
  }
];

const obtenerPaises = (pmArray, pmContinente, pmPoblacion) => {
  let nuevoArray = [];

  for (let i = 0; i < pmArray.length; i++) {
    if (pmArray[i].continente == pmContinente && pmArray[i].poblacion >= pmPoblacion) {
      nuevoArray.push(pmArray[i]);
    }
  }
  return nuevoArray;
}
// console.log(obtenerPaises(paises, "Sudamérica", 40000000));


// * Ejercicio 02
let arrayDeNumeros = [1, 2, 3, 8, 9, 104, 5, 6, 7, 15];

const ordenarArray = (pmArray, pmOrden) => {
  if (pmOrden.toUpperCase() == "ASC") {
    for (let i = 0; i < pmArray.length; i++) {
      for (let j = 0; j < pmArray.length - i - 1; j++) {
        if (pmArray[j] > pmArray[j + 1]) {
          let posterior = pmArray[j];
          pmArray[j] = pmArray[j + 1];
          pmArray[j + 1] = posterior;
        }
      }
    }
    return pmArray;
  }
  else if (pmOrden.toUpperCase() == "DESC") {
    for (let i = 0; i < pmArray.length; i++) {
      for (let j = 0; j < pmArray.length - i - 1; j++) {
        if (pmArray[j] < pmArray[j + 1]) {
          let posterior = pmArray[j];
          pmArray[j] = pmArray[j + 1];
          pmArray[j + 1] = posterior;
        }
      }
    }
    return pmArray;
  }
  else {
    return "Debes seleccionar alguna opción correcta. ASC o DESC";
  }

}
// console.log(arrayDeNumeros);
// console.log(ordenarArray(arrayDeNumeros, "Asc"));
// console.log(ordenarArray(arrayDeNumeros, "DESC"));
// console.log(ordenarArray(arrayDeNumeros, "asCd"));


// Ejercicio 03
let matriz = [
  [5, 2, 2],
  [2, 5, 2],
  [4, 4, 5]
];

const obtenerSumaFila1 = (pmMatriz) => {
  let suma = 0;
  for (let i = 0; i < pmMatriz[0].length; i++) {
    suma += pmMatriz[0][i];
  }
  return suma;
}
// console.log(obtenerSumaFila1(matriz));

const obtenerPares = (pmMatriz) => {
  let arrayPares = [];
  for (let i = 0; i < pmMatriz.length; i++) {
    for (let j = 0; j < pmMatriz[i].length; j++) {
      if (pmMatriz[i][j] % 2 == 0) {
        arrayPares.push(pmMatriz[i][j]);
      }
    }
  }
  return arrayPares;
}
// console.log(obtenerPares(matriz));