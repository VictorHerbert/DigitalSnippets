# CRC - Cyclic Redundancy Check
![](https://github.com/VictorHerbert/VHDLSnippets/blob/master/Images/CRC_image.png?raw=true)

#### Placing Xors in position
```vhdl
crcxor0_maker : if crc_pol(0) = '1' generate
	crc_in(0) <= crc_out(pol_size-2) xor serial;
end generate;

crc0_maker : if crc_pol(0) = '0' generate
	crc_in(0) <= serial;
end generate;

xors_maker : for i in 1 to pol_size-2 generate
	crcxor_i_maker : if crc_pol(i) = '1' generate
		crc_in(i) <= crc_out(pol_size-2) xor crc_out(i-1);
	end generate;
	crci_maker : if crc_pol(i) = '0' generate
		crc_in(i) <= crc_out(i-1);
	end generate;
end generate;
```

## Further reading

* [Online CRC calculator](https://asecuritysite.com/comms/crc_div)
* [Hardware build: CRC calculation](https://www.youtube.com/watch?v=sNkERQlK8j8&t=1261s)

