const marks = [80, 90, 100, 70, 60];

//More control over Loop
for (let index = 0; index < marks.length; index++) {
  console.log("Index: ", index, " Marks: ", marks[index]);
}

//Readable and simple | in -> index
for (let i in marks) {
  console.log("Index: ", i, " Marks: ", marks[i]);
}

//Cleaner and readable
for (let mark of marks) {
  console.log("Mark: ", mark);
}

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
var cost = 0;
for (let item of allItems) {
  cost += item.price * item.quantity;
}
console.log(cost);

// Ex 2: Rating 4.7 and above | Recommendations List
const books = [
  { title: "Infinite Jest", rating: 4.5, genre: "Fiction" },
  { title: "A Brief History of Time", rating: 4.8, genre: "Science" },
  { title: "The Catcher in the Rye", rating: 3.9, genre: "Fiction" },
  { title: "Sapiens", rating: 4.9, genre: "History" },
  { title: "Clean Code", rating: 4.7, genre: "Technology" },
];
list = [];
for (let i of books) {
  if (i.rating >= 4.7) {
    list.push(i.title);
  }
}
console.log(list);

// Output
// ['A Brief History of Time', 'Clean Code', 'Sapiens' ]

// Ex 3: If employee's grades 80 or above promote them
const employes = [
  { id: 1, name: "Alice", grade: 78 },
  { id: 2, name: "Bob", grade: 85 },
  { id: 3, name: "Charlie", grade: 92 },
  { id: 4, name: "David", grade: 88 },
  { id: 5, name: "Eva", grade: 76 },
];
// This should output:
// [{ id: 2, status: 'Promoted' }, { id: 3, status: 'Promoted' }, { id: 4, status: 'Promoted' }]
list2 = [];
for (let i of employes) {
  if (i.grade >= 80) {
    s = {};
    s.id = i.id;
    s.status = "Promoted";
    list2.push(s);
  }
}
console.log(list2);

// Ex 4: Top 1 movie titles

const movies = [
  { title: "Inception", ratings: [5, 4, 5, 4, 5] },
  { title: "Interstellar", ratings: [5, 5, 4, 5, 4] },
  { title: "Dunkirk", ratings: [4, 4, 4, 3, 4] },
  { title: "The Dark Knight", ratings: [5, 5, 5, 5, 5] },
  { title: "Memento", ratings: [4, 5, 4, 5, 4] },
];

// Expected Output:  The Dark Knight
// Clue: functions
function rating(rat) {
  let sum = 0;
  for (i of rat) {
    sum += i;
  }
  return sum / rat.length;
}
l = [];
for (let i of movies) {
  i.avg = rating(i.ratings);
}
// console.log(movies);
let max = 0;
for (let i of movies) {
  if (i.avg > max) {
    max = i.avg;
  }
}
// console.log(max);
for (let i of movies) {
  if (i.avg == max) {
    console.log(i.title);
  }
}
