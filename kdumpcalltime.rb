#!/usr/bin/env ruby
# frozen_string_literal: true

# https://stackoverflow.com/questions/895929/how-do-i-determine-the-standard-deviation-stddev-of-a-set-of-values
class WelfordStdDev
  def initialize
    @m = 0.0
    @s = 0.0
    @k = 1
  end

  def <<(val)
    tm = @m
    @m += (val - tm) / @k
    @s += (val - tm) * (val - @m)
    @k += 1
  end

  def stddev
    Math.sqrt(@s / (@k - 1))
  end
end

Event = Struct.new(:pidtid, :proc, :time, :type, :call)
CallAvg = Struct.new(:call, :min, :max, :total, :calls, :stddev)
Call = Struct.new(:call, :elapsed)

calls = Hash.new do |h, k|
  h[k] = CallAvg.new(k, Float::INFINITY, 0, 0, 0, WelfordStdDev.new)
end

last_calls = {}

file = ARGV.first || 'ktrace.out'

IO.popen(%w[kdump -HEnsf] + [file]) do |kdump|
  kdump.each_line do |event|
    bits = event.split(/\s+/, 7)
    _, pid, tid, process, time, type, call = *bits
    id = pid.to_i | (tid.to_i << 16)
    event = Event.new(id, process, time.to_f, type, call)

    case event.type
    when 'CALL'
      last_calls[id] = event
    when 'RET'
      next unless (last_call = last_calls[id])
      c = calls[event.call.scan(/\S+/).first]
      c.calls += 1
      elapsed = event.time - last_call.time
      c.total += elapsed
      c.max = elapsed if elapsed > c.max
      c.min = elapsed if elapsed < c.min
      c.stddev << elapsed
    end
  end
end

calls.sort_by { |x| x[1].total }.reverse_each do |r|
  c = r[1]
  printf(
    "%16.16s: %2.5fs %5d calls | Avg=%.5fs Max=%.5fs Min=%.5fs StdDev=%.5fs\n",
    c.call, c.total, c.calls, c.total / c.calls, c.max, c.min, c.stddev.stddev
  )
end
