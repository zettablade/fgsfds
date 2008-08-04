module fgsfds.Mouse;
/**
 * TODO: Create a mouse class that will take tell you the current information about a mouse
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

import derelict.sdl.sdl;

static this()
{
	// Make sure SDL is loaded
	if(!DerelictSDL.loaded())
		DerelictSDL.load();
}

enum Toggle { Query, Disable, Enable }
enum Button : ubyte { Right, Left, Middle }

final class Mouse
{
	static this() {}
	
	static void update()
	{
		buttonStates = SDL_GetMouseState(&mouseX, &mouseY);
	}

	static Toggle show(Toggle state)
	{
		if(state != Toggle.Query)
		{
			if(state == Toggle.Enable)
				SDL_ShowCursor(SDL_ENABLE);
			else if(state == Toggle.Disable)
				SDL_ShowCursor(SDL_DISABLE);

			showState = state;
		}
		
		return showState;
	};

	static int x() { return mouseX; }
	static int y() { return mouseY; }

// 	static bool pressed(

	static int mouseX, mouseY;
	static ubyte buttonStates;
	static Toggle showState;
}
