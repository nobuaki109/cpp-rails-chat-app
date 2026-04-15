require "mkmf"

$CXXFLAGS = "#{$CXXFLAGS} -std=c++17"

create_makefile("moderation_ext")