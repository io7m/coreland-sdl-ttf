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
  procedure byte_swapped_unicode (swapped: c.int) renames ByteSwappedUNICODE;
  pragma import (c, ByteSwappedUNICODE, "TTF_ByteSwappedUNICODE");

  procedure ByteSwappedUNICODE (swapped: boolean);
  pragma inline (ByteSwappedUNICODE);

  --
  -- Initialize the TTF engine - returns 0 if successful, -1 on error
  --
  function Init return c.int;
  pragma import (c, Init, "TTF_Init");

  function Init return boolean;
  pragma inline (Init);

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
  function open_font (file: cs.chars_ptr; ptsize: c.int) return Font renames OpenFont;
  function open_font_index (file: cs.chars_ptr; ptsize: c.int; index: c.long) return Font renames OpenFontIndex;
  function open_font_rw (src: SDL.RWops.RWops_ptr; freesrc, ptsize: c.int) return Font renames OpenFontRW;
  function open_font_index_rw (src: SDL.RWops.RWops_ptr; freesrc, ptsize: c.int; index: c.long) return Font renames OpenFontIndexRW;
  pragma import (c, OpenFont, "TTF_OpenFont");
  pragma import (c, OpenFontIndex, "TTF_OpenFontIndex");
  pragma import (c, OpenFontRW, "TTF_OpenFontRW");
  pragma import (c, OpenFontIndexRW, "TTF_OpenFontIndexRW");

  function OpenFont (file: string; ptsize: integer) return Font;
  function OpenFontIndex (file: string; ptsize: integer; index: long_integer) return Font;
  function OpenFontRW (src: SDL.RWops.RWops_ptr; freesrc, ptsize: integer) return Font;
  function OpenFontIndexRW (src: SDL.RWops.RWops_ptr; freesrc, ptsize: integer; index: long_integer) return Font;
  function open_font (file: string; ptsize: integer) return Font renames OpenFont;
  function open_font_index (file: string; ptsize: integer; index: long_integer) return Font renames OpenFontIndex;
  function open_font_rw (src: SDL.RWops.RWops_ptr; freesrc, ptsize: integer) return Font renames OpenFontRW;
  function open_font_index_rw (src: SDL.RWops.RWops_ptr; freesrc, ptsize: integer; index: long_integer) return Font renames OpenFontIndexRW;
  pragma inline (OpenFont);
  pragma inline (OpenFontIndex);
  pragma inline (OpenFontRW);
  pragma inline (OpenFontIndexRW);

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
  function get_font_style (f: Font) return c.int renames GetFontStyle;
  procedure SetFontStyle (f: Font; style: c.int);
  procedure set_font_style (f: Font; style: c.int) renames SetFontStyle;
  pragma import (c, GetFontStyle, "TTF_GetFontStyle");
  pragma import (c, SetFontStyle, "TTF_SetFontStyle");

  --
  -- Get the total height of the font - usually equal to point size
  --
  function FontHeight (f: Font) return c.int;
  function font_height (f: Font) return c.int renames FontHeight;
  pragma import (c, FontHeight, "TTF_FontHeight");

  function FontHeight (f: Font) return integer;
  function font_height (f: Font) return integer renames FontHeight;
  pragma inline (FontHeight);

  --
  -- Get the offset from the baseline to the top of the font
  -- This is a positive value, relative to the baseline.
  --
  function FontAscent (f: Font) return c.int;
  function font_ascent (f: Font) return c.int renames FontAscent;
  pragma import (c, FontAscent, "TTF_FontAscent");

  function FontAscent (f: Font) return integer;
  function font_ascent (f: Font) return integer renames FontAscent;
  pragma inline (FontAscent);

  --
  -- Get the offset from the baseline to the bottom of the font
  -- This is a negative value, relative to the baseline.
  --
  function FontDescent (f: Font) return c.int;
  function font_descent (f: Font) return c.int renames FontDescent;
  pragma import (c, FontDescent, "TTF_FontDescent");

  function FontDescent (f: Font) return integer;
  function font_descent (f: Font) return integer renames FontDescent;
  pragma inline (FontDescent);

  --
  -- Get the recommended spacing between lines of text for this font
  --
  function FontLineSkip (f: Font) return c.int;
  function font_line_skip (f: Font) return c.int renames FontLineSkip;
  pragma import (c, FontLineSkip, "TTF_FontLineSkip");

  function FontLineSkip (f: Font) return integer;
  function font_line_skip (f: Font) return integer renames FontLineSkip;
  pragma inline (FontLineSkip);

  --
  -- Get the number of faces of the font
  --
  function FontFaces (f: Font) return c.long;
  function font_faces (f: Font) return c.long renames FontFaces;
  pragma import (c, FontFaces, "TTF_FontFaces");

  function FontFaces (f: Font) return long_integer;
  function font_faces (f: Font) return long_integer renames FontFaces;
  pragma inline (FontFaces);

  --
  -- Get the font face attributes, if any.
  --
  function FontFaceIsFixedWidth (f: Font) return c.int;
  function FontFaceFamilyName (f: Font) return cs.chars_ptr;
  function FontFaceStyleName (f: Font) return cs.chars_ptr;
  function font_face_is_fixed_width (f: Font) return c.int renames FontFaceIsFixedWidth;
  function font_face_family_name (f: Font) return cs.chars_ptr renames FontFaceFamilyName;
  function font_face_style_name (f: Font) return cs.chars_ptr renames FontFaceStyleName;
  pragma import (c, FontFaceIsFixedWidth, "TTF_FontFaceIsFixedWidth");
  pragma import (c, FontFaceFamilyName, "TTF_FontFaceFamilyName");
  pragma import (c, FontFaceStyleName, "TTF_FontFaceStyleName");

  function FontFaceIsFixedWidth (f: Font) return boolean;
  function FontFaceFamilyName (f: Font) return string;
  function FontFaceStyleName (f: Font) return string;
  function font_face_is_fixed_width (f: Font) return boolean renames FontFaceIsFixedWidth;
  function font_face_family_name (f: Font) return string renames FontFaceFamilyName;
  function font_face_style_name (f: Font) return string renames FontFaceStyleName;
  pragma inline (FontFaceIsFixedWidth);
  pragma inline (FontFaceFamilyName);
  pragma inline (FontFaceStyleName);

  --
  -- Get the metrics (dimensions) of a glyph
  -- To understand what these metrics mean, here is a useful link:
  -- http://freetype.sourceforge.net/freetype2/docs/tutorial/step2.html
  --
  function GlyphMetrics (f: Font; ch: st.uint16; minx, maxx, miny, maxy, advance: access c.int) return c.int;
  function glyph_metrics (f: Font; ch: st.uint16; minx, maxx, miny, maxy, advance: access c.int) return c.int renames GlyphMetrics;
  pragma import (c, GlyphMetrics, "TTF_GlyphMetrics");

  function GlyphMetrics (f: Font; ch: wide_character; minx, maxx, miny, maxy, advance: access integer) return boolean;
  function glyph_metrics (f: Font; ch: wide_character; minx, maxx, miny, maxy, advance: access integer) return boolean renames GlyphMetrics;
  pragma inline (GlyphMetrics);

  --
  -- Get the dimensions of a rendered string of text
  --
  function SizeText (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int;
  function SizeUTF8 (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int;
  function SizeUNICODE (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int;
  function size_text (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int renames SizeText;
  function size_utf8 (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int renames SizeUTF8;
  function size_unicode (f: Font; text: cs.chars_ptr; w, h: access c.int) return c.int renames SizeUNICODE;
  pragma import (c, SizeText, "TTF_SizeText");
  pragma import (c, SizeUTF8, "TTF_SizeUTF8");
  pragma import (c, SizeUNICODE, "TTF_SizeUNICODE");

  function SizeText (f: Font; text: string; w, h: access integer) return boolean;
  function SizeUTF8 (f: Font; text: string; w, h: access integer) return boolean;
  function SizeUNICODE (f: Font; text: string; w, h: access integer) return boolean;
  function size_text (f: Font; text: string; w, h: access integer) return boolean renames SizeText;
  function size_utf8 (f: Font; text: string; w, h: access integer) return boolean renames SizeUTF8;
  function size_unicode (f: Font; text: string; w, h: access integer) return boolean renames SizeUNICODE;
  pragma inline (SizeText);
  pragma inline (SizeUTF8);
  pragma inline (SizeUNICODE);

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
  function render_text_solid (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr renames RenderText_Solid;
  function render_utf8_solid (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr renames RenderUTF8_Solid;
  function render_unicode_solid (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr renames RenderUNICODE_Solid;
  pragma import (c, RenderText_Solid, "TTF_RenderText_Solid");
  pragma import (c, RenderUTF8_Solid, "TTF_RenderUTF8_Solid");
  pragma import (c, RenderUNICODE_Solid, "TTF_RenderUNICODE_Solid");

  function RenderText_Solid (f: Font; text: string; fg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Solid (f: Font; text: string; fg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Solid (f: Font; text: string; fg: vid.color) return vid.surface_ptr;
  function render_text_solid (f: Font; text: string; fg: vid.color) return vid.surface_ptr renames RenderText_Solid;
  function render_utf8_solid (f: Font; text: string; fg: vid.color) return vid.surface_ptr renames RenderUTF8_Solid;
  function render_unicode_solid (f: Font; text: string; fg: vid.color) return vid.surface_ptr renames RenderUNICODE_Solid;
  pragma inline (RenderText_Solid);
  pragma inline (RenderUTF8_Solid);
  pragma inline (RenderUNICODE_Solid);

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- fast quality with the given font and color.  The 0 pixel is the
  -- colorkey, giving a transparent background, and the 1 pixel is set
  -- to the text color.  The glyph is rendered without any padding or
  -- centering in the X direction, and aligned normally in the Y direction.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Solid (f: Font; glyph: st.uint16; fg: vid.color) return vid.surface_ptr;
  function render_glyph_solid (f: Font; glyph: st.uint16; fg: vid.color) return vid.surface_ptr renames RenderGlyph_Solid;
  pragma import (c, RenderGlyph_Solid, "TTF_RenderGlyph_Solid");

  function RenderGlyph_Solid (f: Font; glyph: wide_character; fg: vid.color) return vid.surface_ptr;
  function render_glyph_solid (f: Font; glyph: wide_character; fg: vid.color) return vid.surface_ptr renames RenderGlyph_Solid;
  pragma inline (RenderGlyph_Solid);

  --
  -- Create an 8-bit palettized surface and render the given text at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderText_Shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function render_text_shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderText_Shaded;
  function render_utf8_shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderUTF8_Shaded;
  function render_unicode_shaded (f: Font; text: cs.chars_ptr; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderUNICODE_Shaded;
  pragma import (c, RenderText_Shaded, "TTF_RenderText_Shaded");
  pragma import (c, RenderUTF8_Shaded, "TTF_RenderUTF8_Shaded");
  pragma import (c, RenderUNICODE_Shaded, "TTF_RenderUNICODE_Shaded");

  function RenderText_Shaded (f: Font; text: string; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Shaded (f: Font; text: string; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Shaded (f: Font; text: string; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function render_text_shaded (f: Font; text: string; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderText_Shaded;
  function render_utf8_shaded (f: Font; text: string; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderUTF8_Shaded;
  function render_unicode_shaded (f: Font; text: string; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderUNICODE_Shaded;
  pragma inline (RenderText_Shaded);
  pragma inline (RenderUTF8_Shaded);
  pragma inline (RenderUNICODE_Shaded);

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Shaded (f: Font; glyph: st.uint16; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function render_glyph_shaded (f: Font; glyph: st.uint16; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderGlyph_Shaded;
  pragma import (c, RenderGlyph_Shaded, "TTF_RenderGlyph_Shaded");

  function RenderGlyph_Shaded (f: Font; glyph: wide_character; fg: vid.color; bg: vid.color) return vid.surface_ptr;
  function render_glyph_shaded (f: Font; glyph: wide_character; fg: vid.color; bg: vid.color) return vid.surface_ptr renames RenderGlyph_Shaded;
  pragma inline (RenderGlyph_Shaded);

  --
  -- Create a 32-bit ARGB surface and render the given text at high quality,
  -- using alpha blending to dither the font with the given color.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderText_Blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr;
  function render_text_blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr renames RenderText_Blended;
  function render_utf8_blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr renames RenderUTF8_Blended;
  function render_unicode_blended (f: Font; text: cs.chars_ptr; fg: vid.color) return vid.surface_ptr renames RenderUNICODE_Blended;
  pragma import (c, RenderText_Blended, "TTF_RenderText_Blended");
  pragma import (c, RenderUTF8_Blended, "TTF_RenderUTF8_Blended");
  pragma import (c, RenderUNICODE_Blended, "TTF_RenderUNICODE_Blended");

  function RenderText_Blended (f: Font; text: string; fg: vid.color) return vid.surface_ptr;
  function RenderUTF8_Blended (f: Font; text: string; fg: vid.color) return vid.surface_ptr;
  function RenderUNICODE_Blended (f: Font; text: string; fg: vid.color) return vid.surface_ptr;
  function render_text_blended (f: Font; text: string; fg: vid.color) return vid.surface_ptr renames RenderText_Blended;
  function render_utf8_blended (f: Font; text: string; fg: vid.color) return vid.surface_ptr renames RenderUTF8_Blended;
  function render_unicode_blended (f: Font; text: string; fg: vid.color) return vid.surface_ptr renames RenderUNICODE_Blended;
  pragma inline (RenderText_Blended);
  pragma inline (RenderUTF8_Blended);
  pragma inline (RenderUNICODE_Blended);

  --
  -- Create a 32-bit ARGB surface and render the given glyph at high quality,
  -- using alpha blending to dither the font with the given color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function returns the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Blended (f: Font; glyph: st.uint16; fg: vid.color) return vid.surface_ptr;
  function render_glyph_blended (f: Font; glyph: st.uint16; fg: vid.color) return vid.surface_ptr renames RenderGlyph_Blended;
  pragma import (c, RenderGlyph_Blended, "TTF_RenderGlyph_Blended");

  function RenderGlyph_Blended (f: Font; glyph: wide_character; fg: vid.color) return vid.surface_ptr;
  function render_glyph_blended (f: Font; glyph: wide_character; fg: vid.color) return vid.surface_ptr renames RenderGlyph_Blended;
  pragma inline (RenderGlyph_Blended);

  --
  -- Close an opened font file
  --
  procedure CloseFont (f: Font);
  procedure close_font (f: Font) renames CloseFont;
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
  function was_init return c.int renames WasInit;
  pragma import (c, WasInit, "TTF_WasInit");

  function WasInit return boolean;
  function was_init return boolean renames WasInit;
  pragma inline (WasInit);

end SDL.ttf;
