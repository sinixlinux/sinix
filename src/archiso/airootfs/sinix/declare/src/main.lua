local engine = dofile("/sinix/declare/src/absolute.lua")

local desired_state = dofile("/sinix/declare/config.lua")

print("Starting deployment...")
engine.apply_packages(desired_state.packages or {})
engine.apply_services(desired_state.services or {})
print("[SUCCESS] Done.")
