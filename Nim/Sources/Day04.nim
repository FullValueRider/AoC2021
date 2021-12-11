import strformat
import sequtils
import strutils
import tables

import Constants
import Support

const InputData = "Day04Test.txt"

type    

    Rank = object
        Nos:seq[int]  #Items was a bad choise, replaced with Nos
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
        Win:bool
        Answer:int

#forward declarations
proc MakeBoard(ipBoardNumbers:seq[seq[int]]):Board       

#Initialisation        
var s : State
s.Data = readfile(RawDataPath & InputData).multireplace(("  "," ")).split("\r\n\r\n",1)
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


proc DeclareWInner(ipBoard:Board) =
    for myHrank in ipBoard.HRanks:
        for myIndex,myHit in myHrank.Hits.pairs:
            if myHit==1:
                s.Answer += myHRank.Nos[myIndex]


proc BoardWins(ipBoard: Board):bool =
    for myHRank in ipBoard.HRanks:
        if myHRank.Hits.countit(it>0) == myHRank.Hits.len():
            DeclareWinner(ipBoard)
            return true
    
    for myVRank in ipBoard.VRanks:
        if myVRank.Hits.countit(it>0) == myVRank.Hits.len():
            DeclareWinner(ipBoard)
            return true

    return false


proc BoardHit(ipBoardIndex:int, ipNumber:int):bool=

    if ipNumber notin s.Boards[ipBoardIndex].Numbers:
        return false
    
    for myRankIndex in 0..s.Boards[ipBoardIndex].HRanks.high:

        if ipNumber in s.Boards[ipBoardIndex].HRanks[myRankIndex].Nos:
            let myHitIndex =s.Boards[ipBoardIndex].HRanks[myRankIndex].Nos.find(ipnumber)
            s.Boards[ipBoardIndex].HRanks[myRankIndex].Hits[myHitIndex] = 1

        if ipNumber in s.Boards[ipBoardIndex].VRanks[myRankIndex].Nos:
            let myHitIndex =s.Boards[ipBoardIndex].VRanks[myRankIndex].Nos.find(ipnumber)
            s.Boards[ipBoardIndex].VRanks[myRankIndex].Hits[myHitIndex] = 1

    return true


proc PlayGame() =

    for myNumber in s.DrawnNumbers:

        for myBoardIndex in 0..s.Boards.high:

            if BoardHit(myBoardIndex,myNumber):

                if BoardWins(s.Boards[myBoardIndex]):
                    s.Answer = s.Answer * myNumber
                    return


proc Part01() =
    
    PlayGame()
    #echo fmt"The answer to Day 04 part 1 is xxxxxxx .  Found is {s.Answer}."
    echo fmt"The answer to Day 04 part 1 is xxxxxxx .  Found is. {s.Answer}" 


# proc Part02() =
   
#     var myResult:int
#     echo fmt"The answer to Day 04 Part 1 is xxxxxxx. Found {myResult}"

proc Execute*()=
    
    Part01()
    #Part02()
