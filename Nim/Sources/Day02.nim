import strutils
import strformat
import sequtils
import AoCLib

const InputData = "Day02.txt"

type
  State = object
    Data: seq[seq[string]]

let s =new State
s.Data = toSeq((RawDataPath2021 & InputData).lines).mapIt(it.multiReplace(("  "," "))).mapIt(it.split(' '))

proc Part01() =

    var
        myX :int=0
        myY :int=0

    for mySeq in s.Data: 
        var myInt:int=myseq[1].parseInt
        case myseq[0]
            of "forward":
                myX += myInt
            of "up":
                myY -= myInt
            of "down" :
                myY += myInt
            else:
                discard
    var myresult:int=myY*myX
    echo fmt"The answer to Day 02 part 1 is 1507611 .  Found is {myResult}"


proc Part02() =
    
    var
        myX :int=0
        myY :int=0
        myAim:int=0

    for mySeq in s.Data: 
        var myInt:int=myseq[1].parseInt
        case myseq[0]
            of "forward":
                myX += myInt
                myY += (myAim*myInt)
            of "up":
                myAim -= myInt
            of "down" :
                myAim += myInt
            else:
                discard
    var myresult:int =myX*myY
    echo fmt"The answer to Day 02 part 2 is 1880593125.  Found is {myResult}"

proc Execute*()=
    
    Part01()
    Part02()