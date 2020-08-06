# Bulldozer-simulator
- [Assumptions](https://github.com/benhpoh/Bulldozer-simulator#assumption)
- [Build Log](https://github.com/benhpoh/Bulldozer-simulator#build-log)
- [Thought Process](https://github.com/benhpoh/Bulldozer-simulator#thinking-out-loud)
- [Test Driven Development](https://github.com/benhpoh/Bulldozer-simulator#tests)
## Operations
**Inputs**
1. A file containing a site map. This will be specified on the command line when the
application is started.
2. Commands entered by the trainee on the console during the simulation run, as described
below under "Operation".

**Outputs**
1. A list of all the commands that were entered by the trainee.
2. A table providing itemized costs of the clearing operation and a total cost

Program can be initiated by entering "ruby main.rb sample_map.txt"

---

**Rules**

The site map is defined by a text file with one character per square of the site. Each row must have the same number of characters. Plain land is marked with the letter ‘o’, rocky land is marked with the letter ‘r’, removable trees are marked with the letter ‘t’, and trees that must be preserved are marked with the letter ‘T’. For example, the following describes a site that is 10 squares wide and 5 squares deep:
```
ootooooooo
oooooooToo
rrrooooToo
rrrroooooo
rrrrrtoooo
```
The initial position of the bulldozer will be outside of the site, to the left of the top left (north west) square of the site, facing towards the east. The bulldozer will never be blocked (by an unremovable tree) from entering the site by driving east.

The available commands are:

- **Advance**: this command takes a positive integer parameter to define the number of squares
the bulldozer should move forwards (in whatever direction it is currently facing);
- **Left**: turn the bulldozer (on the spot) 90 degrees to the left of the direction it is facing;
- **Right**: turn the bulldozer 90 degrees to the right;
- **Quit**: end the simulation.

An attempt to move beyond the boundaries of the site will end the simulation even if there is
uncleared land.

## Assumption
If a command results in the simulation ending (eg: advance 4 results in removal of protected tree / exiting site), the entire command is disregarded. Costs will be calculated up to the last valid command.

Penalty rate of 10 credits (destruction of protected tree) will still apply even though the command is disregarded.

[Back to top](https://github.com/benhpoh/Bulldozer-simulator#bulldozer-simulator)

---

# Build log
- Basic commands completed (left, right, advance, location, history)
- CLI for program initiation complete. Next task: traversing the map vertically & horizontally
- Execute command method completed. Manually tested, but how do I implement automated tests?
- Map class completed. Next task: integration with Bulldozer class
- Built bulldozer.map method to display the current map
- CLI interface completed. Next task: build calculator for credit
- Calculator completed for fuel & credit units
- Output formatted for post simulation ending
- Updated argument checker method

[Back to top](https://github.com/benhpoh/Bulldozer-simulator#bulldozer-simulator)

---

## To Do List
- ~~Build Bulldozer Class with necessary commands~~
  - ~~Build calculator to keep tabs on fuel and credits~~
- ~~Build functionality to read map.txt~~
  - ~~Feed data into "advance" command to categorize simulation ending moves~~
  - ~~Determine if stopping on / passing through a removable tree for credit calculation purposes.~~
- ~~Build loop for CLI to receive commands~~
- ~~Build quit command. Upon quitting output:~~
  - ~~Simulation ended due to (user command / illegal command)~~
  - ~~History~~
  - ~~Costs~~
- Prettify Readme
  - There's always room for improvement when it comes to aesthetics...
---

## Thinking out loud
How should I traverse the map?
- Option 1
  - 'Map' array containing \<x> subarrays for each row
  - Each subarray containing \<y> elements for each col
  - Map[i + x] to traverse North / South
  - Map[z][i + y] to traverse East / West
  - If ( index < 0 || index > array.length ), bulldozer has fallen out of map
- ~~Option 2~~
  - Determine map's width (num of cols)
  - Single array containing all elems
  - Map[i + x] to traverse East / West
  - Map[i + (y * num_of_cols)] to traverse North / South
  - *Harder to work out when bulldozer falls off*

How to pass command inputs to bulldozer?
- Commands are received as String through console
- Can't directly do bulldozer.String
- Bulldozer.command(String)
- Add method to Bulldozer to parse String into commands
- Error encountered with advance command. "4" in "a 4" is processed as a String. Need to convert "4".to_i

How to check if stopping on tree or passing through tree?
- Store path cleared in each advance command as a single array?
  - [o, o, t, r] => map to fuel costs => [1, 1, 2, 2]
  - [o, o, t, r] => if arr.index("t") != arr.length - 1, credit + 2

Calculating costs
- ~~Communication overhead per command~~
  - Done. Bulldozer has method to retrieve history of commands
- ~~Fuel~~
  - Check path of each advance. Map to fuel cost
- ~~Uncleared square at end of simulation~~
  - At end of simulation, calculate number of squares that aren't /[-T]/
  - Add to cost
- Destruction of protected tree
  - Technically simulation is ended before that happens
  - If Error Code shows "T", add 10 credits to final cost
- ~~Paint damange to clearable tree~~
  - Check path of each advance

Should Map be a child of Bulldozer?
- ~~No~~
  - Bulldozer only needs to know L, R, A
    - But how does it know if the A command is legal if Bulldozer doesn't know where it is positioned?
    - Position class? What does the Position class abstract away from the Bulldozer?
- Yes
  - Bulldozer instance should have awareness of its environment
  - Bulldozer.position returning the specific bulldozer instance's position is logical

Should Bulldozer keep record of its route?
- Map keeps record
  - Logical because there's no need to pass each individual information from Map back to Bulldozer
  - Upon simulation ending, pass through routes record, and final map data.
- ~~Bulldozer keeps record~~
  - Map being a child of Bulldozer means at some point it needs to pass the route information back up the chain for calculation
  - Information only needs to be passed up at the end of Bulldozer's activities.

---

## Tests
A series of tests were created to unit test each Class.

Look in the "lib" folder to see the series of test cases for the Bulldozer, Map, and Cost classes.

Tests were created for individual method calls, and combined method calls.

[Back to top](https://github.com/benhpoh/Bulldozer-simulator#bulldozer-simulator)

---

## Further feedback
- The site map consists of the input characters.
  - To review
  - Convert chars to Objects? plains = {display: "o", fuel_cost: 1, value: "Plains"}

- The Map class exposes the core of its internal structure (2d array of characters), which makes it brittle. 
  - Is this a problem? No external methods present that exposes the structure to modification.

- There are examples in Map of conditionals directly returning booleans on both branches, suggesting the candidate lacks basic coding experience.
  - Uncertain what this refers to. Booleans appear the right datatype to return based on conditions (eg. Is the square being cleared a protected tree / Is the bulldozer exiting the site)

- There are no classes to represent the different types of land and their individual attributes and behaviours. This results in this knowledge being spread amongst other objects (Bulldozer and Cost), implemented with conditional logic based on characters from the site map.
  - To review

- There is a main file that contains an assortment of logic that should be part of other objects. It includes some simulation flow logic, cost calculation, and reporting.

- There is a floating global method called ‘check_file()’. It doesn’t do what its name indicates anyway - it checks program arguments.
  - Yes, and no. It checks the program argument to see if the specified file is of the right filetype.
  - Reviewed, and refactored from a global method into a CheckInput class, which separates the two checks (right number of arguments, right filetype extension)

- The command line processing is inside the Bulldozer. This is an avoidable complication for the Bulldozer. There is a missing abstraction for input command parsing.
  - Agreed. To update and abstract command processing

- Command processing in the Bulldozer returns loosely structured data from its command processing. It is attempting to indicate multiple different things so it returns an array instead of a scalar or more structured object. Sometimes it only returns an array by coincidence (e.g. a string), so the caller that indexes into the array seems to work by accident. There is no direct unit test of this code.
  - Agreed. Returning an object seems a more appropriate strategy

- The Bulldozer stores (and exposes) a list of commands in text form.

- The Bulldozer has a method for reporting all costs - that seems like an odd responsibility for a bulldozer.

- There is no class for the direction, leading to the Bulldozer having logic for direction changes. Directions are stored as strings causing unnecessary duplication and use of memory - even if you accepted that a text form for this was OK, a symbol (equivalent of an internalised string in Java) would be used idiomatic Ruby.
  - Agreed. Swapping to symbols is an improvement