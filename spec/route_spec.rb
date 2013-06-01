require 'minitest_helper'

describe Hobbit::Route do
  describe '#initialize' do
    it 'must initialize a Hobbit::Route instance' do
      proc = Proc.new { 'Hello Hobbit::Route' }
      r = Hobbit::Route.new '/', &proc

      r.block.call.must_equal 'Hello Hobbit::Route'
      r.compiled_path.must_be_instance_of Regexp
      r.extra_params.must_be_instance_of Array
      r.path.must_equal '/'
    end
  end

  describe '#is?' do
    let(:route) do
      proc = Proc.new { 'Hello Hobbit::Route' }
      Hobbit::Route.new '/', &proc
    end

    it 'must be false when a route does not match a request' do
      env = { 'PATH_INFO' => '/hello' }
      req = Rack::Request.new env

      route.is?(req).must_equal false
    end

    it 'must be true when a route matches a request' do
      env = { 'PATH_INFO' => '/' }
      req = Rack::Request.new env

      route.is?(req).must_equal true
    end
  end

  describe '#call' do
    it { skip '#call' }
  end
end