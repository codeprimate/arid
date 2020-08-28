# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = true
Pry.plugins["byebug"].activate!

# alias 'q' for 'exit'
Pry.config.commands.alias_command "q", "exit-all"

# Load 'amazing_print'
begin
  require 'amazing_print'
  AmazingPrint.pry!
  puts "*** Using amazing_print to inspect return values in pry (from ./.pryrc)"
rescue LoadError => err
  puts "=> Unable to load amazing_print"
end

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
  elsif Rails.version[0..0].in?(['5', '6'])
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

  #prompt = '%s %s %s:%s'
  #Pry.config.prompt = [ proc { |obj, nest_level, *| "#{prompt}> " % [rails_root, rails_env_prompt, obj, nest_level] },
                        #proc { |obj, nest_level, *| "#{prompt}* " % [rails_root, rails_env_prompt, obj, nest_level] } ]

  # [] acts as find()
  ActiveRecord::Base.instance_eval { alias :[] :find } if defined?(ActiveRecord)

  # Add Rails console helpers (like `reload!`) to pry
  if defined?(Rails::ConsoleMethods)
    extend Rails::ConsoleMethods
  end

  # sql for arbitrary SQL commands through the AR
  def sql(query)
    ActiveRecord::Base.connection.execute(query)
  end

  # set logging to screen
  Rails.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = Rails.logger

  # .details method for pretty printing ActiveRecord's objects attributes
  class Object
    def details
      if self.respond_to?(:attributes) and self.attributes.any?
        max = self.attributes.keys.sort_by { |k| k.size }.pop.size + 5
        puts
        self.attributes.keys.sort.each do |k|
          puts sprintf("%-#{max}.#{max}s%s", k, self.try(k))
        end
        puts
      end
    end
    alias :detailed :details
  end

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
end
