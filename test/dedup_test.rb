require 'test/unit'
require 'resque'
require 'resque/plugins/dedup'

class Job
  extend Resque::Plugins::Dedup
  @queue = :test

  def self.perform
    sleep 1
  end
end

class DedupTest < Test::Unit::TestCase
  def test_lint
    assert_nothing_raised do
      Resque::Plugin.lint(Resque::Plugins::Dedup)
    end
  end

  def test_dedup
    3.times { Resque.enqueue(Job) }
    assert_equal 1, Resque.size(:test)
    worker = Resque::Worker.new(:test)
    worker.process
    assert_equal 0, Resque.size(:test)
  end
end
