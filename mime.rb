# Mime Base program
#
# I'll have to work on getting the library done. First some
# experimentation in IRB

# Begin recording a new Macro
def record(macro_name)
  commands = ""
  stop = false
  
  puts "Recording Mime #{mime_name} - Type 'stop' to end recording"

  until stop
    print "Mime #{macro_name}> "
    cmd = gets

    if cmd =~ /stop/
      stop = true
      break
    end

    commands << cmd + "\n"

    # Execute command, print results
    puts `#{cmd}`
  end

  File.open("#{macro_name}.mime", 'w'){ |f| f.write(commands) }
end

# Run a Macro
def run(macro_name)
  macro = File.open("#{macro_name}.mime",'r')

  macro.each_line{ |cmd| puts `#{cmd}` unless cmd =~ /^$/ }
end

# Generate Documentation based on the specified Mime file
# 
# Will eventually need to have exporting options for rendering
# as different formats such as MD or TXT
def document
end

# Merge the contents of two Macros and make a new one based on
# them
def merge
end

def delete(mime_name)
  File.delete("#{macro_name}.mime")
end

function = ARGV.shift
name = ARGV.shift

eval "#{function}('#{name}')"
