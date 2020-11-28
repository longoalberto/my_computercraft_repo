print("Removing previous sync file")
shell.run("rm sync")

print("Redownloading program files")
shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/quarry.lua quarry")


