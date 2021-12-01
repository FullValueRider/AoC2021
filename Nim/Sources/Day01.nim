import strutils
import strformat
import sequtils
import Constants

const InputData = "Day01.txt"

# The state object is a hangover from VBA where it is seen as good practise
# to encapsulate Module level variables in a User Defined Type.
#
# In VBA I typically use 3 UDF, 
# - State(s) for internal state of classes, 
# - Properties(p) for class properties (acceesed using let/get)
# - Readonly (r) 'values' I want to make available from within a class as a conmstant

type
  State = object
    Integers: seq[int]

let s =State( Integers:toSeq((RawDataPath & InputData).lines).map(parseInt) )
    
proc Part01() =
    
    var myResult:int=0
    for myIndex in 1..<s.Integers.len():  
        if s.Integers[myindex] > s.Integers[myindex-1]:
            myresult+=1

    echo fmt"The answer to Day 01 part 1 is 1711 .  Found is {myResult}"


proc Part02() =
   
    var myResult:int=0
    var mySum:seq[int]

    for myindex in 2..<s.Integers.len():
        mysum.add  s.Integers[myIndex] + s.Integers[myIndex-1]+s.Integers[myIndex-2]

    for myindex in 1..<mySum.len():
        if mysum[myIndex]>mysum[myindex-1]:
            myResult+=1

    echo fmt"The answer to Day 01 part 2 is 1743.  Found is {myResult}"        


proc Execute*()=
    Part01()
    Part02()