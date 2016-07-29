# Konami
A library to add Konami like cheatcodes to Love2d

### Usage
```
local Konami = require "konami"
Konami.newCode({"up", "down", "left", "right"}, function() print("Goodjob friend!") end)
Konami.newCode({"up", "up", "down", "down", "left", "right", "left", "right", "b", "a"}, function() print("What is love?") end)

function love.update(dt)
	Konami.update(dt)
end

function love.keypressed(key)
	Konami.keypressed(key)
end
```

### API
``Konami.newCode(table, function)``
Adds a new cheatcode. Executes the function when entered.

``table = Konami.getCodes()``
Returns a tree of all the codes. (More info on this at the bottom of the Readme)

``table = Konami.getLog()``
Returns the current entered code.

``int = Konami.getTimeLeft()``
Returns the timeleft before the entered code resets.

``Konami.setWaitTime(int)``
Sets the default wait time before a entered code resets. (Default 0.5)

### Code tree
The .getCodes function returns a tree of all the codes, this tree's layout is like this:
```
{
	"up" = {
		codes = {
			"down" = {
				codes = {}
				functions = {
					[1] = function() print("UP - DOWN") end
				}
			},
			"up" = {
				codes = {}
				functions = {
					[1] = function() print("UP - UP") end
				}
			}
		},
		functions = {
		},
	"b" = {
		codes = {
			"a" = {
				codes = {},
				functions = {
					[1] = function() print("B - A") end
				}
			}
		},
		functions = {}
	}
}
```
