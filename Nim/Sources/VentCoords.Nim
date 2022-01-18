import strutils
import sequtils
import strformat


const ctX1:int = 0
const ctY1:int = 1
const ctX2:int = 2
const ctY2:int = 3

type
    VentLineType = enum
        
        vlPoint = 1
        vlHorizontal = 2
        vlVertical = 4
        vlDiagonal = 8

    State=object
        X1 :int
        Y1 :int
        X2 :int
        Y2 :int
        TypeIs*: VentLineType


    VentCoords* = object
        s:  State

 
var me = VentCoords()
    
proc Deb*(ipCoords: string): VentCoords =
    let myCoords: seq[int] = ipCoords.split(',').mapit(it.parseint)
    
    me.s=State( X1: myCoords[ctX1], Y1: myCoords[ctY1], X2: myCoords[ctX2],    Y2: myCoords[ctY2])
        
    #Determine any equivalence between X1,X2 and Y1,Y2 so that we
    #can assign a type to the line
    
    if ((me.s.X1 == me.s.X2) and (me.s.Y1 == me.s.Y2)):   
        me.s.TypeIs = VentLineType.vlPoint

    elif me.s.Y1 == me.s.Y2:      
        me.s.TypeIs = VentLineType.vlHorizontal

    elif me.s.X1 == me.s.X2:                               
        me.s.TypeIs = VentLineType.vlVertical

    else:                                             
        me.s.TypeIs = VentLineType.vlDiagonal

    return me
    
proc GetLineType*(self:VentCoords): VentLineType=
    return self.s.TypeIs

iterator myStep( a,b: int):int=

        var a1 = a
        var b1 = b 
        if a<=b:
        
            while a1<=b1:
                yield a1
                inc a1
        
        else:

            while a1>b1:
                yield a1
                dec a1

proc GetCoords*(self:VentCoords): seq[string] =
    
    var myVentLine :seq[string]
    var myCoord :int
   
    var myYStep:int = if me.s.Y1 <= me.s.Y2: 1 else: -1
    
    case self.s.TypeIs:
        
        of vlPoint:        
            myVentLine.add("{me.s.X1},{me.s.Y1}".fmt)
            
            
        of vlHorizontal:
        
            for myCoord in mystep(me.s.X1,me.s.X2):
                myVentLine.add("{mycoord},{me.s.Y1}".fmt)
                

        of vlVertical:
        
            for myYCoord in mystep(me.s.Y1,me.s.Y2):
                myVentLine.add("{me.s.X1},{myCoord}".fmt)
            
        
        of vlDiagonal:
        
            for myXCoord in mystep(me.s.X1,me.s.X2):
                myVentLine.add("{myXCoord},{myCoord}".fmt)
                myCoord += myYstep
                
    return myVentLine
    
    

