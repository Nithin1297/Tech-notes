{
    var x = 10;
    let y = 20;
  }
  console.log(x); // 10
  //   console.log(y); //out of scope
  var z;
  console.log(z); // undefined

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