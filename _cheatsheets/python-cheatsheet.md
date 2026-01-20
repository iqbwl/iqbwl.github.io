---
layout: cheatsheet
title: Python Command Cheatsheet
description: Python is a high-level, general-purpose programming language.
---


Python is a high-level, general-purpose programming language.


## Basics

### Data Types
```python
# Numbers
x = 5                    # int
y = 3.14                 # float
z = 1 + 2j               # complex

# Strings
s = "Hello"
s = 'World'
s = """Multi
line"""

# Boolean
b = True
b = False

# None
n = None
```

### Variables
```python
x = 10
x, y = 5, 10             # Multiple assignment
x, y = y, x              # Swap
```

### Operators
```python
# Arithmetic
+ - * / // % **

# Comparison
== != < > <= >=

# Logical
and or not

# Identity
is is not

# Membership
in not in
```

## Data Structures

### Lists
```python
lst = [1, 2, 3]
lst.append(4)            # Add to end
lst.insert(0, 0)         # Insert at index
lst.remove(2)            # Remove value
lst.pop()                # Remove last
lst.pop(0)               # Remove at index
lst.sort()               # Sort in place
sorted(lst)              # Return sorted
lst.reverse()            # Reverse
len(lst)                 # Length
lst[0]                   # Access
lst[-1]                  # Last element
lst[1:3]                 # Slice
lst[::-1]                # Reverse
```

### Tuples
```python
t = (1, 2, 3)
t = 1, 2, 3              # Without parentheses
t[0]                     # Access
# Tuples are immutable
```

### Dictionaries
```python
d = {'key': 'value'}
d['key']                 # Access
d.get('key', default)    # Safe access
d['new'] = 'value'       # Add/update
del d['key']             # Delete
d.keys()                 # All keys
d.values()               # All values
d.items()                # Key-value pairs
'key' in d               # Check existence
```

### Sets
```python
s = {1, 2, 3}
s.add(4)                 # Add element
s.remove(2)              # Remove (error if not exists)
s.discard(2)             # Remove (no error)
s1 | s2                  # Union
s1 & s2                  # Intersection
s1 - s2                  # Difference
```

## Control Flow

### If Statements
```python
if condition:
    pass
elif condition:
    pass
else:
    pass

# Ternary
x = a if condition else b
```

### Loops
```python
# For loop
for item in iterable:
    print(item)

for i in range(10):
    print(i)

for i, item in enumerate(lst):
    print(i, item)

# While loop
while condition:
    pass

# Break and continue
break
continue
```

### List Comprehension
```python
[x*2 for x in range(10)]
[x for x in range(10) if x % 2 == 0]
{x: x*2 for x in range(5)}  # Dict comprehension
{x*2 for x in range(10)}    # Set comprehension
```

## Functions

### Function Definition
```python
def function_name(param1, param2):
    return param1 + param2

# Default arguments
def func(a, b=10):
    return a + b

# Variable arguments
def func(*args, **kwargs):
    pass

# Lambda
lambda x: x * 2
```

### Decorators
```python
@decorator
def function():
    pass

# Common decorators
@staticmethod
@classmethod
@property
```

## Classes

### Class Definition
```python
class MyClass:
    def __init__(self, value):
        self.value = value
    
    def method(self):
        return self.value

obj = MyClass(10)
obj.method()
```

### Inheritance
```python
class Child(Parent):
    def __init__(self):
        super().__init__()
```

## File Operations

### Read/Write Files
```python
# Read
with open('file.txt', 'r') as f:
    content = f.read()
    lines = f.readlines()
    for line in f:
        print(line)

# Write
with open('file.txt', 'w') as f:
    f.write('text')
    f.writelines(['line1\n', 'line2\n'])

# Append
with open('file.txt', 'a') as f:
    f.write('more text')
```

## Modules

### Import
```python
import module
from module import function
from module import *
import module as alias
```

### Common Modules
```python
import os
import sys
import json
import datetime
import re
import random
import math
```

## String Methods

### Common Operations
```python
s.lower()
s.upper()
s.strip()
s.split(',')
s.replace('old', 'new')
s.startswith('prefix')
s.endswith('suffix')
s.find('substring')
s.count('char')
','.join(list)
f"Hello {name}"          # f-string
```

## List Methods

### Common Operations
```python
lst.append(x)
lst.extend([1,2,3])
lst.insert(i, x)
lst.remove(x)
lst.pop(i)
lst.clear()
lst.index(x)
lst.count(x)
lst.sort()
lst.reverse()
lst.copy()
```

## Exception Handling

### Try-Except
```python
try:
    # code
except Exception as e:
    print(e)
except (TypeError, ValueError):
    pass
else:
    # if no exception
finally:
    # always execute

# Raise exception
raise ValueError("message")
```

## Virtual Environment

### venv
```bash
python -m venv venv
source venv/bin/activate     # Linux/Mac
venv\Scripts\activate        # Windows
deactivate
```

### pip
```bash
pip install package
pip install -r requirements.txt
pip freeze > requirements.txt
pip list
pip uninstall package
```

## Quick Reference

| Operation | Syntax |
|-----------|--------|
| Print | `print(x)` |
| Input | `input("prompt")` |
| Type | `type(x)` |
| Length | `len(x)` |
| Range | `range(10)` |
| Enumerate | `enumerate(lst)` |
| Zip | `zip(lst1, lst2)` |
| Map | `map(func, lst)` |
| Filter | `filter(func, lst)` |
| Sum | `sum(lst)` |
| Min/Max | `min(lst)`, `max(lst)` |
| Sorted | `sorted(lst)` |

## Best Practices

1. **Follow PEP 8** style guide
2. **Use virtual environments**
3. **Write docstrings**
4. **Use list comprehensions** when appropriate
5. **Handle exceptions** properly
6. **Use context managers** (with statement)
7. **Avoid global variables**
8. **Use meaningful names**
9. **Keep functions small**
10. **Test your code**

## Resources

- Official Documentation: https://docs.python.org/
- PEP 8 Style Guide: https://pep8.org/
- Python Tutorial: https://docs.python.org/3/tutorial/
- Real Python: https://realpython.com/
