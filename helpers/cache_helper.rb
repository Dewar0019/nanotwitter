module Sinatra
  module CacheHelpers
    def cache(name, &block)
      if $redis1.exist?(name)
        @_out_buf << $redis1.read(name)
      else
        pos = @_out_buf.length
        temp = block.call
        $redis1.write(name, temp[pos..-1])
        temp
      end
    end
  end
end
