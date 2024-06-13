// Task 5
// const movieUrl = (domain, genre, year) => {
//     return "http://" + domain + "?genere=" + genre + "&year=" + year;
//   };

//   console.log(movieUrl("imdb.com", "thriller", 2020));

// Task 5
const movieUrl = (domain, genre, year) => {
  return `http://${domain}?genere=${genre}&${year}=year`;
};

console.log(movieUrl("imdb.com", "thriller", 2020));
// output: http://imdb.com?genere=thriller&2020=year

// function transformSentence(s) {
//   // Your code here
//   a = s.split(" ").reverse();
//   ans = a.join(" ");
//   return ans.toUpperCase();
// }

const transformSentence = (s) => {
  return s.toUpperCase().split(" ").reverse().join(" ");
};
// Your code here

// Task 6
let sentence = "Hello world from JavaScript";
let transformed = transformSentence(sentence);
console.log(transformed); // Output: "JAVASCRIPT FROM WORLD HELLO"

// Task 7: Improving code quality

// function processNames(names) {
//   let result = [];
//   for (let i = 0; i < names.length; i++) {
//     let upperCaseName = names[i].toUpperCase();
//     let nameParts = upperCaseName.split(" ");
//     let joinedName = nameParts.join("_");
//     result.push(joinedName);
//   }
//   return result;
// }

// const namesArray = ["john doe", "jane smith", "alice jones"];
// console.log(processNames(namesArray));

function processNames(names) {
  return (map1 = names.map((x) => x.toUpperCase().split(" ").join("_")));
}

const namesArray = ["john doe", "jane smith", "alice jones"];
console.log(processNames(namesArray));
