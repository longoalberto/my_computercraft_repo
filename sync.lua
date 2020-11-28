if arg[1] == "update" then
    shell.run("rm sync")
    shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/sync.lua sync")
    shell.run("sync")
else
    print("Redownloading program files")

    shell.run("rm quarry")
    shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/quarry.lua quarry")

    shell.run("rm api")
    shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/api.lua api")

    shell.run("rm test")
    shell.run("wget https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/test.lua test")

end