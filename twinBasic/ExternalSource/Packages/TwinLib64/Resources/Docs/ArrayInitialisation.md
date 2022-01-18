# Array Initialisation in twinBasic

This library has been uploaded to provide access to the Lyst and Kvp classes (Collection/ArrayList and Scripting Dictionary replacements) to facilitate discussion of array initialisation in twinBasic.

## Gotchas
- I'm not a professional programmer so please don't expect beautiful code.  
- Formatting may be wonky due to multiple round trips between VBA and twinBasic and my personal preferences (esp vertical spacing)
- The Library was developed purely to assist me in writing code for Advent of Code Solutions.
- The Lyst and Kvp classes use 1 based indexing (the code is here, you can change it if you wish)

## Background
I got into Advent of Code in 2019.  VBA was the language I was most familiar with at the time as over the previous 20 years or so I'd used it on an ad hoc basis for helping me manage the formatting of technical documents (For the nosey these were QoS and Module 3 documents for the Common Technical Dossier used for license applications and licence maintenace of Medicines).    

It became apparent to me very quickly that for Advent of Code problems VBA put me in the position of writing many loops
- Parsing the raw data files
- Applying transformations to setts of data

This led me to trying to improve
- getting data into and out of collection type objects.
- applying transformations to data held in a single object.

I think I've got to a pretty good place with these objectives as shown by the following code

    Set s.Data = _
        Lyst _
          .Deb _
          .AddRange(VBA.Split(Filer.GetFileAsString(AoC2021Data & InputData), vbCrLf)) _
          .MapIt(mpSplitToLyst.Deb(Char.twBar)) _
          .MapIt(mpInner.Deb(mpSplitToLyst.Deb(Char.twSpace)))
          
which reads in a set of lines in the format

    cbdfag bf ebgda cfead aecbgd dfbea dbafecg fab bgdaef fgeb | bf defbag efadgbc bfgeda

and returns a Lyst of Lysts of Strings

    Lyst ->Lyst->Lyst->"cbdfag", "bf", "ebgda", "cfead", "aecbgd", "dfbea", "dbafecg" ,"fab", "bgdaef", "fgeb"
               ->Lyst->"bf", "defbag", "efadgbc", "bfgeda"

so if the above line was the 8th line of input you can access "ebgda" using

    myLyst(8)(1)(3)
    
more importantly I can for Each myLyst(8)(1)
    
That's not how I use things, it just illustrates the point.

The  Lyst and Kvp methods provide new instances via a factory method.  The name of this method is 'Deb'.  Deb was chosen as the name after much thinking.  Deb is a contraction of Debutante, which historically in the UK was a young female from the more priveledged end of society who had been through a process of 'training - usually called finishing school' and was being presented to 'upper class' society for the first time with a view to finding a suitable marriage partners.  In the latter halve of the 20th Century Debutantes were colloquially referred to plurally as 'Debs'.  SO Deb gives you an instance that is ready to use.

## Lyst Class

The Lyst class is a wrapper for the ArrayList class.
- It provides the missing intellisense
- It implements all overloads of the ArrayList methods
- The Add method has been extended to allow the addition of a list of items
- The AddRange method has been extended to allow the input of any object that can be enumerated using For Each
- I've added other methods as needs have arisen

