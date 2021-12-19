import strformat
import sequtils
import strutils
import AoCLib

const InputData = "Day06.txt"

type
  State = object
    Data: seq[int]

var s : State
s.Data = readfile(RawDataPath2021 & InputData).split(",").mapIt( it.parseint )

proc Grow(ipDays:int, ipFishes:seq[int]): int =

  var myHist = repeat(0,9)
  for myFishAge in ipFishes:
    myHist[myFishAge]+=1

  for myDays in 1..ipDays:
    var myspawn=myHist[0]
    myHist.delete(0)
    myHist.add( myspawn)
    myHist[6]+=myspawn
  
  return myHist.foldl(a+b)


proc Part01() =
  var myResult :int =Grow(80,s.Data)
  echo fmt"The answer to Day 06 part 1 with {Inputdata} is 353079 (test data 5934) .  Found is {myresult}"
    

proc Part02() =
  
  var  myResult :int =Grow(256,s.Data)
  echo fmt"The answer to Day 06 part 2  with {Inputdata} is 1605400130036 (Test data 26984457539).  Found is {myresult}"
    

proc Execute*() =
    Part01()
    Part02()

    # proc Part01() =
#   # This brute force approach works for 80 days
#   # it also works for 256 days but runs out of memory
# before it completes
#   var mySum: int
#   for myItem in s.Data:

#     var myLampFish: seq[int] = @[myitem]
#     for mycounter in 1..256:
      
#       myLampfish = myLampFish.mapIt(it-1)
#       var mySpawn = myLampFish.countIt(it == -1)
#       if mySpawn > 0:
#         # opposite way around to my vba getconstseries
#         myLampFish = myLampFish.concat(repeat( 8,mySpawn))
#       mylampfish =myLampFish.mapIt(if it<0: 6 else: it)
#       echo fmt"{mycounter}\t"
#     mySum=  mysum + myLampFish.len()
    
  
#   var myResult :int =mysum

#   echo fmt"The answer to Day 06 part 1 with {Inputdata} is 353079(test data 7085) .  Found is {myresult}"