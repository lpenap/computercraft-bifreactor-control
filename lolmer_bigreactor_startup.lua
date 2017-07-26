--[[
	Programmer: Lolmer
	Last update: 2014-02-28
	Pastebin: http://pastebin.com/ZTMzRLez
	GitHub: https://github.com/sandalle/minecraft_bigreactor_control

	Description:
	This program controls a Big Reactors nuclear reactor
	in Minecraft with a Computercraft computer, using Computercraft's
	own wired modem connected to the reactors computer control port.

	Save this file as "startup" on your computer for it to auto-start on Computer boot.
	To easily get this file into your Computercraft Computer, run the following after right-clicking on your Computercraft computer (includes prompts).
	> rm startup
	> lua
	lua> shell.run("pastebin", "get", "ZTMzRLez", "startup")

	Requirements:
		Advanced Monitor size is X: 29, Y: 12 with a 3x2 size
		Computer or Advanced Computer
		Modems (not wireless) connecting each of the Computer to both the Advanced Monitor and Reactor Computer Port.

	This script is available from:
		http://pastebin.com/ZTMzRLez
		https://github.com/sandalle/minecraft_bigreactor_control
	And is used to control the following script:
		http://pastebin.com/fguScPBQ
	Other reactor control which I based my program on:
		http://pastebin.com/aMAu4X5J (ScatmanJohn)
		http://pastebin.com/HjUVNDau (version ScatmanJohn based his on)
	A simpler Big Reactor control is available from:
		http://pastebin.com/tFkhQLYn (IronClaymore)

	Advanced Monitor size is X: 29, Y: 12 with a 3x2 size
]]--
os.setComputerLabel("ReactorControl")

-- Remove any prior, possibly old, versions of "reactorcontrol"
-- shell.run("rm", "reactorcontrol")
-- Download http://pastebin.com/fguScPBQ and name "reactorcontrol"
-- shell.run("pastebin", "get", "fguScPBQ", "reactorcontrol")

shell.run("reactorcontrol.lua")
