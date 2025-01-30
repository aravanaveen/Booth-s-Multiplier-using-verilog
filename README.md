#BOOTHS MULTIPLIER
Author - A.Naveen
Dept - VLSI & Electronics

Booth multiplier implements an 8-bit signed multiplication using Booth's algorithm, which reduces the number of required operations by encoding the multiplier. It consists of a Full Adder (fa) module for addition, an Invert (invert) module for bitwise negation, and Adder/Subtractor (Adder, Subtractor) modules to perform arithmetic operations. The booth_substep module executes each step of Booth's algorithm by selectively adding, subtracting, or shifting the partial results based on the Booth encoding conditions. The booth_multiplier module orchestrates eight iterative steps, where the multiplicand (b) and intermediate results (A and Q) are processed using the booth_substep module, progressively computing the 16-bit signed product (c). This design ensures efficient multiplication by minimizing the number of additions/subtractions through Booth's recoding.
