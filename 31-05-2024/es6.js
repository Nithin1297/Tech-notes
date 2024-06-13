const movieUrl = (domain, genre, year) => {
  return "http://" + domain + "?genere=" + genre + "&year=" + year;
};

console.log(movieUrl("imdb.com", "thriller", 2020));

// Refactor -> Quality better & functionality same

const movieUrl1 = (domain, genre, year) => {
  return `http://${domain}?genere=${genre}&year=${year}`;
};

console.log(movieUrl1("imdb.com", "thriller", 2020));

//Array destructuring
// const [t1, t2, t3 = 80] = [100, 200, 500];
// console.log(t1, t2, t3); // 100 200 500

// const [s1, s2, s3 = 80] = [100, 200, null];
// console.log(s1, s2, s3); // 100 200 null

// const [q1, q2, q3 = 80] = [100, 200, undefined];
// console.log(q1, q2, q3); /// 100 200 80

// const [ ,r1, r2, r3 = 80] = [100, 200, null]; //HOLES
// console.log(r1, r2, r3); // 200 null 80

//Object destructuring

// const avenger = {
//     name: "Tony stark",
//     house: "🏘️",
//     networth: "💰",
//     power: "🤖",
//     phrase: "💗 you 300"
// };
// console.log(avenger.name);
// console.log(avenger.house);
// console.log(avenger.power);

// const { name, networth, power } = {
//   name: "Tony stark",
//   house: "🏘️",
//   networth: "💰",
//   power: "🤖",
//   phrase: "💗 you 300",
// };
// console.log(name, power);

// const {
//   name,
//   networth,
//   power,
//   skill = ["genius", "millinior"],
// } = {
//   name: "Tony stark",
//   house: "🏘️",
//   networth: "💰",
//   power: "🤖",
//   phrase: "💗 you 300",
// };
// console.log(name, power, skill);

// Refactoring this code by destructuring
const cart = [
  { name: "Apple", price: 0.5, quantity: 4 },
  { name: "Banana", price: 0.25, quantity: 6 },
];

const newItems = [
  { name: "Cherry", price: 0.75, quantity: 5 },
  { name: "Date", price: 1, quantity: 3 },
];

//   Ex 1.1: Combine cart + newItems
allItems = [...cart, ...newItems];

// Ex 1.2: Find total of cart
var total = 0;
for (let { price, quantity } of allItems) {
  total += price * quantity;
}
console.log(total);
