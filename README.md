# CatalystAppleScript

Trivial demonstration showing how to build support for AppleScript into a Catalyst app. Showcases multiple commands and variables that can be set/get, and passed arguments.

Prerequisites checklist:
- Add NSAppleScriptEnabled to Info.plist
- Add OSAScriptingDefinition to Info.plist and point it to your scripting definitions file
- Craft a scripting definitions file (sdef). Note that scriptable variables have unique codes, types and access control r/rw
- Define NSScriptCommand in your ObjC bridging header so that Swift can see it to subclass it

### Screenshot

![](https://hccdata.s3.us-east-1.amazonaws.com/gh_catalyst_applescript.jpg)
