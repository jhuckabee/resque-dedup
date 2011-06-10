module Resque
  module Plugins
    module Dedup
      VERSION = "0.0.1"

      # Override in your job to control the lock key. It is
      # passed the same arguments as `perform`, that is, your job's
      # payload.
      def lock(*args)
        "lock:#{name}-#{args.to_s}"
      end

      # Convenience method, not used internally.
      def locked?(*args)
        Resque.redis.exists(lock(*args))
      end
      
      def before_enqueue_lock(*args)
        return false unless Resque.redis.setnx(lock(*args), true)
        true
      end

      # Cleanup the key after the job is done.
      def around_perform_lock(*args)
        begin
          yield
        ensure
          # Always clear the lock when we're done, even if there is an
          # error.
          Resque.redis.del(lock(*args))
        end
      end
    end
  end
end
