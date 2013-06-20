#!/usr/local/bin/ruby
#
# Mime
# ====
# A program for generating macros of standard bash sessions to
# aid in the process of automation, and cut out steps of 
# remembering how exactly you fixed that issue.
#
# Simply record yourself solving a problem, and Mime can document
# and run it back for you.
#
# Mime is a very simple and to the point program. Used correctly
# it can be a valuable asset and aid in getting things done. You
# don't need monolithic tools to do the simple stuff.
#
# Get things done without the overhead.
#
# Amusingly you can use Mime to document the mime program itself,
# and it will work assuming the right naming convention. That'll be
# something to fix later on.

# For exporting documentation
require 'github/markdown'

# Record
# ------
# Begin recording a new Macro, saved as name.mime
def record(macro_name)
  # Commands are stored in a string
  commands = ""
  
  puts "Recording Mime #{macro_name} - Type 'stop' to end recording"

  # Like Bash or any other shell, loop until told otherwise
  until 1 == 2 # Ok, so I need a better infinite loop, but this will work for now.
    # Prompt for a command
    print "Mime #{macro_name}> "
    cmd = gets
    
    # Stop interpreting and recording on stop
    break if cmd.eql?('stop')

    # Concatenate the command to the list
    commands << cmd

    # Execute command and print results unless it's a comment
    puts `#{cmd}` unless cmd =~ /^#/
  end

  # Write to the file
  File.open("#{macro_name}.mime", 'w'){ |f| f.write(commands) }
end

# Run
# ---
# Run a Macro
def run(macro_name)
  macro = File.open("#{macro_name}.mime",'r')

  macro.each_line do |cmd|
    # Don't output commands if it's a comment or blank line
    unless cmd =~ /^$/ || cmd =~ /^#/
      puts `#{cmd}`
    end
  end
end

# Document
# --------
# Generate Documentation from MD comments, export to HTML
def document(macro_name)
  macro = File.open("#{macro_name}.mime",'r')
  docs  = File.open("doc-#{macro_name}.html",'w')

  comment = true
  
  str = macro.each_line.inject("") do |str, line|
    # Interpret comments as markdown
    if line =~ /^#/
      str << "\n" unless comment 
      comment = true
      str << line.gsub(/^# /,'')
    # Interpret commands as pre/code blocks
    else
      str << "\n" if comment  
      comment = false
      str << "    #{line}"
    end
  end
  
  # I'll probably want to put a basic stylesheet in here later, you know,
  # to make it look a tad classier.

  # Render the document in MD and export to HTML
  docs.puts GitHub::Markdown.render(str)
end

# Merge
# -----
# Merge the contents of two or more Macros
def merge
end

# Delete
# ------
# Delete a Macro
def delete(macro_name)
  File.delete("#{macro_name}.mime")
end

# Arguments
# ---------
# Assign arguments from args
function = ARGV.shift
name = ARGV.shift

# Dispatcher
# ----------
# Instead of writing a long dispatcher method, just
# interpolate strings and evaluate them as Ruby code
# for a lot more flexibility and DRYness.
eval "#{function}('#{name}')"
