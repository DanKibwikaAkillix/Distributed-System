
import ballerina/io;
import ballerina/random;


type number int;
    type myNumber record{
      
       number count;
       number randomNumber;     

};



class Factorial{

    function factorial() returns error? {

       number randomNumber =check random:createIntInRange(0,59);

       if (randomNumber==0 ||randomNumber==1) {

        io:println("=========================================================/b");
        io:println("Factorail of ", randomNumber, " Is 1/b");
        io:println("=========================================================/b");
       }

       else{

        number factorialNumber = 1;
        foreach number i in 1...(randomNumber){

            factorialNumber *= i;

        io:println("=========================================================/b");
        io:println("Factorail of ", randomNumber, " Is '", factorialNumber,"'");
        io:println("=========================================================/b");
             break;
       }
        

        }
     
    }  
}
