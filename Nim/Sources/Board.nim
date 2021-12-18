import sequtils
import tables
import strutils
import support
import strformat

type
  BoardObj* = ref object of RootObj
    Numbers : seq[int]
    HRanks:  seq[Table[int,int]]
    VRanks:  seq[Table[int,int]]
    WinningNumber:int

proc newBoard*( ipBoard: string):  BoardObj =
  var myBoard= BoardObj()
  myboard.Numbers=ipBoard.multireplace(("  ", " ")).split(" ").mapit(it.parseint).deduplicate
  let myarray:seq[seq[int]] =ipboard.split("\r\n").mapit(it.split(" ").mapit(it.parseint))
  echo fmt"myArray {myarray}"
  
  #Make a list of the horizontal and vertical ranks of the Board
  for myRank in myArray:
    myBoard.HRanks.add toTable(zip(myRank, repeat(0,myRank.len())))
      
  var myTransposed:seq[seq[int]]=myarray.Transpose
  for myRank in myTransposed:
    myBoard.VRanks.add toTable(zip(myRank,repeat(0,myrank.len())))

  echo fmt"myBoard {myBoard[]}"
  return myBoard