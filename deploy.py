import subprocess

cmds = ["fvm flutter clean", "fvm flutter build web", "firebase deploy"]
for cmd in cmds:
    print(f"\n\n\n>>> {cmd}")
    subprocess.run(cmd, shell=True)
print(f"\n\n\n>>> MTrakcer New Version Got Deployed Successfully")