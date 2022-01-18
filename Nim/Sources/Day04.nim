import strformat
import sequtils
import strutils

import AoCLib

const InputData = "Day04.txt"

type    

    Rank = object
        Nos:seq[int]  #Items was a bad choise of name, replaced with Nos
        Hits:seq[int]
    
    Board = object
        Numbers :seq[int]
        HRanks: seq[Rank]
        VRanks: seq[Rank]

    State = object
        Data: seq[string]
        DrawnNumbers:seq[int]
        BoardsAsNumbers:seq[seq[seq[int]]]
        Boards:seq[Board]
        BoardNo:int
        Win:bool
        Answer:int

#forward declarations
proc MakeBoard(ipBoardNumbers:seq[seq[int]]):Board       

#Initialisation        
var s : State
s.Data = readfile(RawDataPath2021 & InputData).multireplace(("  "," ")).split("\r\n\r\n",1)
#echo fmt" Data {s.Data}"

s.DrawnNumbers=s.Data[0].split(",").toseq().map(parseint)
#echo fmt"DrawnNumbers {s.DrawnNumbers}"

s.BoardsAsNumbers=s.Data[1].multireplace(("\r\n ","\r\n")).split("\r\n\r\n").mapit(it.split("\r\n").mapit(it.split(" ").mapit(it.parseint))) 
#echo fmt"s.BoardNUmbers {s.BoardNumbers}"

s.Boards = s.BoardsAsNumbers.mapit(it.Makeboard)
#echo fmt"s.Boards {s.Boards}"

proc MakeBoard(ipBoardNumbers:seq[seq[int]]):Board = 
    var myBoard:Board
    #Make a list of the numbers on the board
    #There must be a more nimish way to collect a unique set of numbers
    for myRank in ipBoardNumbers: 
        myBoard.Numbers=concat(myBoard.Numbers, myRank)
    myboard.Numbers= myBoard.Numbers.deduplicate()
    
    #Make a list of the horizontal and vertical ranks of the Board
    for myRank in ipBoardNumbers:
        myBoard.HRanks.add Rank(Nos:myRank, Hits:repeat(0,myRank.len()))
       
    var myTransposed:seq[seq[int]]=ipBoardNumbers.Transpose
    for myRank in myTransposed:
        myBoard.VRanks.add Rank(Nos:myRank,Hits:repeat(0,myrank.len()))

    return myBoard


proc DeclareWInner(ipBoardIndex:int) =
    s.Boardno=ipboardindex
    s.Answer=0
    for myHrank in s.Boards[ipBoardIndex].HRanks:
        for myIndex,myHit in myHrank.Hits.pairs:
            if myHit==0:
                s.Answer += myHRank.Nos[myIndex]


proc BoardWins(ipBoardIndex: int):bool =
    for myHRank in s.Boards[ipBoardIndex].HRanks:
        if myHRank.Hits.countit(it>0) == myHRank.Hits.len():
            DeclareWinner(ipBoardIndex)
            return true
    
    for myVRank in s.Boards[ipBoardIndex].VRanks:
        if myVRank.Hits.countit(it>0) == myVRank.Hits.len():
            DeclareWinner(ipBoardIndex)
            return true

    return false


proc BoardHit(ipBoardIndex:int, ipNumber:int):bool=
    var myHit:bool=false
    if ipNumber notin s.Boards[ipBoardIndex].Numbers:
        return myHit
    
    for myRankIndex in 0..s.Boards[ipBoardIndex].HRanks.high:

        if ipNumber in s.Boards[ipBoardIndex].HRanks[myRankIndex].Nos:
            let myHitIndex =s.Boards[ipBoardIndex].HRanks[myRankIndex].Nos.find(ipnumber)
            s.Boards[ipBoardIndex].HRanks[myRankIndex].Hits[myHitIndex] = 1
            myhit=true

        if ipNumber in s.Boards[ipBoardIndex].VRanks[myRankIndex].Nos:
            let myHitIndex =s.Boards[ipBoardIndex].VRanks[myRankIndex].Nos.find(ipnumber)
            s.Boards[ipBoardIndex].VRanks[myRankIndex].Hits[myHitIndex] = 1
            myhit=true

    return myhit


proc PlaySquidBingo() =
    for myNumber in s.DrawnNumbers:
        for myBoardIndex in 0..s.Boards.high:
            if BoardHit(myBoardIndex,myNumber):
                if BoardWins(myBoardIndex):
                    s.Answer = s.Answer * myNumber
                    return

proc FindLastWinner()=
    var myBoardsInPlay:seq[int]=toseq(0..s.Boards.high)
    for myNumber in s.DrawnNumbers:
        for myBoardIndex in 0..s.Boards.high:
            if myBoardIndex in myBoardsInPlay:
                if BoardHit(myBoardIndex,myNumber):
                    if BoardWins(myBoardIndex):
                        if myBoardsinplay.len()==1:
                            s.Answer = s.Answer * myNumber
                            return
                        else:
                            myBoardsinplay.delete(myBoardsinplay.find(myBoardIndex))




proc Part01() =
    
    PlaySquidBingo()
    echo fmt"The answer to Day 04 part 1 is 45031. Found {s.Answer}" 


proc Part02() =
   
    FindLastWinner()
    echo fmt"The answer to Day 04 Part 2 is 2568. Found {s.Answer}"

proc Execute*()=
    
    Part01()
    Part02()
