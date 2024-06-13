# Intro to web development

### JAVA SCRIPT

- ifen=dot

  1.

  - cccc

  2.

## this is a code

```css
center code {
  ......;
}
```

### short cuts

ctrl+ space # auto complete  
ctrl+/ #comment  
win+. #emojis  
ctrl+, #settings  
ctrl+shift+p #command pallete  
alt+up #up and down  
ctrl+click #go at that place

## new file

! +enter

## Linking script file to html file rather than writing the js code

```js
<script src="scope.js"></script>
<script src="hjjb.js"></script>
```

> highlight

https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

![all http status code](https://udzial.com/wp-content/uploads/2021/04/HTTP-Status-Code-Nmemonics.png) -[image compression](https://squoosh.app/)

#### SVG

Scalable Vector Graphics (SVG) is a web-friendly vector file format. vector-based graphics in XML format.
SVG graphics are scalable, and do not lose any quality if they are zoomed or resized. SVG is supported by all major browsers.

#### continous integration and continous deployement CICD

## INTRO TO JAVA SCRIPT

variabe

```java script
var x=10
typeof(x)
```

#### data types

number(4,4.5),  
strings("x","divya"),  
boolean,  
object  
undefined

```javascript
var student={
  name:"divya",
  marks:40
}
console.log(student.name);         #divya
console.log(student["marks"]);     #40
typeof(student)                #object


var marks=[10,20,30,40]
typeof(marks)                  #object
marks[0]                       #10
40/0                           #infinity not error

var t=null
console.log(typeof t);         #object not null
typeof(infinity)               #number

var z;
typeof(z)                      #undefined
```

### Declartions

#### redeclaration,reassignment

Var : redeclaration is allowed,allowed  
let : not allowed,allowed  
const : not allowed,not allowed  
redeclaration creating a same variable again,creating a variable with same address.  
reassignment modifying the value of the variable.

if the array is declared as const, then also we can change the value inside the variable

```js
const t1={1,2,3,4}
const t2=t1
#t2 will be assigned to the initial address of t1
#if we do t1.push(6) and t2.push(9), both t1 and t2 are equal. t1=t2={1,2,3,4,6,9}
```

### undefined and not defined

undefined is not a error it is output , when we declare a variable but not assigned any value to it.  
Not defined is an error, occured when we didnt declare a variable and trying to access it

### SCOPE

let , Const --> block scope  
var --> function scope

```js
function driving(age) {
  if (age > 18) {
    var msg = "eligible";
  } else {
    var msg = "not eligible";
  }

  console.log("he is" + msg);
}
driving(20);
```

### type casting

#### implicit

done by the compiler automatically when any operations performed.when JS automatically decides itself.

#### explicit

we manually do the type casting by parseint, toString.

```
var x1 = 2;
var x2 = "g";
console.log(x1 + x2);          #2g it concatinated
console.log(x1 - x2);          #Nan not a number or undefined
```

```
var x1 = 2;
      var x2 = "3";
      console.log(x1 + x2);
      console.log(x1 - x2);
```

adding a array and string

```js
[2,4,5].toString()           #'2,4,5'
[2,4,       5].toString()    #'2,4,5'
[2,4,5]+"abc"                #'2,4,5abc'
[]+[]                        #' '
null+5                       #5
4 * "5a"                     #NaN
NaN/4                        #NaN
typeof(NaN)                  #number
```

### == or === which is faster and y?

=== is faster only one step
== is slower coation (type conversion) and then compares the value which takes much time.

## Functions

if we dont give the return statement ,undefined will be printed  
return: returns value to function call  
arguments: values that are passed in the parameters  
parameters: are the varibles that are defined inside the function.  
function are just to avoid repetition of code.  
DRY- Dont repeat yourself  
modification also becomes easy  
reusability,readability,changes in one place it get reflected in all places.

2 ways to exit a function

1. return statement
2. untill end of the function block

### Arrow Function

```js
const double = (n) => {
  return n * 2;
};
```

if the function is one line, we can write in one line

```js
const double1 = (n) => n * 2;
```

### 5 pillars of code Quality

1. readability-75%
2. Maintainability - Code Debt(i will make the code better tommorrow that day never come)
3. Extensibility
4. Testability
5. Performance

```js
var q1 = [100, 200];
var q2 = [...q1];
var q3 = [60, ...q1, 90, 40];
console.log(q3);
var t1 = [400, 500];
let t2 = [90, 80];
var t3 = [...t2, ...t1];     #spread operator    #copy by value
console.log(t3);
```

## LOOPS

### FOR LOOP

3 types of for loops

```js
const marks = [80, 30, 40, 23, 45];
for (let i = 0; i < marks.length; i = i + 2) {
  console.log("index", i, "marks", marks[i]);
}
//readable and simple
for (let idx in marks) {
  console.log("Index: ", idx, "marks:", marks[idx]);
}
//readable and cleaner can use when we dont want index
for (let mark of marks) {
  console.log("Mark:", mark);
}
```

### exercise 1

```js
const cart = [
  { name: "A", price: 0.5, qty: 4 },
  { name: "B", price: 0.25, qty: 2 },
];
const new1 = [
  { name: "c", price: 0.35, qty: 2 },
  { name: "D", price: 1.0, qty: 5 },
];
const new2 = [...cart, ...new1];
sum = 0;
for (let item of new2) {
  // for (let i = 0; i < new2.length; i = i + 1) {
  sum = sum + new2[i].price * new2[i].qty;
  //
}
console.log(sum);

//output total price of all products
```

###

### exercise3

```js
const employes = [
  { id: 1, name: "Alice", grade: 78 },
  { id: 2, name: "Bob", grade: 85 },
  { id: 3, name: "Charlie", grade: 92 },
  { id: 4, name: "David", grade: 88 },
  { id: 5, name: "Eva", grade: 76 },
];
var x = [];
for (let i = 0; i < employes.length; i++) {
  if (employes[i].grade > 80) {
    x.push({ id: employes[i].id, status: "promoted" });
  }
}
console.log(x);
// output: [{ id: 2, status: 'Promoted' }, { id: 3, status: 'Promoted' }, { id: 4, status: 'Promoted' }]
```

```js
const movies = [
  { title: "Inception", ratings: [5, 4, 5, 4, 5] },
  { title: "Interstellar", ratings: [5, 5, 4, 5, 4] },
  { title: "Dunkirk", ratings: [4, 4, 4, 3, 4] },
  { title: "The Dark Knight", ratings: [5, 5, 5, 5, 5] },
  { title: "Memento", ratings: [4, 5, 4, 5, 4] },
];
x = [];

function summ(array) {
  var sum = 0;
  for (let i = 0; i < array.length; i++) {
    sum = sum + array[i];
  }
  return sum;
}
for (let i = 0; i < movies.length; i++) {
  x.push(movies[i].ratings);
}
for (let i = 0; i < x.length; i++) {
  x[i] = summ(x[i]);
}
var max = 0;
var index = 0;
for (let i = 0; i < x.length; i++) {
  if (max < x[i]) {
    max = x[i];
    index = i;
  }
}
console.log(movies[index].title);
```

## ES6 features

numeric seperators,let and const,rest,spread,template literal,destructuring,class,arrow function,promise,nullish coalescing,optional

### OBJECTS

```js
Object.keys(Object_name);
Object.values(Object_name);
```

### TEMPLATE LITERAL

it solves the readability issue, by using back ticks and dollar symbol infront of the parameter(interpolation),it also supports the multi line codes also by using the back quote.

```js
function function_name(firstname, lastname) {
  return "welcome " + lastname + ", " + firstname + " !!!";
}
function function_name(firstname, lastname) {
  return `welcome ${lastname}, ${firstname} !!!`;
}

const quote = `hjknbhhjkskmx
dxnmnkm,
sxkkm,mmm`;
console.log(quote);
```

##### refactoring

quality better & functionality same

### Destructuring

#### Array destructuring

unpacking the values from array  
RULE: default value is taken only when the parameter is undefined

```js
const [t1,t2]=[10,20]                  #t1=10,t2=20
const [t1,t2,t3]=[10,20]            #t1=10,t2=20,t3=undefined
const [t1,t2,t3=30]=[10,20]           #t1=10,t2=20,t3=30
const [t1,t2,t3=30]=[10,20,40]        #t1=10,t2=20,t3=40(RULE)
const [t1,t2,t3=30]=[10,20,null]       #t1=10,t2=20,t3=null
const [t1,t2,t3=30]=[10,20,undefined]       #t1=10,t2=20,t3=80
const [,t1,t2,t3=30]=[10,20,null]       #t1=20,t2=null,t3=30
```

#### Object Destructuring

```js
const {a,c,e}={
  a:1,
  b:2,
  c:3,
  d:4,
  e:5
}                              #a=1,c=3,e=5

const {a,c,e,f=6}={
  a:1,
  b:2,
  c:3,
  d:4,
  e:5
}                         #a=1,c=3,e=5,f=6
```

#### Ternary operators

3 expressions/operands and 2 operators

```js
5>4:"awesome":"wow";
```

#### binary operator

1. arithemetic +,-,/,
2. logical &&,||
3. relational <,>,==,===

#### Unary operation

++,--,!

## truthy vs falsy

### falsy

null,false,0,undefined,-0,0n,"",falsy object,NaN

```js
var height=150
var final = 140 || height           #if first expression i.e 140 is true then it will not check for second expression i.e 140
final                               #140
var final = 0 || height             #150
```

### NULLISH COILLATION

only null and undefined values are false for this coillation
represented as ??|

```js
0 ?? 150                #0
null ?? 150             #150
undefined ?? 150        #150
```

### rest

collects rest values of the array

```js
var [t1,t2,t3]=[1,2,3,4,5,6]          #t1=1,t2=2,t3=3
var [t1,t2,...t3]=[1,2,3,4,5,6]          #t1=1,t2=2,t3=[3,4,5,6]
```

### build in function

```js
"divya".toUpperCase()
"DIVYA".toLowerCase()
"THis is a beautiful day".split(" ")               #['this','is','a','beautiful','day']
['this','is','a','beautiful','day'].join("|")      #'This|is|a|beautiful|day'
"jjbnj jjxnk xjskjmk".split("")                    #this will divide into letters
```

reverse()
slice()

```js
function transformSentence(sentence) {
  return sentence.split(" ").reverse().join(" ").toUpperCase();
}
let sentence = "Hello world from JavaScript";
let transformed = transformSentence(sentence);
console.log(transformed);
```

#

## CODING STANDARDS

coding standards are meant to have uniformity through out ur code base

1. code quality
2. DRY dont repeat urself
3. variable name : it should be understand by others

```js
var a = 20; //wrong
var age = 20; // right
```

it should be camel case

```js
 class CarEngine{
let student_name="Divya";       //wrong
let studentName="Div";
}
```

we should not use keywords in variables.  
cant start with number.  
cant use special symbols($,@,#,!).  
choose "let" over "var".  
choose "const" over "let".(it improves readability for other developers can easily understand).

#

## DOCUMENTATION

```js
// single line comments
/**
 *
 *
 * dfscsa
 *
 */
example;
// function to make it uppercase
/**
 * converts a string to upper case
 * @param {string} input_string -the string input
 * @returns {string}  The upper case string of x
 * @example
 * uppercase(divya);   //returns DIVYA
 */
function upperCase(input_string) {
  return input_string.toUpperCase();
}
```

#

# SOFTWARE LIFE CYCLE

SDLC is a process of 6 steps for development

#### 1. Planning

software req

#### 2. analysis

whether it will done or not

#### 3. design

prototype, bring together all the things , blueprint of ideas(visual ideas)  
variant, auto layout

#### 4. Implementation

developer

#### 5. Testing & Integration

#### 6. Maintianance

support team or new features adding to applications  
any bugs arise raises a ticket.

### stakeholders

if anything goes wrong ,they have the responsibility,
who holds the share ,who are the responsibility for the work to be done.

### analysis

1. product owner, 2) project manager,3) business analyst 4) CTO(cheif technical officer).

