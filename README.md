# MÖCS beta
MÖCS is a CSS-Inspired (even though it looks more like JSON) data format designed to be easy to use for Lua.
## Example:
```css
$ hehe, i'm a comment!

$<
    hohoho, im absolutely
    multilined, babe!
>

WhatIsLove?: "baby dont hurt me";
Download:    99.9%;

@Player: {
    name: "Darltrash"; 
    x: 20;
    y: 800;
    Stats: {
	    Magic: 74%;
	    Health: 99;
    }
}

Version: {
    min: "1.2.5";
    max: "1.16.3";
}
```
Transpiles into:
```lua
{
	["WhatIsLove?"]="baby dont hurt me",
	["Download"]=0.999,
	["@Player"]={
		["name"]="Darltrash",
		["x"]=20,
		["y"]=800,
		["Stats"]={
			["Magic"]=0.74,
			["Health"]=99
		}
	},
	["Version"]={
		["min"]="1.2.5",
		["max"]="1.16.3"
	}
}
```
## How do I install and use this?
1. Download `mocs.lua`
2. Add it into your project folder
3. Require it. (ex: `parseMocs = require 'mocs'`)
4. Use it. (ex: `output = parseMocs(input)`)

## Why should I use this?
It's "simple" and "fast", but it really sucks at this point of development. For now it's literally reskinned Lua

## Roadmap:

 - [x] Basic syntax
	 - [x] Variable declaration
	 - [x] Object/Table declaration
	 - [x] Comments
	     - [x] Multilined Comments
	 - [x] Percents
	 - [ ] "Index-less" tables
 - [ ] Colors (Hex, RGBA, HSL, etc)
 - [ ] Function calls
 - [ ] Flags 
 - [ ] Standalone "executable"

## License:
> ZLIB License. Copyright (c) 2020 Nelson "darltrash" Lopez. 
> MÖCS: A CSS-inspired data format for Lua.
> 
> This software is provided 'as-is', without any express or implied
> warranty. In no event will the authors be held liable for any damages
> arising from the use of this software. Permission is granted to anyone
> to use this software for any purpose, including commercial
> applications, and to alter it and redistribute it freely, subject to
> the following restrictions:
> 
> 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this
> software in a product, an acknowledgment in the product documentation
> would be appreciated but is not required.
> 
> 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
> 
> 3. This notice may not be removed or altered from any source distribution.
