///preload();

//This script is used only in the preload room
//In order to initialize global variables and settings
window_set_fullscreen(true);

global.pause = false;
global.sounds = true;
global.music = true;
global.fullscreen = true;

display_reset(0, true)//AA=0, vsync=true

room_goto_next();
