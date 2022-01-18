import { GetFileByLines } from "./common";
import *  as c from "./Constants";


    const InputData= "Day01.txt";

    interface State
    {
        //List<long> integers = new List<long>();

        _integers:number[]
        
        get integers() {
            return this._integers;
        }
        set length(value) {
            this._integers = value;
        }
    }

        
    


    export function Execute(): void
    {

        Part01();
        Part02();

    }

    

export function Part01() {
    var myIntegers: number[] = GetFileByLines(c.RawDataPath + "Day01RawData.txt").map(x => parseInt(x));
    var sums = GetTwoItemsThatSumToTarget(2020, myIntegers)
    var myResult = sums[0] * sums[1];
    console.log(`The answer to Day 01 Part 1 is 982464. Found is ${myResult}`);
}


    function Part01()
    {
        const fs = require('fs');
        s.integers = new List<long>(File.ReadAllLines(Constants.AoC2021Data + InputData).ToList<string>().Select(i => long.Parse(i)));
        
        myResult:number=0;
        int myIndex = 2;
        for (  myIndex = 1; myIndex< s.integers.Count;myIndex++)
        {
            if (s.integers[myIndex] > s.integers[myIndex - 1])
            {
                myResult += 1;
            }
        }
        console.log("The answer to Day 01 part 1 is 1711 .  Found is {0}", myResult);

    }


    function Part02()
    {
        s.integers = new List<long>(File.ReadAllLines(Constants.AoC2021Data + InputData).ToList<string>().Select(i => long.Parse(i)));
        List<long> mySums = new List<long>();
        
            // Compile a list of sums of 3 consecutive values
            int myIndex=0;
            for ( myIndex = 2; myIndex<s.integers.Count; myIndex++)
            {
                mySums.Add(s.integers[myIndex] + s.integers[myIndex - 1] + s.integers[myIndex - 2]);
            }
    
        // Now repeat the compare that we did for ( part 1 using mysums
        long myResult = 0;
    
        for ( myIndex = 1; myIndex < mySums.Count;myIndex++)
        {
            if (mySums[myIndex] > mySums[myIndex - 1])
            { 
                myResult += 1; 
            }
        }

        console.log("The answer to Day 01 part 2 is 1743 .  Found is {0}", myResult);

    }
}