This, in VBA, i can now say

    Dim myLyst as Lyst
    set myLyst = Lyst.deb.Add("Hello", "There", World", "Have", "a", "nice", "day")
    
I can subsequently retrieve data as an array or arraylist

    myLyst.ToArray
    myLyst.ToArrayList
    
which, for example,  makes getting data back into Excel as trivial task.
    
I think that this goes 90% of the way to resolving array initialisation

For Multidimensional array, these can be initialised as follows

### Emulating a 2D array

    Dim my2DLyst as Lyst
    set my2DLyst = _
        Lyst _
            .Deb _
            .Add( _
                Lyst.deb.Add("Hello", "There", World", "Have", "a", "nice", "Monday"), _
                Lyst.deb.Add("Hello", "There", World", "Have", "a", "goofy", "Tuesday"), _
                Lyst.deb.Add("Hello", "There", World", "Have", "a", "trendy", "Wednesday"), _
                Lyst.deb.Add("Hello", "There", World", "Have", "a", "super", "Thursday"), _
                Lyst.deb.Add("Hello", "There", World", "Have", "a", "daunting", "Friday"), _
                Lyst.deb.Add("Hello", "There", World", "Have", "a", "jolly", "Saturday"), _
                Lyst.deb.Add("Hello", "There", World", "Have", "a", "spooky", "Sunday") _
            )
        
I hope that from this example also indicates how higher dimensionality could be achieved.  Also note that the above code could be 'simplfied' by nesting the declaration in a With Lyst.Deb/End With structure.

From my perspective I think that this aspect of the Lyst class provides 99.9% of the utility that is being sought in the discussions on array initialisation.

## The Kvp Class
The Kvp class provides a dictionary version of the Lyst 
- It can be used as a direct replacement for the Scripting.Dictionary
- It allows automatic keys, from an arbitrary value for numbers and strings, or for they key type to be preset
  - SetKeysToNumber optional number
  - SetKeysToString optional start string (default "0000"), optional list of characters alloed in key
  - SetKeysAsIterable iterable list of keys, optional first index to use
- For string keys, the characters allowed in a key can be restricted to a predefined set of characters
- Keys can be restricted to a predefined set of values
- The add method parses input if only one or two items  are added so that it is possible to add pairs of sets of values

In VBA I can now write 

    Dim myKvp as Kvp
    set myKvp = Kvp.Deb  ' nb Deb is also chainable
    
 using key and value
 
    myKvp.add 10, "Hello"  ' sets the keys to number starting at 10
    
using a param array of items
    
    set myKvp = kvp.deb.add("Hello", "There", World", "Have", "a", "nice", "day")
    
which gives me a dictionary with the pairs

    1, "Hello"
    2, "There"
    3, "World"
    4, "Have"
    5, "a"
    6, "nice"
    7, "day"
    
I could also use add with a pair of iterables

    set myKvp = Kvp.deb.add(array("one", "two","three","Four", "Five", "Six", "Seven"), my2dList(2))
    
which would give me a dictionary with the pairs

    "One","Hello",
    "Two","There",
    "Three","World",
    "Four","Have",
    "Five","a",
    "Six","nice",
    "Seven",Monday",
    
With predefined keys

    set myKvp = Kvp.deb.SetKeysToIterable("one", "two","three", "Five", "Six", "Seven", "Eight") _
        .add("one", "two","three","Four", "Five", "Six", "Seven"), my2dList(2))
        
would give an error because "Four" is not one of the allowed keys

and finally, due to the limitations of parsing the add inputs, if I want to add two iterables as iterable they have to be wrapped in an iterable

Thus,

    set myKvp = Kvp.deb.add(array(array("one", "two","three","Four", "Five", "Six", "Seven"), my2dList(2)))
    
would give me the following pairs

    1, array("one", "two","three","Four", "Five", "Six", "Seven")
    2, my2dList(2)
    
### Kvp Class Add parsing

The Add method for the Kvp takes a ParamArray.

The paramarray is parsed depending on the number of items.  A primitive is a number, string or boolean (See Types classes)

- 1 item
    - primitive - added as a value using the next available autokey
    - 1D array - added as a list of items
    - 2D array - added as autokey vs row data
    - 3D array - added as autokey , 3dArray
    - IterableKeysByEnum - added as autokey to Items
    - IterableItemsByEnum - added as autokey vs item
    

- 2 items (this is very complicated so see the Parser class)
    - primitive, primitive - added as key value pair
    - 1D array, primitive - error
    - 1D array, 1D array - added as key value pairs
    - 1D array, 2Darray - added as item vs 2d rows
    - 1D array, 2D+ array - error
    - 1D array, iterableKeysByEnum added as items vs items
    - 1D array, iterableItemsByEnum added as Items vs Items
    - 2D array, TableToLystAction - adds the table based on the enum value
    - 2D array, primitive not a TableToLystAction enum - error
    - 2D array, 2D array, first item of row first 2D array va rows of second 2D array
    - 2D array, IterableKeysByEnum -error
    - 2D Array, IterableItemsByENum - error
    - 3D array, anything - error
     etc etc
    
- 3 items or more - the paramarray is added as a list of items against the current autokey
    
# Conclusion

IMHO the flexibility of entering data into the Lyst and Kvp classes address a significant proportion of the use cases for array literals when setting up 'constant' arrays and has the advantage of making this requirement a Library rather than compiler issue.

For multidimensional array there is a change in syntax to that akin to jagged arrays e.g. (x)(y)(z) rather than (x,y,z) but the gain in flexibility is a reasonable trade off.  For scientific use of matrices, I'd suggest that a separate focussed library is more appropriate.


# Final words
The library is a Work in Progress.  If you have any advice or guidance please let me know.  I would also welcome collaborators if it is felt that this library might be useful on a wider twinBasic basis.  You are also free to make effigies and do nasty things to it if you think my approach to this problem is to be abhorred.

## Other functionality in the library 
- Stringifier - an attempt at getting string output from anything
- Fmt - a poor mans string interpolation which allows substitution of variable fields and formatting fields
- Mapping - via the IMapper interface - examples of mapper objects are included
- Filtering - via the IFilter interface 
- Reducing - via the IReduce interface
- Types - lots of sugar for Is<Type> and IsNot<Type>
      - significant for me are the IsIterable, IsIterableObject, IsIterableKeysByEnum, IsIterableItemsByEnum
        which I think are difficult to replicate using generics and/or overloading
- Testing - Lots and Lots of tests which probably need a good overhaul
- Library status - using the Globals result and Bailout class 

if you want to see how this library plays out in terms of my solutions to advent of code problems feel free to have a gander at

https://github.com/FullValueRider/AoC2021/tree/main/twinBasic


    

    
    
    