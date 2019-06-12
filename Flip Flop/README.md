# Latches and Flip Flops

Regarding knowledges about digital electronics, Latches and Flip Flops are pretty much the same component, what differs them is the fact that Flip flop only changes its outputs on the Clock falling (or rising), when the latch don't even has need for this input.

## D Type

Using Latch

```vhdl
q <=
  d when (clk = '1')
  else q;
```
Using FlipFlop

```vhdl
process(clk)
begin
	if(falling_edge(clk)) then
		q <= d;
	end if;
end process;
```

# Further Reading
