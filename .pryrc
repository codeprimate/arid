# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
Pry.plugins["doc"].activate!
Pry.plugins["coolline"].activate!
#Pry.plugins["state"].activate!
Pry.plugins["byebug"].activate!
Pry.plugins["stack_explorer"].activate!

# alias 'q' for 'exit'
Pry.config.commands.alias_command "q", "exit-all"

# Launch Pry with access to the entire Rails stack
rails = File.join(Dir.getwd, 'config', 'environment.rb')

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0].in?(['3', '4'])
    require 'rails/console/app'
    require 'rails/console/helpers'
  elsif Rails.version[0..0].in?(['5'])
    require 'rails/console/app'
    if defined?(Rails::ConsoleMethods)
      include Rails::ConsoleMethods
    else
      def reload!(print=true)
        puts "Reloading..." if print
        ActionDispatch::Reloader.cleanup!
        ActionDispatch::Reloader.prepare!
        true
      end
    end
  else
    warn "[WARN] cannot load Rails console commands"
  end

  # Rails' pry prompt
  env = ENV['RAILS_ENV'] || Rails.env
  rails_root = File.basename(Dir.pwd)

  rails_env_prompt = case env
    when 'development'
      '[DEV]'
    when 'production'
      '[PROD]'
    else
      "[#{env.upcase}]"
    end

  prompt = '%s %s %s:%s'
  Pry.config.prompt = [ proc { |obj, nest_level, *| "#{prompt}> " % [rails_root, rails_env_prompt, obj, nest_level] },
                        proc { |obj, nest_level, *| "#{prompt}* " % [rails_root, rails_env_prompt, obj, nest_level] } ]

  # sql for arbitrary SQL commands through the AR
  def sql(query)
    ActiveRecord::Base.connection.execute(query)
  end

  # set logging to screen
  Rails.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = Rails.logger

  # returns a collection of the methods that Rails added to the given class
  # http://lucapette.com/irb/rails-core-ext-and-irb/
  class Class
    def core_ext
      self.instance_methods.map {|m| [m, self.instance_method(m).source_location] }.select {|m| m[1] && m[1][0] =~/activesupport/}.map {|m| m[0]}.sort
    end
  end

  # local methods helper
  # http://rakeroutes.com/blog/customize-your-irb/
  class Object
    def local_methods
      case self.class
      when Class
        self.public_methods.sort - Object.public_methods
      when Module
        self.public_methods.sort - Module.public_methods
      else
        self.public_methods.sort - Object.new.public_methods
      end
    end
  end

  # Load 'awesome_print'
  begin
    require 'awesome_print'
    require 'awesome_print/ext/active_record'
    require 'awesome_print/ext/active_support'
    AwesomePrint.pry!
    Pry.config.print = proc { |output, value| output.puts "=> #{ap value}" }
    puts "*** Using awesome_print to inspect return values in pry (from .pryrc)"
  rescue LoadError => err
    puts "=> Unable to load awesome_print"
  end
end
