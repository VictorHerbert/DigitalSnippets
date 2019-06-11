# ADDER

The basic blocks of all adder are the Half adder and then Full Adder.

### HALF ADDER

```vhdl
s <= (a xor b);
cout <= (a and b);
```
### FULL ADDER

```vhdl
int_sig <= (a xor b);
s <= (cin xor int_sig);
cout <= (a and b) or (int_sig and cin);
```
## Ripple Carry Architecture

Half and Full adders are engough to build the simplest architecture we can think about, the Ripple Carry Adder Architecture in the way showed bellow

<p align="center">
  <img src="http://cdn.differencebetween.net/wp-content/uploads/2018/04/Difference-Between-Half-Adder-and-Full-Adder.jpg" alt="Logo"/>
</p>

instantiated in VHDL by

```vhdl
carry_out(0) <= cin;
	
addGen: for i in 0 to n-1 generate
  adds: full_adder port map(a(i), b(i), s(i), carry_out(i), carry_out(i+1));
end generate;

cout <= carry_out(n);  
```

## Look Ahead Carry Adder Architecture

Even the Ripple carry is simple to build and undestand, it displays a significant delay when it comes to sums of numbers with greater count of bits due to the amount of logic gates carry in bit passes through. Ir order to solve this issue, the first tought alternative was the Look Ahead Carry Adder Architecture

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/4-bit_carry_lookahead_adder.svg/1024px-4-bit_carry_lookahead_adder.svg.png" alt="Logo"/>
</p>


