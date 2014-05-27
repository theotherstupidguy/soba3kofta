module Soba3kofta 

  module Middleware 
    include Mushin::Domain::Middleware
  end

  module DSL 
    include Mushin::DSL
    def self.find activity_context, activity_statment
      Mushin::DSL.middlewares = []
      Mushin::DSL.contexts.each do |current_context|
	if activity_context == current_context.title
	  current_context.statments.each do |statment|
	    if activity_statment == statment.title
	      statment.activations.each do |middleware|
		Mushin::DSL.middlewares << middleware 
	      end
	    end
	  end
	end
      end
      Mushin::DSL.middlewares
    end
  end

  module Engine
    extend Mushin::Engine
    attr_accessor :middlewares, :stack
    def self.run domain_context, activity
      @@middlewares = GameOn::DSL.find domain_context, activity 
      p @middlewares
      @stack = Mushin::Middleware::Builder.new do
	@@middlewares.each do |middleware|
	  p "Mushin Logging: use #{middleware.name}, #{middleware.opts}, #{middleware.params}"
	  use middleware.name, middleware.opts, middleware.params
	end
      end
      @setup_middlewares.each do |setup_middleware|
	@stack.insert_before 0, setup_middleware 
      end
      @stack.call
    end
  end

  #module Env 
  class Env 
    extend Mushin::Env

    class << self
      def get id
	Soba3kofta::Persistence::DS.load id
      end

      def set id, &block 
	@id = id
	def on domain_context, &block
	  @domain_context = domain_context 
	  @activities = []  
	  def activity statment 
	    @activities += [statment]                                                                          
	  end
	  instance_eval(&block)
	end
	instance_eval(&block)

	Dir["./soba3kofta/*"].each {|file| load file }  

	Soba3kofta::Engine.setup [Object.const_get('Soba3kofta::Persistence::DS')]
	@activities.each do |activity| 
	  Soba3kofta::Engine.run @domain_context, activity   
	end
      end
    end
  end
end
