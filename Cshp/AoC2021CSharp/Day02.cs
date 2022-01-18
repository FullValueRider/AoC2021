using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC2021CSharp
{
    internal class Day02
    {
        const string InputData = "Day02.txt";

        struct State
        {
           
            public List<string[]> Data { get; set; }
        }

        static State s = default;



        public static  void Execute()
        {
            Part02();
            Part01();
            

        }
        
        public static void Part2()
        {
            s.Data = new List<string[]>((IEnumerable<string[]>)File.ReadAllLines(Constants.AoC2021Data + InputData).Select(x => x.ToLower().Split(",").ToList()));

            long myX = default;
            long myY = default;
            long myAim = default;
            foreach (string[] myItem in s.Data)
            {
                long myMove = long.Parse(myItem[1]);

                switch (myItem[0])
                {
                    case "forward":
                        myX = ++myMove;
                        myY += (myAim * myMove);
                        break;

                    case "up":
                        myAim -= myMove;
                        break;

                    case "down":
                        myAim += myMove;
                        break;

                }
            }
            long myResult = myX * myY;
            Console.WriteLine("The answer to Day 02 part 2 is 1880593125. Found Is {0}", myResult);
        }


        public static void Part01()
        {
            s.Data = new List<string[]>((IEnumerable<string[]>)File.ReadAllLines(Constants.AoC2021Data + InputData).Select(x => x.ToLower().Split(",").ToList()));
            
            long myX = default;
            long myY = default;

            foreach (string[] myItem in s.Data)
            {
                long myMove = long.Parse(myItem[1]);
                switch (myItem[0])
                {
                    case "forward": 
                        myX += myMove; 
                        break;
                    
                    case "up":                     
                        myY -= myMove; 
                        break;
                    
                    case "down":                    
                        myY += myMove; 
                        break;   
                }
            }

            long myResult = myX * myY;

            Console.WriteLine("The answer to Day 02 part 1 is 1507611.  Found is {0}", myResult);
        }

       
    }
}
