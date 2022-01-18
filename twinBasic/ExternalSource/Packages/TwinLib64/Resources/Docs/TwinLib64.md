# The TwinBasicLib64 Library

## Background

This library originates for my efforts at writing Advent of Code solutions in VBA.  I was frustrated at the amount of boilerplate code needed to achieve anything useful so I set about improving the utility of the Scripting.Dictionary, which led me into C# and then final back to VBA but using twinBasic to compile the library.<br>

At present, the code for the library is written in pure VBA to facilitate the use of Rubberduck and its amazzing capabilities.

The Library has one external reference, which is to the ArrayList object in mscorelib.  I hope to be able to replace the Arraylist with a pure twinBasic object in the near future.

The principle features of the library are the Lyst and Kcp classes.

The Lyst class is a wrapper for the ArrayList which provides intellisense for the ArrayList methods, implements the overloads in VBA and provides extensions that make the Lyst an even more usable object.

The Kvp class is a dictionary class implemented using a pair of lyst classes.  It offers all the methods provided by the Scripting.Dictionary but is vastly more usable.

As the code for these two classes developed I added a bunch of other code to help me think about what I was trying to do and also cut down on boilerlate code.

This Library was developed in a Piecemeal ad hoc fashion so likely contains mistakes.  Professional programmers may fall about laughing at the code I've used, or maybe will need a degree of therapy.

In my view the library is a great success.  The Lyst and Kvp classes have allowed enormous simplification of code written for Advent of Code problems.

I'm always open to suggestions and learnings, so please let me know if you see anything that could be improved.  But please remeber that I'm not a prefessional programmer, I just historically used a bit of VBA in WOrd to hep me manage technical documents.  

### Why 'Deb'?
And in case you get to wondering.  

Both Lyst and Kvp have predecalredIds and use a facotry method (Deb) to return a new Instance of the Class.  Why 'Deb'?  Well I once got criticised for calling the facotry Method 'Create', and I wanted to avoid the confusion of using 'New' as a method.  SO after mucxh thinking and searching of he Thesaurus, I came up with 'Debutante', which historically has been a high society you lasy who has completed finishing school and is now being presented to society with a view to finding her a spouse.  In the latter years of the 20th centruy Debutante were colloquially known as Debs.  So there you have it.  Deb produces a new instance of the predeclaredid ready to be married of with the data with which you wish to populate it.

## The Lyst Class

The Lyst class implements a one dimensional list of objects.  It is derived from the mscorelib ArrayList (system.collections.arraylist).  The class has a factory method, and all methods which do not result in a specific non Lyst result, return the instance of Me so that Lyst methods can be chained.  A summary of the advantages of the Lyst class over the Arraylist are summarised below
<br>
<br>
- Provides intellisense for all methods
- Any enumerable object can be added to a Lyst with a single instruction
- Any enumarable object can be retrieved from a Lyst Object
- Allows positive and negative indexing
- Provides MapIt, CountIt and FilterIt methods
- Provides a zip method to facilitate enumerative to enumerable objects
- Implements a factory method for creating a New Lyst from the PredeclaredId
- Methods not returning a specific result return the instance of Me to allow Method chaining.

## Methods/Properties and Sugar

Sugar is the gratuitous inclusion of a Method which only wraps an existing method and is provided to allow compatibility with existing code e.g Enqueue is a warpper for Add but is provided to allow comptibility with System.Collections.Queue.

### Deb

Arguments: None

Returns: New instance of the Lyst class

Example

    Dim myLyst as Lyst
    Set myLyst = Lyst.Deb
    

### Add
Arguments: One or more items 
Returns: Lyst populated with the Items

#### Examples

    myLyst.add 10,20,30,40,50
    myLyst.add "Hello", "There", "World"
    
    
### AddRange
Arguments: A single enumerable object or single item - the type of enumerable is checked and specific actions taken
Returns: Lyst Populated with the contents of the enumerable object

#### Example

    myLyst.AddRange array(10,20,30,40,50)
    myList.AddRange myDict  ' adds the dictionary as a sin
    
#### Specific Actions

The AddRange method tests the type of the enumerable provided and takes the following actions

- If a single item that is not an enumerable, just replicates the Add method
- If two dimensional array is added, the Table is added