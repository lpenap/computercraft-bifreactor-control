-- ComputerCraft BigReactors Control installer. Bootstrapped by https://pastebin.com/3W2G3Vc9

local repo, tree = select(1,...)
if not tree then
	-- assume tree as the preferred argument.
	tree = repo or 'master'
end
if not repo then
	repo = 'lpenap/computercraft-bifreactor-control'
end

local REPO_BASE = ('https://raw.githubusercontent.com/%s/%s/'):format(repo, tree)

local FILES = {
	'lolmer_bigreactor_monitor_prog.lua',
	'lolmer_bigreactor_startup.lua'
}

local function request(url_path)
	local request = http.get(REPO_BASE..url_path)
	local status = request.getResponseCode()
	local response = request.readAll()
	request.close()
	return status, response
end

local function makeFile(file_path, data)
	local file = fs.open('bigreactor-control.rom/'..file_path,'w')
	file.write(data)
	file.close()
end

local function rewriteDofiles()
	for _, file in pairs(FILES) do
		local filename = ('bigreactor-control.rom/%s'):format(file)
		local r = fs.open(filename, 'r')
		local data = r.readAll()
		r.close()
		local w = fs.open(filename, 'w')
		data = data:gsub('dofile%("', 'dofile("bigreactor-control.rom/')
		w.write(data)
		w.close()
	end
end

-- install the FILES for control program and startup
for key, path in pairs(FILES) do
	local try = 0
	local status, response = request(path)
	while status ~= 200 and try <= 3 do
		status, response = request(path)
		try = try + 1
	end
	if status then
		makeFile(path, response)
	else
		printError(('Unable to download %s'):format(path))
		fs.delete('bigreactor-control.rom')
		fs.delete('bigreactor-control.lua')
		break
	end
end

rewriteDofiles()
fs.move('bigreactor-control.rom/lolmer_bigreactor_monitor_prog.lua', 'bigreactor-control.lua')
fs.move('bigreactor-control.rom/lolmer_bigreactor_startup.lua', 'startup')
print("BigReactors Control Program by lpenap installed!")
dofile('startup')