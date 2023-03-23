# ruby-snake
Before run you need to install gosu gem.

Befor install gosu gem, check if you have installed system libraries in you linux system,
to install all system libraries you need, use the following commands:

#Ubuntu and Debian:
<code>sudo apt-get install build-essential libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libfreeimage-dev libopenal-dev libsndfile-dev</code>
#Fedora
<code>sudo dnf install gcc-c++ mesa-libGL-devel pango-devel SDL2-devel SDL2_ttf-devel freeimage-devel openal-soft-devel libsndfile-devel</code>
#Arch Linux or Manjaro
<code>sudo pacman -S base-devel sdl2 sdl2_ttf pango freeimage openal libsndfile</code>

After installing all required libraries, you need to install gosu gem:
<code>gem install gosu</code>

Now you can run the Game:
<code>ruby snake.rb</code>

#Enjoy!