### Design

1. system architect 2) UX/UI designer

### Development

1. front end 2) back end

### Testing

1. solutions architect 2) qa engineer 3)tester 4) devops

### deployment

1. Data administrators 2) Devops

### maintenance

1. users 2) testers 3) support managers
   ![alt text](<Screenshot 2024-06-03 113858.png>)

#

### product vs service

if we customize a specific requirements for a customer where we provide a service for them is a service.  
if we develop a product for multiple users , which we produce a product, where the product quality should be high that product should stay in market more than 10 yrs.if it a service based it can be changes for every less time.

#

### waterfall vs agile

![alt text](<Screenshot 2024-06-03 144906.png>)

waterfall model when we have the specific requirements we cant make changes (building constructions,toyato,migrating projects(where we can change from one language to other))
water fall for every 6 months there will be a release
in agile(cyclic process) for every 2 sprits i.e 1 month.

### Implementation of Agile

1. Scrum is the framework used to work in agile
2. Sprint planning
3. Story points are units of measures for expressing an estimate of the overall effort required(how munch time that u are giving for a specific task i.e if it is 3 days =3 story points). mostly the story points are fibonacci numbers.
4. Blockers are anything that stops or slow down the delivery
5. Standups : daily meetings 15 mins
6. sprint meetings
7. Reviewer : checks the code quality by using coding standards.after review it will go to done.

