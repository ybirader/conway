module Conway
  class CLI
    def start(args)
      seed_path, generations = args
      puts File.read(seed_path)
    end
  end
end
