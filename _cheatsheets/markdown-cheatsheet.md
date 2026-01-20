---
layout: cheatsheet
title: Markdown Syntax Cheatsheet
description: Markdown is a lightweight markup language with plain text formatting syntax.
---


Markdown is a lightweight markup language with plain text formatting syntax.


## Headers

### Syntax
```markdown
# H1 Header
## H2 Header
### H3 Header
#### H4 Header
##### H5 Header
###### H6 Header

Alternative H1
==============

Alternative H2
--------------
```

## Text Formatting

### Basic Formatting
```markdown
**Bold text**
__Bold text__

*Italic text*
_Italic text_

***Bold and italic***
___Bold and italic___

~~Strikethrough~~

`Inline code`

> Blockquote
> Multiple lines
> in blockquote
```

### Result
**Bold text**, *Italic text*, ***Bold and italic***, ~~Strikethrough~~, `Inline code`

## Lists

### Unordered Lists
```markdown
- Item 1
- Item 2
  - Nested item 2.1
  - Nested item 2.2
- Item 3

* Alternative syntax
* Using asterisks

+ Or plus signs
+ Also works
```

### Ordered Lists
```markdown
1. First item
2. Second item
   1. Nested item 2.1
   2. Nested item 2.2
3. Third item

1. Numbers auto-increment
1. Even if you use 1
1. For all items
```

### Task Lists
```markdown
- [x] Completed task
- [ ] Incomplete task
- [ ] Another task
```

## Links

### Link Syntax
```markdown
[Link text](https://example.com)
[Link with title](https://example.com "Title on hover")

[Reference link][ref]
[ref]: https://example.com

<https://auto-linked-url.com>
<email@example.com>
```

### Internal Links
```markdown
[Link to header](#header-name)
[Link to section](#text-formatting)
```

## Images

### Image Syntax
```markdown
![Alt text](image.jpg)
![Alt text](image.jpg "Image title")

![Reference image][img-ref]
[img-ref]: image.jpg

[![Image link](image.jpg)](https://example.com)
```

### Image with Size (HTML)
```html
<img src="image.jpg" alt="Alt text" width="200" height="100">
```

## Code

### Inline Code
```markdown
Use `backticks` for inline code
```

### Code Blocks
````markdown
```
Basic code block
No syntax highlighting
```

```javascript
// JavaScript code block
function hello() {
  console.log("Hello, World!");
}
```

```python
# Python code block
def hello():
    print("Hello, World!")
```
````

### Indented Code Block
```markdown
    Indent with 4 spaces
    for code block
    (less common)
```

## Tables

### Basic Table
```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Cell 4   | Cell 5   | Cell 6   |
```

### Aligned Tables
```markdown
| Left | Center | Right |
|:-----|:------:|------:|
| L1   | C1     | R1    |
| L2   | C2     | R2    |
```

### Result
| Left | Center | Right |
|:-----|:------:|------:|
| L1   | C1     | R1    |
| L2   | C2     | R2    |

## Horizontal Rules

### Syntax
```markdown