### KANBAN BOARD

![alt text](<Screenshot 2024-06-03 160737.png>)

#

Burn down chart how much work we do in that sprint is calculated and made into a chart.

Spill Over : adding the pending tasks of present sprint to the next sprint.

#

## GIT FUNDAMENTALS

#### Kernel

interface between hardware and shell.

### GIT

- version control system.
- commit : save points the code should should work at that particular level, although we mess up with our code.
  -it will maintain versions. instead of maintaining different folders, It can use as backup.

### GIT Process

- create folder and cmd in search and enter "code ." enter it goes to vs code.
- create a file and to commit the changes ,open the terminal (ctrl+` ),
- it opens the terminal enter "git init" or "$ git init"

```
git init
git add hello.js
git add .
git commit -m "start of git"
git status
git log(it will stuck, press q for quit)
git log -6
git log -1
git switch -
git checkout -
git log --author=divya
git log --author=divya-1
git log --help
git log -p                      //patch it shows all the saved changes

```

### GIT VS GITHUB

github is just storing the code in the cloud  
they are not even related  
git is a software that tracks our progress where github is a place where we can store files
we can still use the git offline but we cant push the code into it.
git : we dont need internet to commit changes.

#

### back process of git

1.  working: coding place
2.  stagging: reviewing the chamges before it commited.,we can commit better changes ,acts as a intermediate
3.  commit: logical change(in terms of steps),small,multiple times a day,when code works.

#

#### COMMIT MESSAGE

good commit message should have the reason y commit changes have done.

##### SOFT

when we revert the file then the changes go to the stagging area ,totally not gone, but the commit will be deleted

- git revert "commit_id" //deleting the changes (VIM press":wq" write quit)
- git reset --soft head-1 //we can make changes, it will store in stagging stage
- git reset --hard head-1 //create new command ,dont want to edit

##### VIM

- h-> left
- j-> down
- k-> top
- l-> right
- w->forward
- b->backward
- dw-> delete a word
- u->undo
- diw->delete inside word
- dip->delete inside paragraph

#

### Commands

- to create a new branch

```
git checkout -b "branch_name"
```

- go to master branch

```
git checkout -
```

- go to specific branch

```
git checkout "branch_name"
```

#### why should we need a branch

if we directly commit ,the unfinished code will be displayed to customer to avoid it create a featured branch and after done merge into master branch

- master ->customer (2 sprints)
- staging->QA (2 weeks)
- dev-> developer (2 weeks after commit)

fast forward merge-> if we dont have commits ,there is no extra commits

#

### GIT MY NOTES

#

- version control system - it will track the changes, done in the code
- centralized system- if one person in the grp deleted the code also, all other will still restore the files.
- distributed system - all the persons in the grp will have copy, when changes have done by one,only the difference or changes are added to them.
- stagged files are files that are added and ready to commit
- unstagged files are modified files which are displayed here , need to stage these files to commit.
- untracked files are newly created files ,which are displayed in red color.need to stage them to commit.
- whenever we commit , commit_id is generated which is of 40 alphanumeric character
- clone= taking project from repository to ur system is cloning, when we are first time taking the file from central we use clone,every day developers take changes ,to take that changes we use pull.
- checkout: Switch between branches in a repository.
- git revert should be used to undo changes on a public branch, and git reset should be reserved for undoing changes on a private branch. You can also think of git revert as a tool for undoing committed changes, while git reset HEAD is for undoing uncommitted changes.

#

- git help  
  => it provides freqently used commands
- git help command_name  
  => opens documentation of particular command
- git init  
  => creates a empty repository or re-initilizes the repository
- git status  
  => specifies which branch ,which state it is
- git add file_name  
  => to stage the file
- git rm --cached file_name  
  => to unstage the unsaved file ,if it is saved then reset
- git rm --cached\*  
   => all the files are unstaged  
   Git rm
  Remove the files from the working tree and from the index:
  $ git rm <file Name>
  Remove files from the Git But keep the files in your local repository:
  $ git rm --cached
- git reset head file_name
- git commit  
  => used to commit changes to git local repository
- git commit -m "....."  
  => message
- git remote add origin origin_url  
  => we have to add origin for first time
- git push -u origin master  
  => moves changes from local to central
- git push  
  => all changes
- git log  
  => displays the history,id, who commited ,when commited,message.
- git clone repo_url  
  => to clone the file
- git pull  
  => to get latest file update or file changes from central

- Track the changes that have not been staged: $ git diff
- Track the changes that have staged but not committed:
  $ git diff --staged
- Track the changes after committing a file:
  $ git diff HEAD
- Track the changes between two commits:
  $ git diff Git Diff Branches:
  $ git diff < branch 2>
- $ git blame <file name>  
  => Display the modification on each line of a file
- Reset the changes:
  $ git reset -hard
  $ git reset -soft:
  $ git reset --mixed
- Undo the changes:
  $ git revert
  Revert a particular commit.

#

#### Purpose of branch

if we directly commit changes in main branch it get reflected to the customer, whether it works or not, so to avoid it , we create a branch and made changes that will not affect the customer, after complition we can merge into the main.

#

#### fast forward and merge commit

if there are no commits in the main branch its fast forward, else merge commit.

#

#### stash

keeping temporaly in a place and after we can restore it, it doesnt store in online, if the device gone, we cant restore it as it is stored in offline, we can store multiple stashes but we have to give stash name to ,so that we can restore it by name, git stash apply stash_name.

#

#### REBASE

- rebase can combine the multiple commits into a single commit.
- it can also drop the commit.
- we cant squash merged commits
- git rebase -i HEAD~2
- 2 is the no. of comits, it may be 2,3,4,...
- change the commit history.
- rename the commit.

#

### MERGE COMMIT VS REBASE

- Git merge keeps the commit sequence intact by combining the histories of the two branches into a single branch. Git rebase, on the other hand, rewrites history by putting changes from one branch at the beginning of another, resulting in a more organized, linear project history.it adds total branch to the other branch,if in rebase we can search the commit from log using binary search method. git command (git bisect)
- point of rebase is to make the history in straight line.
- git pull -- rebase dev
- git pull --rebase origin dev

#

#### Merge Conflict

arise when two people have changed the same lines in a file, or if one developer deleted a file while another developer was modifying it.when both tries to merge the commits ,conflict arises.

#

- delete a branch  
  git branch - D branch_name

#

### Key terms

- configuration mgmt
- system-code
- CI(configuration item) => git => files
- release mgmt
- configuration mgmt and release mgmt is related +

#

#### git blame command

git blame file_name

#

### Configuration management

- CI (deals with the git and the codes.)
- Audit (git blame,git diff)
- baseline (are save points. there are 2 one is commit and other is tags i.e version)
- Accounting i.e. tool to track the person, the task is assigned (git log, git blame)
- change mgmt i.e (process of adding the new changes, quality, features )  
  change mgmt is maintained by creating branches, pull req.

#

## benifits

1. traceability - who did? why did?
2. code quality and consistency
3. Back up - reduces the risks and errors
4. change management - maintains is easy, impressive and easy work,smooth.

#

### Release Manangement

- planning (proper plan when release should happen,2 weeks to QA, 1 month to customer i.e. BRANCHING STRATEGY)
- Goverance(who is in authority, development-developer,testing- QA enginnerr,devops,i.e access to whom )
- scheduling (maintaining sprints,agile)
- Automation (CI/CD makes release mgmt very easy)
- contigency (backup) if any issue arises from customer,if bugfix takes time,cant wait upto that long, then roll back is done,

#

## CI/CD

release mgmt tools are mostly PAAS (where it is a platform which is pre installed all the setup just waiting for the code)

- netliply,junkin,circle CI
- in build step, the whole code is reduced into single line that makes the storage less and makes fast.

### saas

all apps that provides the services

google,proclink,insta,snap

### paas

they give the environment ,we have to build the app,gives platform to build ur customized thing.
netlipy, render,raleway,uroko

### iaas

PC(100-1000),Azure,AWS

#

#### code => commit => pull request => reviewer => approve => merge into master

#

## NETLIFY PROCESS

1. merge to master, if the new code is available in master, netlify will take new code
2. Build : (uglify)removes comments, spaces,shorten variables intlo single line code
3. Automation test : Selenium(java),cyuprus(js) if test fails it stop and report it to team,if pass next step.
4. goes to customer

### TEXT STYLING

1. font-size
2. font-weight
3. font-style
4. color

gamet- grp of colors(SRGB)if 100%
