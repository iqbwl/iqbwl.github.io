---
layout: cheatsheet
title: JavaScript/Node.js Cheatsheet
description: Essential JavaScript and Node.js syntax and commands
---

# JavaScript/Node.js Cheatsheet

A comprehensive reference for JavaScript and Node.js.

## Variables

### Declaration
```javascript
var x = 10;              // Function-scoped
let y = 20;              // Block-scoped
const z = 30;            // Block-scoped, immutable
```

## Data Types

### Primitives
```javascript
let num = 42;            // Number
let str = "Hello";       // String
let bool = true;         // Boolean
let nothing = null;      // Null
let undef = undefined;   // Undefined
let sym = Symbol();      // Symbol
let big = 10n;           // BigInt
```

### Objects
```javascript
let obj = { key: 'value' };
let arr = [1, 2, 3];
let func = function() {};
```

## Operators

### Arithmetic
```javascript
+ - * / % **
++ --
```

### Comparison
```javascript
== != === !==
< > <= >=
```

### Logical
```javascript
&& || !
```

### Ternary
```javascript
condition ? true : false
```

## Arrays

### Methods
```javascript
arr.push(item)           // Add to end
arr.pop()                // Remove from end
arr.unshift(item)        // Add to start
arr.shift()              // Remove from start
arr.splice(index, count) // Remove/add
arr.slice(start, end)    // Copy portion
arr.concat(arr2)         // Merge arrays
arr.join(',')            // Join to string
arr.reverse()            // Reverse
arr.sort()               // Sort

// Iteration
arr.forEach(item => {})
arr.map(item => item * 2)
arr.filter(item => item > 5)
arr.reduce((acc, item) => acc + item, 0)
arr.find(item => item > 5)
arr.findIndex(item => item > 5)
arr.some(item => item > 5)
arr.every(item => item > 0)
```

## Objects

### Operations
```javascript
obj.key                  // Access
obj['key']               // Access
obj.key = 'value'        // Set
delete obj.key           // Delete
'key' in obj             // Check existence
Object.keys(obj)         // All keys
Object.values(obj)       // All values
Object.entries(obj)      // Key-value pairs
Object.assign({}, obj)   // Copy
{...obj}                 // Spread operator
```

## Functions

### Declaration
```javascript
// Function declaration
function func(a, b) {
    return a + b;
}

// Function expression
const func = function(a, b) {
    return a + b;
};

// Arrow function
const func = (a, b) => a + b;
const func = a => a * 2;
const func = () => console.log('hi');

// Default parameters
function func(a, b = 10) {
    return a + b;
}

// Rest parameters
function func(...args) {
    return args.reduce((a, b) => a + b);
}
```

## Control Flow

### If Statement
```javascript
if (condition) {
    // code
} else if (condition) {
    // code
} else {
    // code
}
```

### Switch
```javascript
switch (value) {
    case 1:
        break;
    case 2:
        break;
    default:
        break;
}
```

### Loops
```javascript
// For loop
for (let i = 0; i < 10; i++) {
    console.log(i);
}

// For...of (values)
for (const item of array) {
    console.log(item);
}

// For...in (keys)
for (const key in object) {
    console.log(key);
}

// While
while (condition) {
    // code
}

// Do-while
do {
    // code
} while (condition);
```

## ES6+ Features

### Destructuring
```javascript
// Array
const [a, b] = [1, 2];
const [first, ...rest] = [1, 2, 3, 4];

// Object
const {name, age} = person;
const {name: n, age: a} = person;
```

### Spread/Rest
```javascript
// Spread
const arr = [...arr1, ...arr2];
const obj = {...obj1, ...obj2};

// Rest
function func(...args) {}
```

### Template Literals
```javascript
const name = "John";
const greeting = `Hello, ${name}!`;
const multi = `Line 1
Line 2`;
```

### Promises
```javascript
const promise = new Promise((resolve, reject) => {
    if (success) resolve(value);
    else reject(error);
});

promise
    .then(result => {})
    .catch(error => {})
    .finally(() => {});

// Async/await
async function func() {
    try {
        const result = await promise;
    } catch (error) {
        console.error(error);
    }
}
```

### Classes
```javascript
class MyClass {
    constructor(value) {
        this.value = value;
    }
    
    method() {
        return this.value;
    }
    
    static staticMethod() {
        return 'static';
    }
}

class Child extends MyClass {
    constructor(value) {
        super(value);
    }
}
```

## Node.js Basics

### Modules
```javascript
// CommonJS
const module = require('module');
module.exports = {};
exports.func = () => {};

// ES Modules
import module from 'module';
import { func } from 'module';
export default {};
export const func = () => {};
```

### File System
```javascript
const fs = require('fs');

// Read file
fs.readFile('file.txt', 'utf8', (err, data) => {});
const data = fs.readFileSync('file.txt', 'utf8');

// Write file
fs.writeFile('file.txt', 'data', (err) => {});
fs.writeFileSync('file.txt', 'data');

// Promises
const fs = require('fs').promises;
await fs.readFile('file.txt', 'utf8');
```

### Path
```javascript
const path = require('path');

path.join('/a', 'b', 'c');
path.resolve('file.txt');
path.dirname('/a/b/c.txt');
path.basename('/a/b/c.txt');
path.extname('file.txt');
```

### HTTP Server
```javascript
const http = require('http');

const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello World\n');
});

server.listen(3000);
```

### Express
```javascript
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hello World');
});

app.post('/api', (req, res) => {
    res.json({ message: 'Success' });
});

app.listen(3000);
```

## NPM Commands

### Package Management
```bash
npm init                 # Initialize project
npm install package      # Install package
npm install -g package   # Install globally
npm install --save-dev package  # Dev dependency
npm uninstall package    # Remove package
npm update               # Update packages
npm outdated             # Check outdated
npm list                 # List installed
```

### Scripts
```json
{
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "jest"
  }
}
```

```bash
npm run script-name
npm start
npm test
```

## Quick Reference

| Operation | Syntax |
|-----------|--------|
| Console log | `console.log(x)` |
| Type check | `typeof x` |
| Array length | `arr.length` |
| String length | `str.length` |
| Parse int | `parseInt(str)` |
| Parse float | `parseFloat(str)` |
| JSON parse | `JSON.parse(str)` |
| JSON stringify | `JSON.stringify(obj)` |
| Set timeout | `setTimeout(fn, ms)` |
| Set interval | `setInterval(fn, ms)` |

## Best Practices

1. **Use const/let** instead of var
2. **Use === instead of ==**
3. **Use arrow functions** when appropriate
4. **Handle errors** with try-catch
5. **Use async/await** for promises
6. **Avoid callback hell**
7. **Use ESLint** for linting
8. **Use Prettier** for formatting
9. **Write tests**
10. **Use meaningful names**

## Resources

- MDN Web Docs: https://developer.mozilla.org/
- Node.js Docs: https://nodejs.org/docs/
- JavaScript.info: https://javascript.info/
- You Don't Know JS: https://github.com/getify/You-Dont-Know-JS
