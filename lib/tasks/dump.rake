desc "Converts a browscap file to another format"
task "browscapper:dump" do
  require File.join(File.dirname(__FILE__), %w{ lib browscapper })

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
