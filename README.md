Resque Dedup
============

A [Resque][rq] plugin. Until [Datagraph's][dg] patched version of Resque
is merged, you will need to use the `datagraph` branch of our [Resque
repository][dgrq]

If you want only one instance of a particular job to be enqueued at any
one time, extend it with this module.

For example:

    require 'resque/plugins/dedup'

    class DoSomeHeavyLifting
      extend Resque::Plugins::Dedup

      def self.perform(some_id)
        heavy_lifting
      end
    end

Only one instance of this job will be enqueued at any one time. The job is
identified by a `lock` key which is a combination of its name and the arguments
supplied to it.

If you want to define this key yourself, you can override the `lock` class method
in your subclass, e.g.

    class DoSomeHeavyLifting
      extend Resque::Plugins::Lock

      # Run only one at a time, regardless of some_id.
      def self.lock(some_id)
        "DoSomeHeavyLifting"
      end

      def self.perform(some_id)
        heavy_lifting
      end
    end

The above modification will ensure only one job of class
DoSomeHeavyLifting is enqueued at a time, regardless of the
some_id.

[rq]: http://github.com/defunkt/resque
[dg]: http://datagraph.org
[dgrq]: http://github.com/datagraph/resque
