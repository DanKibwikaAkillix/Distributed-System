
import ballerina/http;

// ============================================================================================
// define the attributes/type according to your preferences like you'd do in java 
// public void(){
//     ATTRIBUTES HERE 
// }
// ============================================================================================


public type CourseEntry record{|

        readonly string course_code;
        string courseName;
        string courseCoordinayor;
        string venue;

|};

//Build a table to store data 

public final table<CourseEntry> key(course_code) CourseTable = table[

    {course_code:"DSA611S", courseName:"DISTRIBUTED SYSTEM", courseCoordinayor:"Ms Nashandi", venue :"Auditorium 1" },
    {course_code:"PGR611S", courseName:"PROGRAMMING 2 ",     courseCoordinayor:"Mr Herman",   venue :"Ms teams" }
];

// error handler for conflicted data while inserting (POST) or updating (PUT)

public type CourserErrorConflicting record{|

     *http:Conflict;
     ErrorMsg body;

|};



public type InvalidCodeError record{|

    *http:NotFound;
    ErrorMsg body;

|};

//  ERROR MESSAGE 
public type ErrorMsg record{|

    string errmsg;

|};




// create Listener
// which is the Ballerina abstraction that deals with network-level details such as the host, port, SSL, etc
// source : https://ballerina.io/learn/write-a-restful-api-with-ballerina/#the-second-endpoint

service /course/individualCourse on new http:Listener(9000){


   resource function get courses() returns CourseEntry[]{

        return CourseTable.toArray();
     }


     resource function post courses(@http:Payload CourseEntry[] courseEntries) returns CourseEntry[]|CourserErrorConflicting{

        // loop through the list of DATA 
        string[] conflictingCODEs = from CourseEntry courseEntry in courseEntries
            where CourseTable.hasKey(courseEntry.course_code)
            select courseEntry.course_code;



            if conflictingCODEs.length() > 0 {

                return {

                    body:{
                        errmsg: string:'join(" ", "Conflicting COURSE CODE: ", ...conflictingCODEs)
                    }
                };

            }
            else{
                courseEntries.forEach(courseEntry => CourseTable.add(courseEntry));
                return courseEntries;
            }
        
     }


     resource function get courses/[string course_code]() returns CourseEntry|InvalidCodeError {
        CourseEntry? courseEntry = CourseTable[course_code];

        if courseEntry is () {
            return {
                body:{
                    errmsg: string `Invalid Course Code :${course_code}`
                }
            };
        }
        return courseEntry;
     }

}

