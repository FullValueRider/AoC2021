import math

proc Transpose*[T](ipSource:seq[seq[T]]): seq[seq[T]]=
    var myTransposed:seq[seq[T]]=newseq[seq[T]](ipsource[0].len())
    for myItem in ipSource:
        for myIndex in 0..myItem.high:
            myTransposed[myIndex].add myItem[myIndex]
    return myTransposed



proc BinStrToInt*(ipSource:string): int =
    var myvalue:int=0
    for myIndex in countdown(ipSource.high,0):
        if ipsource[myindex] == '1':
            myValue += 2 ^ (ipSource.len() - myIndex-1)
    return myValue


proc BinStrToInt*(ipSource:seq[char]):int=
    var myvalue:int=0
    for myIndex in countdown(ipSource.high,0):
        if ipsource[myindex] == '1':
            myValue += 2 ^ (ipSource.len() - myIndex-1)
    return myValue