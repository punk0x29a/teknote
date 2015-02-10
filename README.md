# TekNote

#### Summary:

TekNote is a small Lua script designed to render taking quick notes in LaTeX easy and affordable.
Its goal is help people with atrocious handwriting to have beautiful notes on their computers without being distracted.
Taking notes in plain LaTeX is hard and demanding. TekNote language is, by comparison, very simple.
It is great for taking notes on lectures, since there is a lot less rules to rememeber.
Furthermore, it allows one to write very lazy code without worrying about its viability.

TekNote language won't, of course, give one as much possibilities as plain LaTeX, and it is not designed to be this way. 
For serious purposes, like writing a book or a scientific paper, one still needs to learn real LaTeX.
TekNote gets really useful (and powerful) only when it comes to writing quick notes in a fast-paced evironment.

Script translates expression from TekNote micro-language into proper LaTeX code, ready to copy and paste into the renderer.
Because of this nature it's perfectly sane to embed real LaTeX into TekNote's expression, which is extremely useful when one needs some of its rich features. 

TekNote is designed to work with [ZIM](http://zim-wiki.org/) coupled with [Equation Editor Plugin](http://zim-wiki.org/manual/Plugins/Equation_Editor.html) and was thoroughly tested on it.

Script is still a little buggy, especially when it comes to automatic newlines addition in regard to some functions.
Altough it's nothing that couldn't be solved by double-tapping return key, it'll probably be looked into in the future.

#### Usage:

One needs lua52 to launch TekNote:

```
$ lua52 teknote.lua
```
where $ sign indicates command prompt.

Name in which Lua interpreter is named may vary from system to system, but it's usually `lua52` or just `lua`. 

By default TekNote launches in an interactive mode, but it's very *rudimentary*.
It's highly recommended to make separate function in, for example, ~/.bashrc :

```
function teknote()
{
            vim ~/.math_expression && lua52 ~/path/to/latexnote.lua < ~/.math_expression·
}
```
Where `~/path/to/latexnote.lua` must be replaced with TekNote's real location.
`~/.math_expression` must be a name of a real temporary file used for work.
`vim` may be replaced with a text editor of your choice. 

Such a function will 
+ Enter text editor, where one will edit temporary file
+ Redirect resulting file as input for TekNote 
TekNote will then give back results ready for copy and paste into the renderer.

#### Command Line Options:

See 

`$ lua52 teknote.lua --help` 

for a complete list.
It's good to read through it, because most of the functions have some redundant aliases or syntactic sugars worth knowing of. 

#### Basics:

TekNote expression consists of tokens separated by spaces. 
Separate text editor with a feature of showing hidden symbols is very useful to track them.

There are three types of special tokens:

`.` - Line containing only a sigle dot signals end of expression.

This peculiar type of EOF sign has proven itself to be useful when one made a terrible mistake and wanted to translate only a part of an expression with a later part left for debugging later on. 

Inserting line containing only `.` at the end of expression is mandatory. 

`##` - Double hash sign signals beggining of a comment. TekNote will ignore everything until it'll encounter corresponding `##`

`expr` or `{{` is used for embedding functions in other functions. See examples below for clarification. 
Both can be used interchangeably.

`end` or `}}` is used for ending functions scope. 
Both can be used interchangeably.

One does not need to end function scope if it's the last function in file. 
Similarly - if there are many such functions at a very end of expression one does not need to end them at all. 

#### Functions: 


##### Matrix: 

Matrix function is used for creating matrices. There are six types of them:

`matrix` - create plain matrix.
`(matrix` - create matrix with parentheses.
`{matrix` - create matrix with brackets.
`[matrix` - create matrix with square brackets.
`|matrix` - create matrix with vertical bar.
`||matrix` - create matrix with two vertical bars.

For example:

```
matrix a b c
d e f
g h i
.
```

gives 


```
\begin{matrix} a & b & c \\ d & e & f \\ g & h & i\end{matrix}
```

and, consequently 

![Matrix](https://github.com/punk0x29a/teknote/tree/master/images/simplematrix.png?raw=true "Simple Matrix")

For more complicated example:

```
||matrix alpha beta gamma 
RR ZZ CC 
{{ intl a b {{ sin pow 2 (x) }} }} {{ intl a b {{ sum 0 oo ( 1 / n ) }} end expr aleph sub 0 }}
```

will give


```
\begin{Vmatrix} \alpha  & \beta  & \gamma  \\ \mathbb{R} & \mathbb{Z} & \mathbb{C} \\ \: \int\limits_{a}^{b}\: \: \sin ^{2}\: (x)\: \:  & \: \int\limits_{a}^{b}\: \: \sum_{0}^{\infty }\: {{\: 1\: }\over{\: n\: }}\: \:  & \: \aleph _{0}\: \end{Vmatrix}
```

and, consequently

![Fancy Matrix](https://github.com/punk0x29a/teknote/tree/master/images/fancymatrix.png?raw=true "Fancy Matrix")


`amatrix` is a special type of matrix, because it features element numeration.
`amatrix` must be followed by a matrix type. 

```
amatrix matrix a 1 1 a 1 2 ... a 1 n 
a 2 1 a 2 2 ... a 2 n 
v... v... v... v...
a m 1 a m 2 ... a m n
```

gives 

```
\begin{matrix} a_{1,1} & a_{1,2} & \cdots  & a_{1,n} \\ a_{2,1} & a_{2,2} & \cdots  & a_{2,n} \\ \vdots  & \vdots  & \vdots  & \vdots  \\ a_{m,1} & a_{m,2} & \cdots  & a_{m,n}\end{matrix}
```

which renders to 

![Element numeration](https://github.com/punk0x29a/teknote/tree/master/images/numeratedmatrix.png?raw=true "Numerated Matrix")



##### Tabular:

`tabular` is used for making tables. It's a shorthand for an array environment.
Altough this function needs some attention in order to make it more viable, it's pretty useful even now. 

```
tabular phi {{ 0 pow o }} {{ 30 pow o }} {{ 45 pow o }} {{ 60 pow o }} {{ 90 pow o }}
{{ sin phi }} 0 {{ ( 1 / 2 ) }} {{ ( 1 / sqrt 2 ) }} {{ ( sqrt 3 / 2 ) }} 1 
{{ cos phi }} 1 {{ ( sqrt 3 / 2 ) }} {{ ( 1 / sqrt 2 ) }} {{ ( 1 / 2 ) }} 0 
.
```

gives 


```
\begin{array}{ c|c|c|c|c|c|c} \phi  & \: 0^{\circ }\:  & \: 30^{\circ }\:  & \: 45^{\circ }\:  & \: 60^{\circ }\:  & \: 90^{\circ }\:  \\ \hline \: \sin \: \phi \:  & 0 & \: {{\: 1\: }\over{\: 2\: }}\:  & \: {{\: 1\: }\over{\: \sqrt[]{2}\: }}\:  & \: {{\: \sqrt[]{3}\: }\over{\: 2\: }}\:  & 1 \\ \hline \: \cos \: \phi \:  & 1 & \: {{\: \sqrt[]{3}\: }\over{\: 2\: }}\:  & \: {{\: 1\: }\over{\: \sqrt[]{2}\: }}\:  & \: {{\: 1\: }\over{\: 2\: }}\:  & 0 \\ \hline \end{array} 

```

and, consequently

![Tabular](https://github.com/punk0x29a/teknote/tree/master/images/trigtabular.png?raw=true "Tabular for sin and cos")


##### Cases:

`cases` environment is useful when writing down, in.e., functions definitions:


```
f(x) = cases 1  if x < 0 
0   if x = 0 
-1  if x > 0
```

translates to 

```
f(x)\: =\: \begin{cases} 1\: \qquad if\: x\: <\: 0 \\ 0\qquad if\: x\: =\: 0 \\ -1\: \qquad if\: x\: >\: 0 \\ \end{cases}
```

that renders to:

![Cases](https://github.com/punk0x29a/teknote/tree/master/images/cases.png?raw=true "Cases Example")


##### Sub, Pow and Substack

These seem to be self-explanatory.

```
e pow {{ x pow 2 }} 
```

gives 

```
e^{\: x^{2}\: } 
```

that renders to 

![E](https://github.com/punk0x29a/teknote/tree/master/images/ex.png?raw=true "e to the power of x")

Similarly,

```
x sub 0 = 1
```

gives

```
x_{0}\: =\: 1
```

that renders to

![X](https://github.com/punk0x29a/teknote/tree/master/images/xzero.png?raw=true "Where function meets x-axis") 


Those can be combined: 

```
alpha sub beta pow gamma = gamma pow beta sub alpha
```

gives

```
\alpha _{\beta }^{\gamma }\: =\: \gamma ^{\beta }_{\alpha } 
```

that renders to

![Fancy](https://github.com/punk0x29a/teknote/tree/master/images/subpow.png?raw=true "Fancy example")


Example substack usage:

```
sum substack n=1
k=0 end oo n pow k
.
```

gives 

```
\sum_{_{\substack{n=1 \\ k=0}} }^{\infty }\: n^{k}
```

that renders to:

![Substack](https://github.com/punk0x29a/teknote/tree/master/images/substack.png?raw=true "Substack Example")


##### Limit (including Integral with limits), Binomial, Root, Sum, Product and Logarithm 

They all work pretty much the same. One needs to enter a and b factor, followed by an expression.
Here's a big example:


```
log 2 4 = 2 
root 3 27 = 3
() n k = binom n k
lim x oo ( x ^ 2  / x ^ 2 + 1 ) = 1
sum x=0 oo x = oo
prod x=0 -oo x = 0

```

translates to

```
\log_{2}{4}\: =\: 2 \\ \sqrt[3]{27}\: =\: 3 \\ \binom{ n}{k}\: = \binom{ n}{k} \\ \lim_{x\rightarrow \infty }\: {{\: x^{2}\: \: }\over{\: x^{2}\: +\: 1\: }}\: =\: 1 \\ \sum_{x=0}^{\infty }\: x\: =\: \infty  \\ \prod_{x=0}^{-\infty}\: x\: =\: 0 \\ 
```

which gives

![Big](https://github.com/punk0x29a/teknote/tree/master/images/bigexample.png?raw=true "Big Example")


##### Fractions and parentheses 

Single parentheses are translated into `{` and `}` signs respectively, and are invisible in final image. 
To pronounce parentheses, one must use `((` and `))` for left and right parentheses. 

Fractions are abbreviated as follows:

```
( x / (( x pow 2 + 1 )) pow 2 )
```

gives

```
{{\: x\: }\over{\: (\: x^{2}\: +\: 1\: )^{2}\: }} \\ 
```
that renders to

![Fraction](https://github.com/punk0x29a/teknote/tree/master/images/frac1.png?raw=true "Example Fraction")

Such a fraction must be bound by single parentheses in every case. 

As for continous fractions:


```
// a b + // c d + // e f + // g h
```

gives

```
\cfrac{a}{b+\cfrac{c}{d+\cfrac{e}{f+\cfrac{g}{h}}}}
```

that renders to:

![Cfrac](https://github.com/punk0x29a/teknote/tree/master/images/frac2.png?raw=true "Example Fraction")


If continous fraction is present in the middle of an expression, one must end it with `endfractions` token. 


##### Underbrace and Overbrace:

```
overbrace {{ underbrace x Re + underbrace i*y Im }} {{ Complex Number }}
```

gives 

```
\overbrace{\underbrace{x}_{\Re }\: +\underbrace{i*y}_{\Im }\: }^{\: Complex\: Number\: } \\ 
```

that renders to

![Braces](https://github.com/punk0x29a/teknote/tree/master/images/complex.png?raw=true "Complex Number")


##### Some set theory and math blackboard

Entering two same capital letters in a row gives back mathbb form:

```
Gamma = { forall x in RR : x > 1 }
```
gives
```
\Gamma \: =\: \{\: \forall \: x\: \in \: \mathbb{R}:\: x\: >\: 1\: \} 
```
that renders to

![Mathbb](https://github.com/punk0x29a/teknote/tree/master/images/set1.png?raw=true "Such a set...")

As for sets, there is a set form that automates sets declaration:

```
A = set a b c 

B = set c d e 

A set* B = set c end = (( A set+ B )) \ set a b d e 
.
```

gives 

```
A\: =\: \{a,b,c\} \\ B\: =\: \{c,d,e\} \\ A\: \cap \: B\: =\: \{c\}\: =\: (\: A\: \cup \: B\: )\: \setminus \: \{a,b,d,e\} \\ 
```

and, conclusively

![Set](https://github.com/punk0x29a/teknote/tree/master/images/set2.png?raw=true "Such a set...")


Most of set theory operators, such as arrows, are available in almost ascii-art, straightforward form:


```
A subset B == x in A => x in B
```

gives 

```
A\: \subset \: B\: \equiv \: x\: \in \: A\: \Rightarrow \: x\: \in \: B \\ 
```

that renders to

![Arrows](https://github.com/punk0x29a/teknote/tree/master/images/arrows.png?raw=true "Arrows...")


while less and more operators are presented as `>=` and `=<`


#### That's about it 

Have fun using my little script. 
For bug reports or questions please contact me at:
punk0x29a@gmail.com


