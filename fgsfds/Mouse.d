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

final class Mouse
{
	static this() {}
	static void update() {}


	int x, y;
	bool right, left;
}
