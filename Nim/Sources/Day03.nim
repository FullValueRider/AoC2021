import strformat
import sequtils

import Constants
import Support

const InputData = "Day03.txt"

type
  State =tuple[ Data: seq[seq[char]], Transposed :seq[seq[char]]]

let s = new State
s.Data = toSeq((RawDataPath & InputData).lines).mapit(it.toseq())
s.Transposed = s.Data.Transpose()

proc Part01() =
    var
        myOnes:int
        myGamma,myEpsilon:string

    for myitem in s.Transposed:
        myOnes=myitem.filterIt(it=='1').len()
        # This part works when the bias is to '1' if '1' and '0' are equal
        # so we can't use >=, just >
        if myOnes>myitem.len()-myOnes:
            myGamma &= "1"
            myEpsilon &= "0"
        else:
            myGamma &= "0"
            myEpsilon &= "1"
    
    let myResult:int=BinStrtoInt(myGamma) * BinStrToInt(myEpsilon)
    echo fmt"The answer to Day 03 part 1 is 845186 .  Found is {myResult}"

#In part 2, the bit criteria is calculated and then the readings seq is filered and the transposed array
# regenerated with the filtered dataset
proc Part02() =
    var 
        myOnes:int
        myLastOxygen, myLastCO2:seq[char]
        myReadings:seq[seq[char]]
        myBit:char

    myreadings =s.Data[0..^1]
    s.Transposed = s.Data.Transpose()

    for myIndex in 0..s.Transposed.high:
        mylastoxygen = myReadings[^1]
        myones = s.Transposed[myIndex].countIt(it == '1')
        
        if myones >= myReadings.len() - myones:
            mybit='1'
        else:
            myBit='0'

        myReadings=myReadings.filterit(it[myindex] == myBit)[0..^1]
        #echo fmt"{myOnes},{mybit}, {myreadings.len()}"
        if myReadings.len()==1:
            mylastoxygen = myReadings[0]
            break
        s.Transposed=myReadings.Transpose


    myReadings=s.Data[0..^1]
    s.Transposed = s.Data.Transpose()

    for myIndex in 0..s.Transposed.high:
        mylastco2 = myReadings[^1]
        myones = s.Transposed[myIndex].countIt(it == '1')
        if  myOnes >= myreadings.len() - myones:
            mybit='0'
        else:
            myBit='1'
        
        myReadings= myReadings.filterit(it[myindex]==myBit)[0..^1]
       
        if myReadings.len()==1:
            mylastco2 = myReadings[0]
            break
        s.Transposed=myReadings.Transpose

    var myResult:int=BinStrToInt(myLastOxygen) * BinStrToInt(myLastCO2)
    echo fmt"The answer to Day 03 Part 2 is 4636702. Found {myResult}"

proc Execute*()=
    
    Part01()
    Part02()