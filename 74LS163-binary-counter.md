### Goal: Design a replacement for a 74LS163 binary counter.

### Resources: [74LS163 datasheet](https://datasheetspdf.com/pdf-file/375457/FairchildSemiconductor/74LS163A/1)

### Plan:
1. Determine inputs and outputs.
2. Create entity block.
3. Determine the logic (how inputs and outputs interact).
4. Create the architecture block.
5. Simulate to verify that the design is working.
6. Make edits if the design is not working.

### Design:

Inputs: CP (clock), SR (synchronous reset, active low), P[3:0] (parallel input), PE (parallel load), CEP (count enable parallel input), CET (count enable trickle input).

Outputs: Q[3:0], TC (terminal count).

Schematic:

![image](https://github.com/coolnikitav/nikitas-notebook/assets/30304422/612ed0cf-f283-4ed0-854c-b1ca25845710)

Logic:

If PE = 0 => Q = P

If SR = PE = CET = CEP = 1 => Count

If PE = 1 and (CET = 0 or CEP = 0) => No change (hold)

If CET = Q3 = Q2 = Q1 = Q0 = 1 => TC = 1 (reached highest count)

If SR = 0 => Q3 = Q2 = Q1 = Q0 = 0 (clear, edge-triggered)

### Code:
```
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
   TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture bnr_cntr of AAC2M2P1 is 
    signal t_cnt : unsigned(3 downto 0); -- internal counter signal
begin
    process (CP)
    begin
      if (rising_edge(CP)) then
        if (SR = '0') then
	    t_cnt <= "0000";
	else
	    if (PE = '0') then
	        t_cnt <= unsigned(P);
	    elsif (CET = '1' and CEP = '1') then
		t_cnt <= t_cnt + 1;
	    end if;
	end if;
      end if;
    end process;
    Q <= std_logic_vector(t_cnt);     
    TC <= t_cnt(3) and t_cnt(2) and t_cnt(1) and t_cnt(0) and CET;
end bnr_cntr;
```

### Simulation:

![image](https://github.com/coolnikitav/nikitas-notebook/assets/30304422/9a31e43a-384f-4b11-b907-405c407b2009)


### Troubleshooting:
- First version of the code was able to count 0-15 and then reset. The clear, hold, and other functions were working as well.
- However, the setup did not work as intended (when the simulation is started at 0ns).
- I had 2 if statement sequentially:
```
if ... then
  if ... then
  ...
  end if;

  if ... then
  ...
  end if;
end if;
```
- I rearanged my logic to avoid sequential if statements and only have nested if statements.
- This change allowed my counter to work correctly, starting at 0ns.
- I think it is due to the fact that statements within a process executed sequentially and I needed those statements to be executed concurrently.
