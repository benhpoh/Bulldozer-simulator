# Bulldozer-simulator
- [Assumptions](https://github.com/benhpoh/Bulldozer-simulator#assumption)
- [Build Log](https://github.com/benhpoh/Bulldozer-simulator#build-log)
- [Thought Process](https://github.com/benhpoh/Bulldozer-simulator#thinking-out-loud)
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