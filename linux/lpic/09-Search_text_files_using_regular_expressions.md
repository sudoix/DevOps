![24](../../assets/24-shell.png)

# Search text files using regular expressions

### Regular Expression

Regular expressions are used when we want to search for specify lines of text containing a particular pattern.Regex can be used in a variety of programs like grep, sed, vi, bash, rename and many more. Here we will use regex with grep command.

 A regex pattern uses a **regular expression engine** which translates those patterns.

Linux has two regular expression engines:

* The **Basic Regular Expression (BRE)** engine.
* The **Extended Regular Expression (ERE)** engine.

> There's a difference between basic and extended regular expressions.Some utilities is written to support only basic regular expressions (BRE)and other utilities are written to support extended regular expressions(ERE) as well.Most Linux programs work well with BRE engine specifications, With GNU grep, there is no difference in functionality.

## What makes up regular expressions

There are two types of characters to be found in regular expressions:

* literal characters
* metacharacters

**Literal characters** are standard characters that make up our strings. Every character in this sentence is a literal character. You could use a regular expression to search for each literal character in that string.

**Meta characters** are a different beast altogether; they are what give regular expressions their power. With meta characters, we can do much more than searching for a single character. Meta characters allow us to search for combinations of strings and much more. 

## grep

grep stands for **g**eneral **r**egular **e**xpression **p**arser**.** The grep filter searches a file for a particular pattern of characters, and displays all lines that contain that pattern.grep is a utility that can benefit a lot from regular expressions.

```
grep [options] pattern [files]
```

Lets see some examples:

| command                          | description            |
| -------------------------------- | ---------------------- |
| echo "linux is my os" \| grep l  | **l**inux is my os     |
| echo "linux is my os" \| grep i  | l**i**nux **i**s my os |

 **Concatenation**

 Concatenating two regular expressions creates a longer expression. 

| regex                                    | match                              |
| ---------------------------------------- | ---------------------------------- |
| echo "aa ab ba aaa bbb AB BA" \| grep a  | **aa a**b b**a** **aaa** bbb AB BA |
| echo "aa ab ba aaa bbb AB BA" \| grep ab | aa **ab** ba aaa bbb AB BA         |

```
Options Description
-c : This prints only a count of the lines that match a pattern
-h : Display the matched lines, but do not display the filenames.
-i : Ignores, case for matching
-l : Displays list of a filenames only.
-n : Display the matched lines and their line numbers.
-v : This prints out all the lines that do not matches the pattern
-e exp : Specifies expression with this option. Can use multiple times.
-f file : Takes patterns from file, one per line.
-E : Treats pattern as an extended regular expression (ERE)
-w : Match whole word
-o : Print only the matched parts of a matching line,
 with each such part on a separate output line.
```
Case-Insensitive Search

```
grep -i "pattern" filename
```
Search in Multiple Files

```
grep "pattern" file1 file2 file3
```

Display Line Numbers

```
grep -n "pattern" filename
```
Count the Number of Matches

```
grep -c "pattern" filename
```
Show Lines that Do Not Match

```
grep -v "pattern" filename
```

Recursive Search: Searches for "pattern" recursively in all files under the specified directory.

```
grep -r "pattern" directory/
```
Search for Whole Words

```
grep -w "pattern" filename
```
Show Lines Before/After/Context of the Match

```
grep -B 1 "pattern" filename  # Show one line before the match
grep -A 1 "pattern" filename  # Show one line after the match
grep -C 1 "pattern" filename  # Show one line before and after the match
```

#### egrep and fgrep

egrep and fgrep are variations of the grep command in Unix and Linux, each with its unique functionality.

##### egrep (Extended grep)

egrep is used for patterns that include extended regular expressions (ERE). It supports special characters that are not available in basic grep, like +, ?, and |. Here's an example:

```
egrep "(pattern1|pattern2)" filename
```
This command searches for lines in "filename" that contain either "pattern1" or "pattern2". The | is a logical OR operator in extended regular expressions.

Search for Lines Starting with a Specific Word

```
egrep "^start" filename
```

Search for Lines Ending with a Specific Word
```
egrep "end$" filename
```
Search for Lines with Repeated Words

```
egrep "(word)+ " filename
```

##### fgrep (Fixed-string grep)
fgrep is used for searching fixed strings rather than regular expressions. It's useful when your pattern includes characters that are usually interpreted as special regular expression symbols but you want them treated as literal characters. Here's an example:

```
fgrep "pattern.*" filename
```
Search for a string in files within a directory

```
fgrep -r "string" directory/
```
Search for a string and display the surrounding lines:

```
fgrep -A 2 -B 1 "search_string" file.txt
```



### Extended Regular Expressions

 **Repetition**

* The **\*  ** means preceding item will be matched **0** **or more** times.
* The **+** means preceding item will be matched **1 or more** times.
* The **?** means preceding item will be matched, **0 or 1** time.

{% hint style="info" %}
#### Globbing and Regex: So Similar, So Different

 Beginners sometimes tend to confuse **wildcards**(globbing) with **regular expressions** when using grep but they are not the same.\
 **Wildcards** are a feature provided by the shell to expand file names whereas** regular expressions** are a text filtering mechanism intended for use with utilities like grep, sed and  awk.
{% endhint %}

| Special Character | Meaning in Globs                   | Meaning in Regex                                            |
| ----------------- | ---------------------------------- | ----------------------------------------------------------- |
| **\***            | zero or more characters            | zero or more of the character it follows                    |
| **?**             | single occurrence of any character | zero or one of the character it follows but not more than 1 |
| **.**             | literal "." character              | any single character                                        |

In order to avoid any mistake while using  extended regular expressions, use `grep` with` -E` option, `-E`  treats pattern as an extended regular expression(ERE).

{% hint style="info" %}
**double quotes " " : **Also we need to put our extended regex between  double quotes, other wise it might be interpreted by shell and gives us different results. 
{% endhint %}

| regex                                           | match                              |
| ----------------------------------------------- | ---------------------------------- |
| echo "aa ab ba aaa bbb AB BA" \| grep -E "a\*b" | aa **ab** **b**a aaa** bbb **AB BA |
| echo "aa ab ba aaa bbb AB BA" \| grep -E  "a+b" | aa **ab** ba aaa bbb AB BA         |
| echo "aa ab ba aaa bbb AB BA" \| grep -E "a?b"  | aa **ab** **b**a aaa **bbb** AB BA |

This is a point where egrep comes to play:

{% hint style="success" %}