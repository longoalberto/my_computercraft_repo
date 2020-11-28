print("Redownloading program files")

shell.run("rm quarry")
shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/quarry.lua quarry")

shell.run("rm test")
shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/test.lua test")

shell.run("rm api")
shell.run("mkdir api")
shell.run("cd api")
shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/api/turtle.lua turtle")
shell.run("cd ..")