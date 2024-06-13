function square(n) { // fun declaration 
  return n * n;
}
console.log(square(5)); // fun call

function ex(n) {
  console.log("Hi");
  return n * n; // stop execution
  console.log("Hi");
  console.log("Hi");
  console.log("Hi");
}
console.log(ex(2));

const double = (n) => n * 2; // one line function

const double1 = (n) =>{
  return  n * 2;
} 
console.log(double(10)); 
console.log(double1(50)); 
