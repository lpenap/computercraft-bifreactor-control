-- Bootstrapped Installer for my forked version of Computercraft Big Reactors Control Program
-- https://github.com/lpenap/computercraft-bigreactor-control
--
-- This code is intended to be executed from pastebin.
--
-- The official repo doesn't have this bootstraped installation procedure yet:
-- https://github.com/sandalle/minecraft_bigreactor_control
--
-- Install (from an advanced computer):
-- pastebin run 3W2G3Vc9
-- OR
-- pastegin run 3W2G3Vc9 <branch>
-- Where:
--   <branch> Remote branch to use (i.e: develop, master, etc)
--            Defaults to master
 
local tree = select(1,...)
if not tree then
  tree = 'master'
end
print ("Bootstrapped installer for Big Reactors Control Program")
print ("Going to fetch installer from " .. tree .. " tree")
local url = ('https://raw.githubusercontent.com/lpenap/computercraft-bigreactor-control/%s'):format(tree)
local response = http.get(url..'/install.lua').readAll()
if response == nil then
  print ("Error while fetching installer from github")
else
  print ("Executing installer...")
  loadstring(response)()
end