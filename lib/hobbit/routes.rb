require 'hobbit'
require 'hobbit/routes/version'

module Hobbit
  class Base
    class << self
      %w(DELETE GET HEAD OPTIONS PATCH POST PUT).each do |verb|
        define_method(verb.downcase) { |path = '', &block| routes[verb] << Route.new(path, &block) }
      end
    end

    def _call(env)
      @env = env
      @request = self.class.settings[:request_class].new(@env)
      @response = self.class.settings[:response_class].new
      route = find_route
      if route
        route.call(self, @request, @response)
      else
        @response.status = 404
      end
      @response.finish
    end

    private

    def find_route
      self.class.routes[request.request_method].detect { |r| r.is?(request) }
    end
  end

  class Route
    attr_accessor :block, :compiled_path, :extra_params, :path

    def initialize(path, &block)
      @block = block
      @extra_params = []
      @path = path

      @compiled_path = @path.gsub(/:\w+/) do |match|
        @extra_params << match.gsub(':', '').to_sym
        '([^/?#]+)'
      end
      @compiled_path = /^#{compiled_path}$/
    end

    def is?(request)
      !!(@compiled_path =~ request.path_info)
    end

    # this is not rack compliant!
    def call(base, request, response)
      @compiled_path.match(request.path_info).captures.each_with_index do |value, index|
        param = @extra_params[index]
        request.params[param] = value
      end
      response.write base.instance_eval(&@block)
    end
  end
end
