for dir <- dirs,
    file <- File.ls!(dir)
    path = Path.join(dir, file),
    File.regular?(path) do
      File.stat!(path).size
    end
