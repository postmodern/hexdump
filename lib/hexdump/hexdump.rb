require 'hexdump/dumper'

#
# Provides the {Hexdump.dump} method and can add hexdumping to other classes
# by including the {Hexdump} module.
#
#     class AbstractData
#     
#       include Hexdump
#       
#       def each_byte
#         # ...
#       end
#     
#     end
#     
#     data = AbstractData.new
#     data.hexdump
#
module Hexdump
  #
  # Hexdumps the given data.
  #
  # @param [#each_byte] data
  #   The data to be hexdumped.
  #
  # @param [:int8, :uint8, :char, :uchar, :byte, :int16, :int16_le, :int16_be, :int16_ne, :uint16, :uint16_le, :uint16_be, :uint16_ne, :short, :short_le, :short_be, :short_ne, :ushort, :ushort_le, :ushort_be, :ushort_ne, :int32, :int32_le, :int32_be, :int32_ne, :uint32, :uint32_le, :uint32_be, :uint32_ne, :int, :long, :long_le, :long_be, :long_ne, :uint, :ulong, :ulong_le, :ulong_be, :ulong_ne, :int64, :int64_le, :int64_be, :int64_ne, :uint64, :uint64_le, :uint64_be, :uint64_ne, :longlong, :longlong_le, :longlong_be, :longlong_ne, :ulonglong, :ulonglong_le, :ulonglong_be, :ulonglong_ne, :float, :float_le, :float_be, :float_ne, :double, :double_le, :double_be, :double_ne] type (:byte)
  #   The type to decode the data as.
  #
  # @param [Integer] columns (16)
  #   The number of bytes to dump for each line.
  #
  # @param [16, 10, 8, 2] base (16)
  #   The base to print bytes in.
  #
  # @param [#<<] output ($stdout)
  #   The output to print the hexdump to.
  #
  # @yield [index,numeric,printable]
  #   The given block will be passed the hexdump break-down of each
  #   segment.
  #
  # @yieldparam [Integer] index
  #   The index of the hexdumped segment.
  #
  # @yieldparam [Array<String>] numeric
  #   The numeric representation of the segment.
  #
  # @yieldparam [Array<String>] printable
  #   The printable representation of the segment.
  #
  # @return [nil]
  #
  # @raise [ArgumentError]
  #   The given data does not define the `#each_byte` method,
  #   the `:output` value does not support the `#<<` method or
  #   the `:base` value was unknown.
  #
  def self.dump(data, output: $stdout, **kwargs, &block)
    dumper = Dumper.new(**kwargs)

    if block then dumper.each(data,&block)
    else          dumper.dump(data,output)
    end

    return nil
  end
end
