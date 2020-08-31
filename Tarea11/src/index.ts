const parser = require('./Gramatica/Gramatica');
const fs = require('fs');

const ast = parser.parse('(a+b)*(c-d)');



