# codeprimate's .pryrc

## Load AwesomePrint
begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts "=> #{ap value}" }
rescue
  puts "=> Unable to load awesome_print"
end
## End Load AwesomePrint

## Load Rails helpers
rails = File.join Dir.getwd, 'config', 'environment.rb'
if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
    puts "*** Loaded Rails v2 Environment (from .pryrc)"
  elsif Rails.version[0..0] == "3"
    require 'rails/console/app'
    require 'rails/console/helpers'
    puts "*** Loaded Rails v3 Environment (from .pryrc)"
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
  end
end
## End Load Rails Helpers
