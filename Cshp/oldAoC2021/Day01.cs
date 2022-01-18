using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AoC2021CSharp;

namespace AoC2021CSharp
{
    internal static class Day01
    {
        const string InputData= "Day01.txt";

        struct State
        {
            //List<long> integers = new List<long>();

            public List<long> integers { get; set; }
        }

        static State s = default;
       


        static public void Execute()
        {

            Part01();
            Part02();

        }

        static void Part01()
        {

            s.integers = new List<long>(File.ReadAllLines(Constants.AoC2021Data + InputData).ToList<string>().Select(i => long.Parse(i)));
            
            long myResult=0;
            int myIndex = 2;
            for (  myIndex = 1; myIndex< s.integers.Count;myIndex++)
            {
                if (s.integers[myIndex] > s.integers[myIndex - 1])
                {
                    myResult += 1;
                }
            }
            Console.WriteLine("The answer to Day 01 part 1 is 1711 .  Found is {0}", myResult);

        }


        static void Part02()
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

            Console.WriteLine("The answer to Day 01 part 2 is 1743 .  Found is {0}", myResult);

        }
    }
}
