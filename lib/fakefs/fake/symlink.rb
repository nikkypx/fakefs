module FakeFS
  class FakeSymlink
    attr_accessor :name, :target, :parent

    def initialize(target)
      @target = target
    end

    def inspect
      "symlink(#{name} -> #{target.split('/').last})"
    end

    def entry
      FileSystem.find(target)
    end

    def delete
      parent.delete(self)
    end

    def to_s
      File.join(parent.to_s, name)
    end

    def respond_to?(*params)
      entry.respond_to?(*params)
    end

  private

    def method_missing(*args, &block)
      entry.send(*args, &block)
    end
  end
end
