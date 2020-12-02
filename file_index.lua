function download(file, url)
    data = http.get(url).readAll()
    if not data then
          error("Could not connect to website")
    end
    file = fs.open(file, "w")
    file.write(data)
    file.close()
end

function check_delete(file)
    if fs.exists(file) then
        fs.delete(file)
    end
end

print("Redownloading program files")

check_delete("quarry")
download("quarry", "https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/quarry.lua")

check_delete("test")
download("test", "https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/test.lua")

check_delete("turtleapi")
download("turtleapi", "https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/turtleapi.lua")

check_delete("sorterapi")
download("sorterapi", "https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/sorterapi.lua")

print("Download Complete")

