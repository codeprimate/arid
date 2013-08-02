# codeprimate's .pryrc

## Load AwesomePrint
begin
  require 'awesome_print' 
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
  puts "*** Loaded Awesome Print (from .pryrc)"
rescue LoadError => err
  puts '! Could not load awesome_print'
end
## End Load AwesomePrint

## Load Hirb
begin
  require 'hirb'
rescue LoadError
  puts '! Could not load hirb' unless defined?(Hirb)
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
  puts "*** Loaded Hirb (from .pryrc)"
end
## End Load Hirb

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
