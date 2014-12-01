
desc "Converts a browscap file to the Marshal format"
task "browscapper:dump" do
  require 'browscapper'

  if !ENV['IN'] || !ENV['OUT']
    puts "Usage: IN=browscap OUT=browscap.dump"
    puts
    puts "Converts a browscap file to a ruby Marshal'd format. These files"
    puts "are much quicker to load than CSV or INI files."
    exit
  end

  Browscapper.load(ENV['IN'])
  File.open(ENV['OUT'], 'wb') do |fp|
    fp.write(Marshal.dump(Browscapper.entries))
  end
end

desc "Converts a browscap file to another format"
task "browscapper:convert" do
  require 'browscapper'

  if !ENV['IN'] || !ENV['OUT']
    puts "Usage: IN=browscap OUT=output.ext"
    puts
    puts "Converts a browscap file to another format. The output format"
    puts "is based on the output extension, which can be one of yml, yaml,"
    puts "csv, ini or dump. The \"dump\" extension uses the Marshal format."
    exit
  end

  Browscapper.load(ENV['IN'])

  case ENV['OUT']
    when /\.dump$/i
      File.open(ENV['OUT'], 'wb:BINARY') do |fp|
        fp.write(Marshal.dump(Browscapper.entries))
      end

    when /\.ya?ml$/i
      File.open(ENV['OUT'], 'wb:BINARY') do |fp|
        fp.write(YAML.dump(Browscaper.entries))
      end

    when /\.csv$/i
      Browscapper.load(ENV['IN'])
      Browscapper::CSVReader::CSV_ENGINE.open(ENV['OUT'], 'wb:BINARY') do |csv|
        keys = Browscapper.entries['DefaultProperties'].to_hash.keys
        csv << keys
        Browscapper.entries.each do |k, v|
          hash = v.to_hash

          csv << keys.collect { |kk|
            hash[kk]
          }
        end
      end
  end
end
