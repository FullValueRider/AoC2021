import strformat
import sequtils
import strutils
import tables 
import AoCLib

const InputData = "Day05Test.txt"

type

  State = object
    Ventlines: VentCoords

#Seq use 0 base d indexing whereas the Lyst class used 1 based indexing.
const myPoints : int = 0
const myHLines : int = 1
const myVLines : int = 2
const myDLines : int = 3

const myX1 : int= 0
const myX2 : int = 2
const myY1 : int = 1
const myY2 : int = 3


var s: State = State()



proc CheckCoords(iprun:  seq[int],ipCoords:var Table[string,int]) =
  #echo fmt"{ipRun}"
  var 
    mysingleXStep, mySingleYStep:int
    myx, myy :int
    myXStop ,myYStop ,myXNotPassedToX, myYNotPassedToY: IComparer

  myX = ipRun[myX1]
  if ipRun[myX1] <= ipRun[myX2] :
    
    mySingleXStep = 1
    myXStop = IComparer(ExecCmp: cmpMTEQ) #' X1 mt x2
    myXNotPassedToX = IComparer( ExecCmp:cmpLT) #x1 lteq x2
    
  else :
    
    mySingleXStep = -1
    myXStop = IComparer( ExecCmp:cmpLTEQ)
    myXNotPassedToX = Icomparer(Execcmp:cmpMT)
    
  myY = ipRun[myY1]
  if ipRun[myY1] <= ipRun[myY2] :
    
    mySingleYstep = 1
    myYStop = IComparer(ExecCmp:cmpMTEQ)
    myYNotPassedToY = IComparer(ExecCmp:cmpLT)

  else:
  
    mySingleYstep = -1
    myYStop = IComparer(ExecCmp:cmpLTEQ)
    myYNotPassedToY = IComparer(ExecCmp:cmpMT)

  # While true: = VBA Do  ..  Loop
  while true:
    
    var myCoord = $myx & "," & $myy
    #echo fmt"{myCoord}"
    if myCoord in ipCoords:
      
      ipCoords[myCoord] += 1
      
    else:
      
      #adds key myCoord if it does not exist
      ipCoords[myCoord] =  1
    
    if myXStop.ExecCmp(myX,iprun[myx2]) and myYStop.ExecCmp(myX,iprun[myx2]):
      break

    if myYNotPassedToY.ExecCmp(myY,iprun[myy2]):
      myY += mySingleYstep

    if myXNotPassedToX.ExecCmp(myX,iprun[myX2]):
      myX += mySingleXStep
      

proc CalculateVentLocations( ipLines : var seq[seq[seq[int]]], ipLinesToCheck: seq[int]) :Table[string,int] =
  
  var myCoords :Table[string,int]

  for myLine in ipLinesToCheck:

    for myRun in ipLines[myLine]:
     
      CheckCoords( myRun, myCoords)
      
  return myCoords

  


proc getlinetype(ipRun:seq[int]): int =
  if (ipRun[myX1] == ipRun[myX2]) and (ipRun[myY1] == ipRun[myY2]):
    return 0
  elif ipRun[myY1] == ipRun[myY2]:
    return 1
  elif ipRun[myX1] == ipRun[myX2]:
    return 2
  else: # abs(iprun[myX1] - iprun[myX2]) - abs(iprun[myY1] - iprun[myY2]) == 0
    return 3

proc FilterRuns( ipRuns:var seq[seq[int]]) :  seq[seq[seq[int]]] =
  
  var myLyst:seq[seq[seq[int]]]
  
  myLyst.add @[]
  myLyst.add @[]
  myLyst.add @[]
  myLyst.add @[]
  
  #Dim myRun As Variant
  for myRun in ipRuns:

    mylyst[getlinetype(myrun)].add myRun
    
  return myLyst


proc Initialise() =
    s.Ventlines = 
        readfile(RawDataPath2021 & InputData).split("\r\n").mapit(it.multireplace((" ", ""),("->", ",")))  #.mapit(VentCoords(it)))


proc Part01() =
    Initialise()
    var myLines = FilterRuns(s.Ventlines)
    var myVentLocations = CalculateVentLocations(myLines, @[myPoints, myHLines, myVLines])
    #echo fmt"{myventlocations}"
    var myResult = myVentLocations.values.toseq.countIt(it>1)

    echo fmt"The answer to Day 05 part 1 is 7085.  Found is {myresult}"
    

proc Part02() =
  var myLines   = FilterRuns(s.Data)
  var myVentLocations = CalculateVentLocations(myLines, @[myPoints, myHLines, myVLines, myDLines])
  var myResult =myVentLocations.values.toseq.countIt(it>1)
  echo fmt"The answer to Day 05 part 2 is 20271.  Found is {myresult}"
    

proc Execute*() =
    Part01()
    Part02()
     