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