# Mime Base program
#
# I'll have to work on getting the library done. First some
# experimentation in IRB

# A tad hackish, yes, but gets the job done
$debug = false 

# Begin recording a new Macro
def record(macro_name)
  commands = ""
  stop = false

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

  puts "\n" + commands if $debug

  File.open("#{macro_name}.mime", 'w'){ |f| f.write(commands) }
end

# Run a Macro
def run(macro_name)
  macro = File.open("#{macro_name}.mime",'r')

  macro.each_line do |cmd|
    unless cmd =~ /^$/
      puts "cmd: " + cmd if $debug
      puts `#{cmd}`
    end
  end
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

# Edit the contents of the Mime, debating if I just want to export
# it to the default editor or make a custom editor for this one.
def edit
end

# Delete a Macro. Confirmation? We're in Unix. Ain't nobody got time
# for that!
def delete
end

name = ARGV.shift

puts name if $debug

record(name)
run(name)
