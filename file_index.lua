function download(url, file)
    local data = http.get(url).readAll()
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

function wrapper(url, file)
    check_delete(file)
    download(url, file)
end

print("Redownloading program files")

wrapper("https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/quarry.lua", "quarry")
wrapper("https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/test.lua", "test")
wrapper("https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/api/turtleapi.lua", "turtleapi")

print("Download Complete")