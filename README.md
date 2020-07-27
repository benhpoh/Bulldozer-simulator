# Bulldozer-simulator

## Assumption
If a command results in the simulation ending (eg: advance 4 results in removal of protected tree / exiting site), the entire command is disregarded. Costs will be calculated up to the last valid command.


### Build log
- Basic commands completed (left, right, advance, location, history)
- CLI for program initiation complete. Next task: traversing the map vertically & horizontally
- Execute command method completed. Manually tested, but how do I implement automated tests?
- Map class completed. Next task: integration with Bulldozer class
- Built bulldozer.map method to display the current map
- CLI interface completed. Next task: build calculator for credit
---

## To Do List
- ~~Build Bulldozer Class with necessary commands~~
  - Build calculator to keep tabs on fuel and credits
- Build functionality to read map.txt
  - ~~Feed data into "advance" command to categorize simulation ending moves~~
  - Determine if stopping on / passing through a removable tree for credit calculation purposes.
- ~~Build loop for CLI to receive commands~~
- Build quit command. Upon quitting output:
  - Simulation ended due to (user command / illegal command)
  - History
  - Costs
---

### Thinking out loud
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
- Fuel
  - Check path of each advance. Map to fuel cost
- Uncleared square at end of simulation
  - At end of simulation, calculate number of squares that aren't /[-T]/
  - Add to cost
- Destruction of protected tree
  - Technically simulation is ended before that happens
  - If Error Code shows "T", add 10 credits to final cost
- Paint damange to clearable tree
  - Check path of each advance