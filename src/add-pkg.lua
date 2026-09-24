local new_pkg = arg[1]

if not new_pkg or new_pkg == '' then os.exit(1) end

local config_path = "/etc/sinix/config.lua"

local config = dofile("/etc/sinix/config.lua")

config.packages = config.packages or {}

local exists = false

for _, pkg in ipairs(config.packages) do
	if pkg == new_pkg then
		exists = true
		break
	end
end

if not exists then
	table.insert(config.packages, new_pkg)

	local file = io.open(config_path, "w")
	file:write("return {\n")

	if config.hostname then file:write(string.format("	hostname = %q,\n", config.hostname)) end

	file:write("	packages = {\n")
	for _, pkg in ipairs(config.packages) do
		file:write(string.format("	%q,\n", pkg))
	end

	file:write("	},\n")

	if config.dotfiles then
		file:write("	dotfiles = {\n")
		for _, file_mod in ipairs(config.dotfiles) do
			file:write(string.format("	{ src = %q, dest = %q },\n", file_mod.src, file_mod.dest))
		end
		file:write("	}\n")
	end

	file:write("}\n")
	file:close()
end

