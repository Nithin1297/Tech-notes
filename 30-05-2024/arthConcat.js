let a = 7;
      let b = "5";
      console.log(a + b); // 75
      console.log(a + parseInt(b)); //12
      console.log(a + b + 2); // 752
      console.log(a + a + b); //145
      console.log(a - b); // 2

      console.log([1, 2, 3] + "abc"); //1,2,3abc
      console.log(typeof ([] + [])); //empty string

      console.log(null + 5); //5
      console.log(2 / "a"); //NaN
      console.log(typeof NaN); //Number

      // Checks for the value, Allows type casting, allows coesion
      // Checks for the value and data type
      g1 = 5;
      g2 = "5";
      console.log(g1 == g2); // true , string is converted into number,allows conversion
      console.log(g1 === g2); // false, doesnot allow conversion
      // Among both === is faster since only onestep