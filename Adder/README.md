# ADDER

The basic blocks of all adder are the [Half adder](# HALF ADDER) and then [Full Adder](#FULL ADDER)

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

