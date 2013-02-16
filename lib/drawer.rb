module Drawer
  def show_output!
    @show_output = true
  end

  def silence_output!
    @show_outptu = false
  end

  def showing_output?
    @show_output ||= false
  end

  private

  def draw(text, only_if_at_base = false)
    return unless showing_output?

    current_level = level
    return if only_if_at_base and current_level > 0

    current_level.times { print "  " }
    puts text
  end

  def level
    call_counts = -1
    caller.each do |call_line|
      call_counts += 1 if call_line =~ /`dynamically/ || call_line =~ /`block in dynamically/
    end
    call_counts
  end
end

