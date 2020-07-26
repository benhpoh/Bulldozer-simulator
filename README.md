# Bulldozer-simulator

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

### Build log
- Basic commands completed (left, right, advance, location, history)
- CLI for program initiation complete. Next task: traversing the map vertically & horizontally
- Execute command method completed. Manually tested, but how do I implement automated tests?
- Map class completed. Next task: integration with Bulldozer class
- Built bulldozer.map method to display the current map

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