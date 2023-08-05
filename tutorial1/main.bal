import ballerina/io;

class Engineer {
    string name;

    function init(string name) {
        self.name = name;
    }

    function getName() returns string {
        return self.name;
    }
}





public function main() {
    // Apply the `new` operator with a `class` to get an `object` value.
    Engineer engineer = new Engineer("Dan Kibwika Class");
    Factorial factorialIn = new Factorial();

    io:println( factorialIn.factorial());
    io:println(engineer.getName() );

}
