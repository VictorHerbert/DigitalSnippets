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

Instantieded in VHDL by

```vhdl
carry_out(0) <= cin;
	
addGen: for i in 0 to n-1 generate
  adds: full_adder port map(a(i), b(i), s(i), carry_out(i), carry_out(i+1));
end generate;

cout <= carry_out(n);  
```

