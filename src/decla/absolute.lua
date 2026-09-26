local sys_engine = {}

local function run_cmd(cmd)
	local handle = io.popen(cmd .. " 2>&1; echo '|||'$?")
	local result = handle:read("*a")
	handle:close()

	local output, exit_code = result:match("(.*)|||(%d+)\n")
	return tonumber(exit_code) == 0, output
end

local function is_package_installed(pkg)

	local success, _ = run_cmd("/usr/bin/pacman -Qi " .. pkg)
	return success
end

local function is_service_enabled(service)
	local success, _ = run_cmd("systemd is-enabled " .. service)
	return success
end

function sys_engine.apply_packages(desired_packages)
	print("[...] Enforcing packages")
	for _, pkg in ipairs(desired_packages) do
		if is_package_installed(pkg) then
			print("[OK, BUT] " .. pkg .. " is already installed.")
		else
			print("[+] Installing package " .. pkg .. "...")
			local success, err = run_cmd("/usr/bin/pacman -Sy --noconfirm " .. pkg)
			if not success then
				print("[ERROR] Failed to install " .. pkg .. "with error code: " .. tostring(err))
			end
		end
	end
end

function sys_engine.apply_services(desired_services)
	print("[...] Enforcing services")
	for services, state in pairs(desired_services) do
		local is_enabled = is_service_enabled(service)

		if state == "enabled" and not is_enabled then
			print("[*] Enabling service " .. service .. "...")
			run_cmd("systemctl enable --now " .. service)
		elseif state == "disabled" and is_enabled then
			print("[*] Disabling service " .. service .. "...")
			run_cmd("systemctl disable --now" .. service)
		else
			print("[OK, BUT] Service '" .. service .. "'is already " .. state .. ".")

		end
	end
end

return sys_engine
