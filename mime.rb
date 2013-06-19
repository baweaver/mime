#!/usr/local/bin/ruby
# Mime Base program
#
# I'll have to work on getting the library done. First some
# experimentation in IRB

require 'github/markdown'

# Begin recording a new Macro
def record(macro_name)
  commands = ""
  stop = false
  
  puts "Recording Mime #{macro_name} - Type 'stop' to end recording"

  until stop
    print "Mime #{macro_name}> "
    cmd = gets

    if cmd =~ /stop/
      stop = true
      break
    end

    commands << cmd

    # Execute command, print results
    puts `#{cmd}` unless cmd =~ /^#/
  end

  File.open("#{macro_name}.mime", 'w'){ |f| f.write(commands) }
end

# Run a Macro
def run(macro_name)
  macro = File.open("#{macro_name}.mime",'r')

  macro.each_line do |cmd| 
    unless cmd =~ /^$/ || cmd =~ /^#/  
      puts `#{cmd}` unless cmd =~ /^$/
    end
  end
end

# Generate Documentation based on the specified Mime file
# 
# Will eventually need to have exporting options for rendering
# as different formats such as MD or TXT
def document(macro_name)
  macro = File.open("#{macro_name}.mime",'r')
  docs  = File.open("doc-#{macro_name}.html",'w')

  comment = true
  
  str = macro.each_line.inject("") do |str, line|
    if line =~ /^#/
      str << "\n" unless comment 
      comment = true
      str << line.gsub(/^# /,'')
    else
      str << "\n" if comment  
      comment = false
      str << "    #{line}"
    end
  end
  
  # I'll probably want to put a basic stylesheet in here later, you know,
  # to make it look a tad classier.

  # Insert the string into the docs
  docs.puts GitHub::Markdown.render(str)
end

# Merge the contents of two Macros and make a new one based on
# them
def merge
end

def delete(macro_name)
  File.delete("#{macro_name}.mime")
end

function = ARGV.shift
name = ARGV.shift

eval "#{function}('#{name}')"
