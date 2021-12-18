import strformat
import sequtils
import strutils
#import tables
import Board

import Constants
#import Support

const InputData = "Day04Test.txt"

# type    

    # Rank = object
    #     Nos:seq[int]  #Items was a bad choise of name, replaced with Nos
    #     Hits:seq[int]
    
    
    # State = object
    #   DrawnNumbers:seq[int]
    #   BoardsAsNumbers:seq[seq[seq[int]]]
    #   Boards:seq[Board]

    # Properties* = object
    #     Boards:seq[Board]

let data :seq[string] = readfile(RawDataPath & InputData).multireplace(("  "," ")).split("\r\n\r\n",1)
let drawNumbers:seq[int] = data[0].split(",").map(parseint)
echo fmt"Drawnumbers {drawNumbers}"

let boardsAsString:seq[string] = data[1].multireplace(("  "," ")).multireplace(("\r\n ","\r\n")).split("\r\n\r\n")
echo fmt"BoardsAsString {boardsasString}"
let boards:seq[BoardObj] = boardsAsString.mapit(it.newBoard())
echo "myBoards"  
echo boards


# ( DrawnNumbers:Data[0].split(",").toseq().map(parseint),
# #echo fmt"DrawnNumbers {s.DrawnNumbers}"

# )

#echo fmt"s is {s[]}"


# BoardsAsNumber: Data[1].multireplace(("\r\n ","\r\n")).split("\r\n\r\n").mapit(it.split("\r\n").mapit(it.split(" ").mapit(it.parseint))) ,
# #echo fmt"s.BoardNUmbers {s.BoardNumbers}"

# Boards : BoardsAsNumbers.mapit(it.Makeboard)
# #echo fmt"s.Boards {s.Boards}"
# )

    


# # proc DeclareWInner(ipBoardIndex:int) =
# #     s.Boardno=ipboardindex
# #     s.Answer=0
# #     for myHrank in s.Boards[ipBoardIndex].HRanks:
# #         for myIndex,myHit in myHrank.Hits.pairs:
# #             if myHit==0:
# #                 s.Answer += myHRank.Nos[myIndex]


# # proc BoardWins(ipBoardIndex: int):bool =
# #     for myHRank in s.Boards[ipBoardIndex].HRanks:
# #         if myHRank.Hits.countit(it>0) == myHRank.Hits.len():
# #             DeclareWinner(ipBoardIndex)
# #             return true
    
# #     for myVRank in s.Boards[ipBoardIndex].VRanks:
# #         if myVRank.Hits.countit(it>0) == myVRank.Hits.len():
# #             DeclareWinner(ipBoardIndex)
# #             return true

# #     return false


# proc BoardHit( ipBoard:var Board, ipNumber:int):bool=
#     var myHit:bool=false
#     if ipNumber notin ipBoard.Numbers:
#         return myHit
    
#     for myRank in ipBoard.HRanks:

#         if ipnumber in myrank:
#             myrank[ipnumber] = 1
#             myhit=true
    
#     for myrank in ipboard.Vranks

#         if ipNumber in myrank:
#             let myHitIndex =s.Boards[ipBoardIndex].VRanks[myRankIndex].Nos.find(ipnumber)
#             s.Boards[ipBoardIndex].VRanks[myRankIndex].Hits[myHitIndex] = 1
#             myhit=true

#     return myhit


# proc PlaySquidBingo() =
#     for myNumber in s.DrawnNumbers:
#         for myBoard in s.Boards:
#             if BoardHit(myBoard,myNumber):
#                 if BoardWins(myBoard):
#                     s.Answer = s.Answer * myNumber
#                     return

# # proc FindLastWinner()=
# #     var myBoardsInPlay:seq[int]=toseq(0..s.Boards.high)
# #     for myNumber in s.DrawnNumbers:
# #         for myBoard in s.Boards:
# #             if myBoardIndex in myBoardsInPlay:
# #                 if BoardHit(myBoardIndex,myNumber):
# #                     if BoardWins(myBoardIndex):
# #                         if myBoardsinplay.len()==1:
# #                             s.Answer = s.Answer * myNumber
# #                             return
# #                         else:
# #                             myBoardsinplay.delete(myBoardsinplay.find(myBoardIndex))




# proc Part01() =
    
#     PlaySquidBingo()
#     #echo fmt"The answer to Day 04 part 1 is xxxxxxx .  Found is {s.Answer}."
#     echo fmt"The answer to Day 04 part 1 is 45031. Found {s.Answer}" 


# proc Part02() =
   
#     #FindLastWinner()
#     echo fmt"The answer to Day 04 Part 2 is 2568. Found {s.Answer}"

# proc Execute*()=
    
#     Part01()
#     Part02()
