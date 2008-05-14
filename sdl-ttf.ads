with SDL.rwops;
with SDL.types;
with SDL.video;
with interfaces.c.strings;
with interfaces.c;
with system;

package SDL.ttf is
  package c renames interfaces.c;
  package cs renames interfaces.c.strings;
  package vid renames SDL.video;
  package st renames SDL.types;

  -- TTF_Font type is completely abstract
  type Font is new system.address;

  --
  -- This function tells the library whether UNICODE text is generally
  -- byteswapped.  A UNICODE BOM character in a string will override
  -- this setting for the remainder of that string.
  --
  procedure ByteSwappedUNICODE (swapped: c.int);
  pragma import (c, ByteSwappedUNICODE, "TTF_ByteSwappedUNICODE");

  --
  -- Initialize the TTF engine - returns 0 if successful, -1 on error
  --
  function Init return c.int;
  pragma import (c, Init, "TTF_Init");

  --
  -- Open a font file and create a font of the specified point size.
  -- Some .fon fonts will have several sizes embedded in the file, so the
  -- point size becomes the index of choosing which size.  If the value
  -- is too high, the last indexed size will be the default.
  --
  function OpenFont (file: cs.chars_ptr; ptsize: c.int) return Font;
  function OpenFontIndex (file: cs.chars_ptr; ptsize: c.int; index: c.long) return Font;
  function OpenFontRW (src: SDL.RWops.RWops_ptr; freesrc, ptsize: c.int) return Font;
  function OpenFontIndexRW (src: SDL.RWops.RWops_ptr; freesrc, ptsize: c.int; index: c.long) return Font;
  pragma import (c, OpenFont, "TTF_OpenFont");
  pragma import (c, OpenFontIndex, "TTF_OpenFontIndex");
  pragma import (c, OpenFontRW, "TTF_OpenFontRW");
  pragma import (c, OpenFontIndexRW, "TTF_OpenFontIndexRW");

  --
  -- Set and retrieve the font style.
  -- This font style is implemented by modifying the font glyphs, and
  -- doesn't reflect any inherent properties of the truetype font file.
  --

  STYLE_NORMAL:    constant c.int := 2#00000000#;
  STYLE_BOLD:      constant c.int := 2#00000001#;
  STYLE_ITALIC:    constant c.int := 2#00000010#;
  STYLE_UNDERLINE: constant c.int := 2#00000100#;

  function GetFontStyle (f: Font) return c.int;
  procedure SetFontStyle (f: Font; style: c.int);
  pragma import (c, GetFontStyle, "TTF_GetFontStyle");
  pragma import (c, SetFontStyle, "TTF_SetFontStyle");

  --
  -- Get the total height of the font - usually equal to point size
  --
  function FontHeight (f: Font) return c.int;
  pragma import (c, FontHeight, "TTF_FontHeight");

  --
  -- Get the offset from the baseline to the top of the font
  -- This is a positive value, relative to the baseline.
  --
  function FontAscent (f: Font) return c.int;
  pragma import (c, FontAscent, "TTF_FontAscent");

  --
  -- Get the offset from the baseline to the bottom of the font
  -- This is a negative value, relative to the baseline.
  --
  function FontDescent (f: Font) return c.int;
  pragma import (c, FontDescent, "TTF_FontDescent");

  --
  -- Get the recommended spacing between lines of text for this font
  --
  function FontLineSkip (f: Font) return c.int;
  pragma import (c, FontLineSkip, "TTF_FontLineSkip");

  --
  -- Get the number of faces of the font
  --
  function FontFaces (f: Font) return c.long;
  pragma import (c, FontFaces, "TTF_FontFaces");

  --
  -- Get the font face attributes, if any.
  --
  function FontFaceIsFixedWidth (f: Font) return c.int;
  function FontFaceFamilyName (f: Font) return cs.chars_ptr;
  function FontFaceStyleName (f: Font) return cs.chars_ptr;
  pragma import (c, FontFaceIsFixedWidth, "TTF_FontFaceIsFixedWidth");
  pragma import (c, FontFaceFamilyName, "TTF_FontFaceFamilyName");
  pragma import (c, FontFaceStyleName, "TTF_FontFaceStyleName");

  --
  -- Get the metrics (dimensions) of a glyph
  -- To understand what these metrics mean, here is a useful link:
  -- http://freetype.sourceforge.net/freetype2/docs/tutorial/step2.html
  --
  function GlyphMetrics (f: Font; ch: st.uint16; minx, maxx, miny, maxy, advance: access c.int)
    return c.int;
  pragma import (c, GlyphMetrics, "TTF_GlyphMetrics");

  --
  -- Get the dimensions of a rendered string of text
  --
  function SizeText (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int;
  function SizeUTF8 (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int;
  function SizeUNICODE (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int;
  pragma import (c, SizeText, "TTF_SizeText");
  pragma import (c, SizeUTF8, "TTF_SizeUTF8");
  pragma import (c, SizeUNICODE, "TTF_SizeUNICODE");

  --
  -- Create an 8-bit palettized surface and render the given text at
  -- fast quality with the given font and color.  The 0 pixel is the
  -- colorkey, giving a transparent background, and the 1 pixel is set
  -- to the text color.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderText_Solid (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Solid (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Solid (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  pragma import (c, RenderText_Solid, "TTF_RenderText_Solid");
  pragma import (c, RenderUTF8_Solid, "TTF_RenderUTF8_Solid");
  pragma import (c, RenderUNICODE_Solid, "TTF_RenderUNICODE_Solid");

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- fast quality with the given font and color.  The 0 pixel is the
  -- colorkey, giving a transparent background, and the 1 pixel is set
  -- to the text color.  The glyph is rendered without any padding or
  -- centering in the X direction, and aligned normally in the Y direction.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Solid (f: Font; glyph: st.uint16; fg: vid.color) return vid.surface_ptr;
  pragma import (c, RenderGlyph_Solid, "TTF_RenderGlyph_Solid");

  --
  -- Create an 8-bit palettized surface and render the given text at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderText_Shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  pragma import (c, RenderText_Shaded, "TTF_RenderText_Shaded");
  pragma import (c, RenderUTF8_Shaded, "TTF_RenderUTF8_Shaded");
  pragma import (c, RenderUNICODE_Shaded, "TTF_RenderUNICODE_Shaded");

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Shaded (f: Font; glyph: st.uint16; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  pragma import (c, RenderGlyph_Shaded, "TTF_RenderGlyph_Shaded");

  --
  -- Create a 32-bit ARGB surface and render the given text at high quality,
  -- using alpha blending to dither the font with the given color.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderText_Blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  pragma import (c, RenderText_Blended, "TTF_RenderText_Blended");
  pragma import (c, RenderUTF8_Blended, "TTF_RenderUTF8_Blended");
  pragma import (c, RenderUNICODE_Blended, "TTF_RenderUNICODE_Blended");

  --
  -- Create a 32-bit ARGB surface and render the given glyph at high quality,
  -- using alpha blending to dither the font with the given color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Blended (f: Font; glyph: st.uint16; fg: vid.color) return vid.surface_ptr;
  pragma import (c, RenderGlyph_Blended, "TTF_RenderGlyph_Blended");

  --
  -- Close an opened font file
  --
  procedure CloseFont (f: Font);
  pragma import (c, CloseFont, "TTF_CloseFont");
 
  --
  -- De-initialize the TTF engine
  --
  procedure Quit;
  pragma import (c, Quit, "TTF_Quit");

  --
  -- Check if the TTF engine is initialized
  --
  function WasInit return c.int;
  pragma import (c, WasInit, "TTF_WasInit");

  procedure SetError (fmt: cs.chars_ptr);
  pragma Import (c, SetError, "SDL_SetError");
  function GetError return cs.chars_ptr;
  pragma Import (c, GetError, "SDL_GetError");

end SDL.ttf;
