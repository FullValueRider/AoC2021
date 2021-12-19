import strformat
import sequtils
import strutils
import AoCLib
import math
import system\iterators

const InputData = "Day07.txt"

type
  State = object
    Data: seq[int]

var s : State
s.Data = readfile(RawDataPath2021 & InputData).split(",").mapIt( it.parseint )

#n(n + 1)/2

proc Part01() =
  var myAverage :int = int( round( s.Data.foldr(a+b) / s.Data.len()))
  var mycost: int = 2^31
  for myAlignAt in countdown( myAverage, 0 ):
    var myDist: seq[int] = s.Data.mapIt(it-myAlignAt)
    var mySumDist:int = myDist.mapIt(abs(it)).foldr( a + b )
    if mycost < mysumdist:
      break
    mycost = mysumdist
      
  echo fmt"The answer to Day {Inputdata[3..4]} part 1 with {Inputdata} is 343441 (test data 37) .  Found is {mycost}"
    

proc Part02() =
  var myAverage :int = int( round( s.Data.foldr(a+b) / s.Data.len()))
  var mycost: int = 2^31
  for myAlignAt in countdown( myAverage, 0 ):
    var myDist: seq[int] = s.Data.mapIt(it - myAlignAt).mapit(int(abs(it)*(abs(it)+1) / 2))  
    var mySumDist:int = myDist.filterIt(it >= 0).foldr( a + b )
    if mycost < mysumDist:
      break
    mycost = mysumDist
      
  echo fmt"The answer to Day {Inputdata[3..4]} part 2  with {Inputdata} is 98925151 (Test data 168).  Found is {mycost}"
    

proc Execute*() =
    Part01()
    Part02()