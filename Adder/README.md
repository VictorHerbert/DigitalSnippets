# ADDER

The basic blocks of all adder are the [Half adder](### HALF ADDER) and then Full Adder. Indeed, there are the only components needed to build the simplest architecture we can think about

![Basic architecture of an adder](http://cdn.differencebetween.net/wp-content/uploads/2018/04/Difference-Between-Half-Adder-and-Full-Adder.jpg)

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

