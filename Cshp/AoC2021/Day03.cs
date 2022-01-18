using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AoC2021CSharp;

namespace AoC2021CSharp
{
    internal static class Day03
    {
        const string InputData= "Day02.txt";

        struct State
        {
            //List<long> integers = new List<long>();
            private List<List<char>> _Data;
            public List<List<char>> Data 
            { 
                get {return _Data;}
                
                set 
                {
                    _Data = value;
                    Transpose();
                } 
            }
            public List<List<char>> Transposed {get;}

            private List<List<char>> Transpose()
            {
                List<List<char>> myTransposed =new List<List<char>>();
               
                foreach( char myChar in Data[0])
                {                    
                    myTransposed.Add(new List<char>());
                        
                }
                    
                foreach (List<char> myList in Data)
                {        
                    for(int myIndex = 0;myIndex <myList.Count; myIndex++)
                    {        
                        myTransposed[myIndex].Add(myList[myIndex]);                         
                    }
                }
                    
                return myTransposed;
            }
        }

        static State s = default;
       


        public static void Execute()
        {

            Part01();
            Part02();

        }

        static void Part01()
        {
            s.Data = new List<List<char>>(File.ReadAllLines(Constants.AoC2021Data + InputData).Select(x => x.ToList<char>()).ToList());

            long myOnes=default;
            string myGamma=default;
            string myEpsilon =default;

            
            foreach (List<char> myItem in s.Transposed)
            {
                myOnes = myItem.Count(x=> x=='1');
                // This part works when the bias is to '1' if ( '1' and '0' are equal
                //so we can't use >=, just >
                if ( myOnes > myItem.Count - myOnes)
                {
                    myGamma = myGamma + '1';
                }
                else
                {
                    myGamma = myGamma + '0';
                    myEpsilon = myEpsilon + '1';
                    
                } 
                
            }
            
            
            long myResult = Convert.ToInt32(myGamma,2) * Convert.ToInt32(myEpsilon,2);

            Console.WriteLine( "The answer to Day 03 part 1 is 845186.  Found is {0}", myResult);
        }

        static void Part02()
        {
       
            s.Data = new List<List<char>>(File.ReadAllLines(Constants.AoC2021Data + InputData).Select(x => x.ToList<char>()).ToList());

            long myOnes =default;
            List<char> myLastOxygen   ;        //seq[char]
            List<char> myLastCO2;                //seq[char]
            List<char> myReadings;              //seq [seq[char] ]
           string myBit;                //Char

            myReadings = new List<List<char>>(s.Data);
            

            
            for ( int myIndex = 1; myIndex <s.Transposed.Count; myIndex++ )
                
                myLastOxygen = myReadings.Last
                myOnes = s.Transposed.Item(myIndex).CountIt(cmpEQ.Deb("1"))
                
                if ( myOnes >= myReadings.Count - myOnes )
                    {myBit = '1';}
                else
                    {myBit = '0'};
                    
                

                myReadings = myReadings.FilterIt(x=>myBit, myIndex))
            
                if ( myReadings.Count = 1 Then
                    
                    myLastOxygen = myReadings.First
                    Exit for (
                    
                } (
                
                s.Transposed = myReadings.Transpose
                
            }


            myReadings = s.Data.Clone
            s.Transposed = s.Data.Transpose

            
            for ( myIndex = 1 To s.Transposed.LastIndex
                myLastCO2 = myReadings.Last
                myOnes = s.Transposed.Item(myIndex).Countit(cmpEQ.Deb("1"))
                if ( myOnes >= myReadings.Count - myOnes Then
                    
                    myBit = "0"
                    
                else:
                
                    myBit = "1"
                    
                    
                } (
                
                myReadings = myReadings.FilterIt(cmpEQ.Deb(myBit, myIndex))
            
                if ( myReadings.Count = 1 Then
                    myLastCO2 = myReadings.First
                    Exit for (
                    
                } (
                
                s.Transposed = myReadings.Transpose
                
            }

            myResult As Long
            myResult =Convert.ToInt32(myLastOxygen.ToString(vbNullString)) * Convert.ToInt32(myLastCO2.ToString(vbNullString));
            Console.WriteLine( "The answer to Day 03 Part 2 is 4636702. Found {0}", myResult)
        }
    }
}