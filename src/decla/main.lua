local engine = dofile("/etc/sinix/src/absolute.lua")

local desired_state = dofile("/etc/sinix/config.lua")

print("Starting deployment...")
engine.apply_packages(desired_state.packages or {})
engine.apply_services(desired_state.services or {})
print("[SUCCESS] Done.")
