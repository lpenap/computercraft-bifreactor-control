-- ComputerCraft BigReactors Control installer. Bootstrapped by https://pastebin.com/3W2G3Vc9

local tree = select(1,...)
if not tree then
	tree = 'master'
end
local repo = 'lpenap/computercraft-bigreactor-control'

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

local function moveFiles()
	fs.delete('reactorcontrol')
	fs.delete('startup')
	fs.move('bigreactor-control.rom/lolmer_bigreactor_monitor_prog.lua', 'reactorcontrol')
	fs.move('bigreactor-control.rom/lolmer_bigreactor_startup.lua', 'startup')
end

-- install the FILES for control program and startup

local function doInstall()
	print ("Fetching BigReactor control program...")
	print ("Using repo: " .. REPO_BASE)
	local isDownloadOk = true
	for key, path in pairs(FILES) do
		local try = 0
		local status, response = request(path)
		print ("  Fetching " .. path)
		while status ~= 200 and try <= 3 do
			status, response = request(path)
			try = try + 1
		end
		if status then
			print ("    OK")
			makeFile(path, response)
		else
			isDownloadOk = false
			print (('Unable to download %s'):format(path))
			fs.delete('bigreactor-control.rom')
			fs.delete('reactorcontrol')
			fs.delete('startup')
			break
		end
	end
	rewriteDofiles()
	if isDownloadOk then
		moveFiles()
		print("BigReactors Control Program installed!")
		print("")
		print("Going to reboot the computer in 5 seconds...")
		os.sleep(5)
		os.reboot()
	else
		print("There was a problem installing the files.")
	end
end


doInstall()
