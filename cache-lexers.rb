
print("about to require")
require File.join(File.dirname(__FILE__), '/lib/pygments.rb')

print("about to Marshal")
# Simple marshalling
serialized_lexers = Marshal.dump(Pygments.lexers!)

print("about to write to a file")
# Write to a file
File.open("lexers", 'wb') { |file| file.write(serialized_lexers) }

