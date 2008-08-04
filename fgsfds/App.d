module fgsfds.App;
/**
 * Core file for "the endless project".
 * Automagically initializes and deinitializes the engine for you.
 *
 * License:
 *  This file is part of fgsfds.
 *  Copyright (C) 2007-2008 by Gabriel Anderson zettablade@gmail.com
 *
 *  fgsfds is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  fgsfds is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/
 */

import fgsfds.Video;
import fgsfds.Mouse;
import tango.io.Stdout;

import derelict.sdl.sdl;
import derelict.opengl.gl;
import derelict.opengl.glu;

import tango.stdc.stringz;

static this()
{

	// Should probably make this into a function =/
	// Make sure GL loaded
	if(!DerelictGL.loaded())
		DerelictGL.load();
	
	// Make sure GLU is loaded
	if(!DerelictGLU.loaded())
		DerelictGLU.load();
	
	// Make sure SDL is loaded
	if(!DerelictSDL.loaded())
		DerelictSDL.load();
}

final class App
{
	// This is the constructor, and is charged with loading the engine.
	static this()
	{
		//Start SDL
		if(SDL_Init( SDL_INIT_EVERYTHING ) != 0) 
		{
			throw new AppException("Failed to init SDL: " ~ getSDLError());
		}
	}
	
	/// This is the destructor, and is charged with unloading the engine.
	static ~this()
	{
		//Quit SDL 
		if(SDL_WasInit( SDL_INIT_EVERYTHING ) != 0)
		{
			SDL_Quit();
		}
	}
	
	static void setup(char[] title)
	{
		SDL_WM_SetCaption( toStringz(title), null );
		running = true;
	}
	
	static bool isRunning()
	{
		return running;
	}
	
	private static bool running = false;
	
	static void processEvents()
	{
		SDL_Event event;
		// get all events
		while(SDL_PollEvent(&event))		
		{
			switch(event.type)
			{
				// Quit event
				case SDL_QUIT:
					// Return false because we are quitting.
					running = false;
					break;
	
				case SDL_VIDEORESIZE:
					// the window has been resized so we need to set up our viewport and projection according to 
					// the new size
					Video.sceneSize(event.resize.w, event.resize.h);
					break;
				default:
					break;
			}
		}
	}

	private static char[] getSDLError()
	{
		return fromStringz(SDL_GetError());
	}
}


class AppException : Exception
{
public:
    this(char[] msg)
    {
        super(msg);
    }
}


unittest
{
	App.setup("My Game");
	Video.setup(640,480,BitDepth.bpp32);

	Mouse.show(Toggle.Disable);
	
	while(App.isRunning)
	{
		App.processEvents();
		Mouse.update();
		Stdout.formatln("X: {}\nY:{}", Mouse.x, Mouse.y);
	}
}
