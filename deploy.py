import subprocess

cmds = ["flutter clean", "flutter build web", "firebase deploy"]
for cmd in cmds:
    print(f"\n\n\n>>> {cmd}")
    subprocess.run(cmd, shell=True)
