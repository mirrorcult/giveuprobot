# giveuprobot-mirrorcult

this is a fully working decompile of give up robot, with the GUR2 version of the flashpunk engine ported into it

this was done by:
- decompiling the gur swf
- replacing the engine with the modified one from https://github.com/mirrorcult/gur2rainer
- fixing whatever random errors (mostly graphics & spritemap related) until it compiled
- fixing whatever random visual errors from there

gameplay is verified to be accurate by using the TAS tooling from gur2rainer to test gur1 TAS files

`tas` branch contains more tas-specific code since the main goal of this project was to just port the gur2rainer TAS tools + test out backporting some gur2 mechanics