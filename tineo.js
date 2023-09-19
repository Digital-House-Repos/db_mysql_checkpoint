/* PRE - EXAMEN FINAL */

// Jean Franco Tineo Atunca

//* EJERCICIO Nº1
let matriz = [[5, 2, 2], [2, 0, 2], [4, 4, 5],];

// ! item 1
//1) Retorne suma diagonal
const getSumaDiagonal = (matriz) => {
  let suma = 0;
  for (let i = 0; i < matriz.length; i++) {
    suma += matriz[i][i];
  }
  
  return suma;
}
// console.log(getSumaDiagonal(matriz));

// ! item 2
//2) Retorne array con pares
const getPares = (matriz) => {
  let parArray = [];
  for (let i = 0; i < matriz.length; i++) {
    for (let j = 0; j < matriz[i].length; j++) {
      if (matriz[i][j] % 2 == 0) {
        parArray.push(matriz[i][j])
      }
    }
  }

  return parArray;
}
// console.log(getPares(matriz))




//* EJERCICIO Nº2
let cuadros = [
  {
    nombre: "Mona Lisa",
    creador: "Leonardo Da Vinci",
  },
  {
    nombre: "La ultima cena",
    creador: "Leonardo Da Vinci",
  },
  {
    nombre: "La noche estrellada",
    creador: "Vincent van Gogh",
  },
  {
    nombre: "El grito",
    creador: "Edvard Munch",
  },
  {
    nombre: "Trigal con cuervos",
    creador: "Vincent van Gogh",
  },
  {
    nombre: "Maria Magdalena",
    creador: "Leonardo Da Vinci",
  },
  {
    nombre: "Amor y Dolor",
    creador: "Edvard Munch",
  },
  {
    nombre: "Ansiedad",
    creador: "Edvard Munch",
  },
];
// Recibe array, creador -> Retorna array con obras

// ! Item 1
const filtrarPorCreador = (array, creador) => {
  let arrayObras = [];
  for (let i = 0; i < array.length; i++) {
    if (array[i].creador == creador) {
      arrayObras.push(array[i].nombre);
    }
  }

  return arrayObras;
}
// console.log(filtrarPorCreador(cuadros, "Edvard Munch"));




// * EJERCICIO Nº3
// ! Item 1
// Comprueba orden alfabetico por creador (bubble sort)
const getArrayOrdenado = (pm_array) => {
  let pm_arrayCopia = pm_array.slice();
  
  for (let i = 0; i < pm_arrayCopia.length; i++) {
    for (let j = 0; j < pm_arrayCopia.length - 1; j++) {
      if (pm_arrayCopia[j].creador > pm_arrayCopia[j + 1].creador) {
        let adelante = pm_arrayCopia[j];
        
        pm_arrayCopia[j] = pm_arrayCopia[j + 1];
        pm_arrayCopia[j + 1] = adelante;
      }
    }
  }
  return pm_arrayCopia;
}

// ! Item 2
// Retorna true // false + array ordenado
const isArrayOrdenado = (pm_array) => {
  const arrayOrdenado = getArrayOrdenado(pm_array);
  let contador = 0;

  for (let elemento of pm_array) {
    if (elemento.nombre != arrayOrdenado[contador].nombre | elemento.creador != arrayOrdenado[contador].creador) {
      return {
        "Esta ordenado": false,
        "Array ordenado": arrayOrdenado
      };
    }
    contador += 1;
  }
  return {
    "Esta ordenado": true,
    "Array ordenado": pm_array
  };
}
// console.log(isArrayOrdenado(cuadros));




// * EJERCICIO Nº4
// ! Item 1
// 1) Funcion 1 parametro -> retorno triple
const getTriple = (pm_numero) => pm_numero * 3;
// console.log(getTriple(5));


// ! Item 2
// 2) Funcion 2 parametros -> Retorne producto
const getProducto = (pm_numero1, pm_numero2) => pm_numero1 * pm_numero2;
// console.log(getProducto(5,-2));


// ! Item 3
// 3) Funcion 2 parametros -> Retorno division (excepto cero)
const getDivision = (pm_numero1, pm_numero2) => {
  if (pm_numero2 == 0) {
    return "No existe división entre cero";
  } else {
    return pm_numero1 / pm_numero2;
  }
}
// console.log(getDivision(5, -2));
// console.log(getDivision(5, 0));


// * EJERCICIO Nº5
// ! Item 1
// 1) Crear matriz 5x7
const numeroAleatorio = (min, max) => {
  let numero = Math.random() * (max - min + 1) + min;
  return Math.floor(numero);
}
const setMatriz = (fila, columna) => {
  let matriz = [];
  for (let i = 1; i <= fila; i++) {
    let filas = [];
    for (let j = 1; j <= columna; j++) {
      filas.push(numeroAleatorio(1, 10));
    }
    matriz.push(filas)
  }
  
  return matriz
};
// let matriz5x7 = setMatriz(5, 7);
// console.log(matriz5x7);


// ! Item 2
// 2) Funcion retorne fila 4
const getSumaFila4 = (matriz) => {
  let sumaFila4 = 0;
  for (let elemento of matriz[3]) {
    sumaFila4 += elemento;
  }

  return sumaFila4;
}
// console.log(getSumaFila4(matriz5x7));




// * EJERCICIO Nº6
let personas = [
  {
    nombre: "Lucia",
    oficio: "Medica",
    edad: 37
  },
  {
    nombre: "Tiziano",
    oficio: "Programador",
    edad: 9
  },
  {
    nombre: "Julian",
    oficio: "Chofer",
    edad: 45
  },
  {
    nombre: "Adriana",
    oficio: "Chef",
    edad: 24
  },
]
// 1) funcion -> arreglo personas +25 años
const getPersonasMayor25 = (pm_array) => {
  let nuevoArray = [];

  for (let i = 0; i < pm_array.length; i++) {
    if (pm_array[i].edad > 25) {
      nuevoArray.push(pm_array[i].nombre);
    }
  }

  return nuevoArray;
}
// console.log(getPersonasMayor25(personas));