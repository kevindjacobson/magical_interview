class ConsoleLogger
  def self.quiet!
    @quiet = true
  end

  def self.quiet?
    !!@quiet
  end

  def self.no_colors!
    @no_colors = true
  end

  def self.no_colors?
    !!@no_colors
  end

  def self.info(msg)
    puts msg
  end

  def self.debug(msg)
    puts " ** #{msg}"
  end

  def self.new_line
    puts
  end

  def self.progress(msg)
    print "  * #{msg}" unless quiet?
    error = yield
    if error
      report_fail(msg.size)
      debug error
    else
      report_ok(msg.size)
    end
    return error
  end

  # Prints nice OK message at the end of line.
  def self.report_ok(wmsg)
    if quiet?
      print '.'
    else
      print ' ' * [(CONFIG.line_width - wmsg - 10), 0].max
      puts no_colors? ? '[   OK   ]' : "[   \e[0;32;1mOK\e[0m   ]"
    end
  end

  # Prints nice FAILED message at the end of line.
  def self.report_fail(wmsg)
    if quiet?
      print 'F'
    else
      print ' ' * [(CONFIG.line_width - wmsg - 10), 0].max
      puts no_colors? ? '[] FAILED ]' : "[ \e[0;31;1mFAILED\e[0m ]"
    end
  end
end
