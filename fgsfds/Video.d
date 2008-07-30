module fgsfds.Video;
/**
 * TODO: Open a window and be able to configure that window.
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
import derelict.opengl.gl;
import derelict.opengl.glu;

enum : uint
{
	FULLSCREEN = SDL_FULLSCREEN,
	RESIZABLE = SDL_RESIZABLE,
	NOFRAME = SDL_NOFRAME
}

enum BitDepth : ushort
{
	bpp8 = 8,
	bpp15 = 15,
	bpp16 = 16,
	bpp24 = 24,
	bpp32 = 32
}


final class Video
{
	static this()
	{
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

	static void setup(int width, int height, BitDepth bitPerPixel, uint flags = 0)
	{
		// Set our opengl attributes
		ushort[] bpp = bppToArray(bitPerPixel);
		SDL_GL_SetAttribute(SDL_GL_RED_SIZE, bpp[0]);
		SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, bpp[1]);
		SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, bpp[2]);
		SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, 5);
		SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 16);
		// Forced double buffering
		SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	
		// Create our window with SDL
		if(SDL_SetVideoMode( width, height, bitPerPixel, SDL_OPENGL|flags) is null)
		{
			throw new VideoException("Failed to set SDL video mode.");
		}
		
		sceneSize(width, height);

		active = true;
	}

	static void sceneSize(int width, int height)
	{
		if(height <= 0)
			height = 1;

		glViewport(0, 0, width, height);

		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		gluPerspective(45.0f, cast(GLfloat) width / cast(GLfloat) height, 1.0f, 100.0f);

		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
	}

	private static ushort[] bppToArray(BitDepth bitsPerPixel)
	{
		switch(bitsPerPixel)
		{
			case 8:
				return new ushort[2, 3, 3];
			case 15:
				return new ushort[5, 5, 5];
			case 16:
				return new ushort[5, 6, 5];
			case 24:
			case 32:
				return new ushort[8, 8, 8];
			default:
				throw new VideoException("Invalid bits per pixel.");
		}
	}

	private static bool active = false;
}

class VideoException : Exception
{
public:
    this(char[] msg)
    {
        super(msg);
    }
}