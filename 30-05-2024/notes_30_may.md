# 30 MAY

- var has global scope and let has local scope
- if not defined it show undefined
- if we declare var in a function we cannot assecc outside of the function

### scope of variable in function

````js
function drivingtest1(age) {
        let msg;
        if (age > 18) {
          msg = "eligible";
        } else {
          msg = "not eligible";
        }
        console.log(msg);
      }
      //   console.log(t1);
      //   console.log(t2);
      drivingtest1(20);
      ```

````

### Arthmetic operation among variables

```js
let a = 7;
let b = "5";
console.log(a + b); // 75
console.log(a + parseInt(b)); //12
console.log(a + b + 2); // 752
console.log(a + a + b); //145
console.log(a - b); // 2

console.log([1, 2, 3] + "abc"); //1,2,3abc
console.log([1, 2, 3] + "abc"); //1,2,3abc
console.log(typeof ([] + [])); //empty string

console.log(null + 5); //5
console.log(2 / "a"); //NaN
console.log(typeof NaN); //Number
```

### Double and triple equals which is faster

- == Checks for the value, Allows type casting, allows coesion
- === Checks for the value and data type

```js
g1 = 5;
g2 = "5";
console.log(g1 == g2); // true , string is converted into number
console.log(g1 === g2); // false
```

- Among both === is faster since only onestep

### Types of functions

#### Normal Function

```js
function square(n) {
  return n * n;
}
console.log(square(5)); // 25
```

- function stop executing after reach return statement

```js
function ex(n) {
  console.log("Hi");
  return n * n; // stops executing
  console.log("Hi");
  console.log("Hi");
  console.log("Hi");
}
console.log(ex(2)); // Hi 4
```

- two ways to exit one is return 2nd is after execute all stmts in the function
- DRY -> _Don't Repeat Yourself_
- 5 pillars of code Quality

1. Readability - _75% we read the code_
2. Maintainability - _code debt_
3. Extensibility - _We can add more featues in future_
4. Testability
5. Performance

#### arrow Function

#### anonymous Function

#### IIFE (Pattern)

## Spread operator

```js
q1 = [100, 200];
q2 = [...q1];

q3 = [60, ...q1, 90, 40];
console.log(q3);

t1 = [400, 500];
t2 = [90, 80];
t3 = [...t2, ...t1];
console.log(t3);
```

## loops

#### For Loops

```js
const marks = [80, 90, 100, 70, 60];
```

#### Normal for loop

```js
//More control over Loop
for (let index = 0; index < marks.length; index++) {
  console.log("Index: ", index, " Marks: ", marks[index]);
}
```

#### For in loop

```js
//Readable and simple | in -> index
for (let i in marks) {
  console.log("Index: ", i, " Marks: ", marks[i]);
}
```

#### For of loop

```js
//Cleaner and readable
for (let mark of marks) {
  console.log("Mark: ", mark);
}
```
