function download(file,url)
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

check_delete("file_index")
download("file_index", "https://raw.githubusercontent.com/longoalberto/my_computercraft_repo/main/file_index.lua")

shell.run("file_index")