with sdl;
with sdl.rwops;
with sdl.video;
with Interfaces.C.strings;
with Interfaces.C;
with System;

package sdl.ttf is
  package c renames Interfaces.C;
  package cs renames Interfaces.C.strings;
  package vid renames sdl.video;

  -- TTF_Font type is completely abstract
  type font_t is access System.Address;

  -- Specialized color type, necessary because SDL_ttf expects color structures
  -- by value and this requires a pragma convention.

  type color_t is record
    r : sdl.uint8_t;
    g : sdl.uint8_t;
    b : sdl.uint8_t;
    a : sdl.uint8_t;
  end record;
  pragma convention (c_pass_by_copy, color_t);

  --
  -- This function tells the library whether UNICODE text is generally
  -- byteswapped.  A UNICODE BOM character in a string will override
  -- this setting for the remainder of that string.
  --
  procedure byteswappedunicode (swapped : c.int);
  procedure byte_swapped_unicode (swapped : c.int) renames byteswappedunicode;
  pragma import (c, byteswappedunicode, "TTF_ByteSwappedUNICODE");

  procedure byteswappedunicode (swapped : boolean);
  pragma inline (byteswappedunicode);

  --
  -- Initialize the TTF engine - return s 0 if successful, -1 on error
  --
  function init return c.int;
  pragma import (c, init, "TTF_Init");

  function init return boolean;
  pragma inline (init);

  --
  -- Open a font file and create a font of the specified point size.
  -- Some .fon fonts will have several sizes embedded in the file, so the
  -- point size becomes the index of choosing which size.  If the value
  -- is too high, the last indexed size will be the default.
  --

  function openfont
   (file      : cs.chars_ptr;
    pointsize : c.int) return font_t;

  function openfontindex
   (file      : cs.chars_ptr;
    pointsize : c.int;
    index     : c.long) return font_t;

  function openfontrw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : c.int;
    pointsize : c.int) return font_t;

  function openfontindexrw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : c.int;
    pointsize : c.int;
    index     : c.long) return font_t;

  function open_font
   (file      : cs.chars_ptr;
    pointsize : c.int) return font_t renames openfont;

  function open_font_index
   (file      : cs.chars_ptr;
    pointsize : c.int;
    index     : c.long) return font_t renames openfontindex;

  function open_font_rw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : c.int;
    pointsize : c.int) return font_t renames openfontrw;

  function open_font_index_rw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : c.int;
    pointsize : c.int;
    index     : c.long) return font_t renames openfontindexrw;

  pragma import (c, openfont, "TTF_OpenFont");
  pragma import (c, openfontindex, "TTF_OpenFontIndex");
  pragma import (c, openfontrw, "TTF_OpenFontRW");
  pragma import (c, openfontindexrw, "TTF_OpenFontIndexRW");

  function openfont
   (file      : string;
    pointsize : integer) return font_t;

  function openfontindex
   (file      : string;
    pointsize : integer;
    index     : long_integer) return font_t;

  function openfontrw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : integer;
    pointsize : integer) return font_t;

  function openfontindexrw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : integer;
    pointsize : integer;
    index     : long_integer) return font_t;

  function open_font
   (file      : string;
    pointsize : integer) return font_t renames openfont;

  function open_font_index
   (file      : string;
    pointsize : integer;
    index     : long_integer) return font_t renames openfontindex;

  function open_font_rw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : integer;
    pointsize : integer) return font_t renames openfontrw;

  function open_font_index_rw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : integer;
    pointsize : integer;
    index     : long_integer) return font_t renames openfontindexrw;

  pragma inline (openfont);
  pragma inline (openfontindex);
  pragma inline (openfontrw);
  pragma inline (openfontindexrw);

  --
  -- Set and retrieve the font style.
  -- This font style is implemented by modifying the font glyphs, and
  -- doesn't reflect any inherent properties of the truetype font file.
  --

  style_normal    : constant c.int := 2#00000000#;
  style_bold      : constant c.int := 2#00000001#;
  style_italic    : constant c.int := 2#00000010#;
  style_underline : constant c.int := 2#00000100#;

  function getfontstyle (font : font_t) return c.int;
  function get_font_style (font : font_t) return c.int renames getfontstyle;
  procedure setfontstyle (font : font_t; style : c.int);
  procedure set_font_style (font : font_t; style : c.int) renames setfontstyle;
  pragma import (c, getfontstyle, "TTF_GetFontStyle");
  pragma import (c, setfontstyle, "TTF_SetFontStyle");

  --
  -- Get the total height of the font - usually equal to point size
  --
  function fontheight (font : font_t) return c.int;
  function font_height (font : font_t) return c.int renames fontheight;
  pragma import (c, fontheight, "TTF_FontHeight");

  function fontheight (font : font_t) return integer;
  function font_height (font : font_t) return integer renames fontheight;
  pragma inline (fontheight);

  --
  -- Get the offset from the baseline to the top of the font
  -- This is a positive value, relative to the baseline.
  --
  function fontascent (font : font_t) return c.int;
  function font_ascent (font : font_t) return c.int renames fontascent;
  pragma import (c, fontascent, "TTF_FontAscent");

  function fontascent (font : font_t) return integer;
  function font_ascent (font : font_t) return integer renames fontascent;
  pragma inline (fontascent);

  --
  -- Get the offset from the baseline to the bottom of the font
  -- This is a negative value, relative to the baseline.
  --
  function fontdescent (font : font_t) return c.int;
  function font_descent (font : font_t) return c.int renames fontdescent;
  pragma import (c, fontdescent, "TTF_FontDescent");

  function fontdescent (font : font_t) return integer;
  function font_descent (font : font_t) return integer renames fontdescent;
  pragma inline (fontdescent);

  --
  -- Get the recommended spacing between lines of text for this font
  --
  function fontlineskip (font : font_t) return c.int;
  function font_line_skip (font : font_t) return c.int renames fontlineskip;
  pragma import (c, fontlineskip, "TTF_FontLineSkip");

  function fontlineskip (font : font_t) return integer;
  function font_line_skip (font : font_t) return integer renames fontlineskip;
  pragma inline (fontlineskip);

  --
  -- Get the number of faces of the font
  --
  function fontfaces (font : font_t) return c.long;
  function font_faces (font : font_t) return c.long renames fontfaces;
  pragma import (c, fontfaces, "TTF_FontFaces");

  function fontfaces (font : font_t) return long_integer;
  function font_faces (font : font_t) return long_integer renames fontfaces;
  pragma inline (fontfaces);

  --
  -- Get the font face attributes, if any.
  --
  function fontfaceisfixedwidth (font : font_t) return c.int;
  function fontfacefamilyname (font : font_t) return cs.chars_ptr;
  function fontfacestylename (font : font_t) return cs.chars_ptr;
  function font_face_is_fixed_width (font : font_t) return c.int renames fontfaceisfixedwidth;
  function font_face_family_name (font : font_t) return cs.chars_ptr renames fontfacefamilyname;
  function font_face_style_name (font : font_t) return cs.chars_ptr renames fontfacestylename;
  pragma import (c, fontfaceisfixedwidth, "TTF_FontFaceIsFixedWidth");
  pragma import (c, fontfacefamilyname, "TTF_FontFaceFamilyName");
  pragma import (c, fontfacestylename, "TTF_FontFaceStyleName");

  function fontfaceisfixedwidth (font : font_t) return boolean;
  function fontfacefamilyname (font : font_t) return string;
  function fontfacestylename (font : font_t) return string;
  function font_face_is_fixed_width (font : font_t) return boolean renames fontfaceisfixedwidth;
  function font_face_family_name (font : font_t) return string renames fontfacefamilyname;
  function font_face_style_name (font : font_t) return string renames fontfacestylename;
  pragma inline (fontfaceisfixedwidth);
  pragma inline (fontfacefamilyname);
  pragma inline (fontfacestylename);

  --
  -- Get the metrics (dimensions) of a glyph
  -- To understand what these metrics mean, here is a useful link :
  -- http ://freetype.sourceforge.net/freetype2/docs/tutorial/step2.html
  --
  function glyphmetrics
   (font       : font_t;
    char_value : sdl.uint16_t;
    min_x      : access c.int;
    max_x      : access c.int;
    min_y      : access c.int;
    max_y      : access c.int;
    advance    : access c.int) return c.int;
  function glyph_metrics
   (font       : font_t;
    char_value : sdl.uint16_t;
    min_x      : access c.int;
    max_x      : access c.int;
    min_y      : access c.int;
    max_y      : access c.int;
    advance    : access c.int) return c.int renames glyphmetrics;
  pragma import (c, glyphmetrics, "TTF_GlyphMetrics");

  function glyphmetrics
   (font       : font_t;
    char_value : wide_character;
    min_x      : access integer;
    max_x      : access integer;
    min_y      : access integer;
    max_y      : access integer;
    advance    : access integer) return boolean;

  function glyph_metrics
   (font       : font_t;
    char_value : wide_character;
    min_x      : access integer;
    max_x      : access integer;
    min_y      : access integer;
    max_y      : access integer;
    advance    : access integer) return boolean renames glyphmetrics;
  pragma inline (glyphmetrics);

  --
  -- Get the dimensions of a rendered string of text
  --
  function sizetext
   (font   : font_t;
    text   : cs.chars_ptr;
    width  : access c.int;
    height : access c.int) return c.int;

  function sizeutf8
   (font   : font_t;
    text   : cs.chars_ptr;
    width  : access c.int;
    height : access c.int) return c.int;

  function sizeunicode
   (font   : font_t;
    text   : cs.chars_ptr;
    width  : access c.int;
    height : access c.int) return c.int;

  function size_text
   (font   : font_t;
    text   : cs.chars_ptr;
    width  : access c.int;
    height : access c.int) return c.int renames sizetext;

  function size_utf8
   (font   : font_t;
    text   : cs.chars_ptr;
    width  : access c.int;
    height : access c.int) return c.int renames sizeutf8;

  function size_unicode
   (font   : font_t;
    text   : cs.chars_ptr;
    width  : access c.int;
    height : access c.int) return c.int renames sizeunicode;

  pragma import (c, sizetext, "TTF_SizeText");
  pragma import (c, sizeutf8, "TTF_SizeUTF8");
  pragma import (c, sizeunicode, "TTF_SizeUNICODE");

  function sizetext
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean;

  function sizeutf8
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean;

  function sizeunicode
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean;

  function size_text
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean renames sizetext;

  function size_utf8
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean renames sizeutf8;

  function size_unicode
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean renames sizeunicode;

  pragma inline (sizetext);
  pragma inline (sizeutf8);
  pragma inline (sizeunicode);

  --
  -- Create an 8-bit palettized surface and render the given text at
  -- fast quality with the given font and color.  The 0 pixel is the
  -- colorkey, giving a transparent background, and the 1 pixel is set
  -- to the text color.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function rendertext_solid
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t;

  function renderutf8_solid
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t;

  function renderunicode_solid
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t;

  function render_text_solid
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t renames rendertext_solid;

  function render_utf8_solid
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t renames renderutf8_solid;

  function render_unicode_solid
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t renames renderunicode_solid;

  pragma import (c, rendertext_solid, "TTF_RenderText_Solid");
  pragma import (c, renderutf8_solid, "TTF_RenderUTF8_Solid");
  pragma import (c, renderunicode_solid, "TTF_RenderUNICODE_Solid");

  function rendertext_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t;

  function renderutf8_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t;

  function renderunicode_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t;

  function render_text_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t renames rendertext_solid;

  function render_utf8_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t renames renderutf8_solid;

  function render_unicode_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t renames renderunicode_solid;

  pragma inline (rendertext_solid);
  pragma inline (renderutf8_solid);
  pragma inline (renderunicode_solid);

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- fast quality with the given font and color.  The 0 pixel is the
  -- colorkey, giving a transparent background, and the 1 pixel is set
  -- to the text color.  The glyph is rendered without any padding or
  -- centering in the X direction, and aligned normally in the Y direction.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function renderglyph_solid
   (font       : font_t;
    glyph      : sdl.uint16_t;
    foreground : color_t) return vid.surface_access_t;
  function render_glyph_solid
   (font       : font_t;
    glyph      : sdl.uint16_t;
    foreground : color_t) return vid.surface_access_t renames renderglyph_solid;
  pragma import (c, renderglyph_solid, "TTF_RenderGlyph_Solid");

  function renderglyph_solid
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_access_t;
  function render_glyph_solid
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_access_t renames renderglyph_solid;
  pragma inline (renderglyph_solid);

  --
  -- Create an 8-bit palettized surface and render the given text at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function rendertext_shaded
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function renderutf8_shaded
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function renderunicode_shaded
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function render_text_shaded
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames rendertext_shaded;
  function render_utf8_shaded
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames renderutf8_shaded;
  function render_unicode_shaded
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames renderunicode_shaded;
  pragma import (c, rendertext_shaded, "TTF_RenderText_Shaded");
  pragma import (c, renderutf8_shaded, "TTF_RenderUTF8_Shaded");
  pragma import (c, renderunicode_shaded, "TTF_RenderUNICODE_Shaded");

  function rendertext_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function renderutf8_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function renderunicode_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function render_text_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames rendertext_shaded;
  function render_utf8_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames renderutf8_shaded;
  function render_unicode_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames renderunicode_shaded;
  pragma inline (rendertext_shaded);
  pragma inline (renderutf8_shaded);
  pragma inline (renderunicode_shaded);

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function renderglyph_shaded
   (font       : font_t;
    glyph      : sdl.uint16_t;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function render_glyph_shaded
   (font       : font_t;
    glyph      : sdl.uint16_t;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames renderglyph_shaded;
  pragma import (c, renderglyph_shaded, "TTF_RenderGlyph_Shaded");

  function renderglyph_shaded
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t;
    background : color_t) return vid.surface_access_t;
  function render_glyph_shaded
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t;
    background : color_t) return vid.surface_access_t renames renderglyph_shaded;
  pragma inline (renderglyph_shaded);

  --
  -- Create a 32-bit ARGB surface and render the given text at high quality,
  -- using alpha blending to dither the font with the given color.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function rendertext_blended
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t;
  function renderutf8_blended
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t;
  function renderunicode_blended
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t;
  function render_text_blended
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t renames rendertext_blended;
  function render_utf8_blended
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t renames renderutf8_blended;
  function render_unicode_blended
   (font       : font_t;
    text       : cs.chars_ptr;
    foreground : color_t) return vid.surface_access_t renames renderunicode_blended;
  pragma import (c, rendertext_blended, "TTF_RenderText_Blended");
  pragma import (c, renderutf8_blended, "TTF_RenderUTF8_Blended");
  pragma import (c, renderunicode_blended, "TTF_RenderUNICODE_Blended");

  function rendertext_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t;
  function renderutf8_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t;
  function renderunicode_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t;
  function render_text_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t renames rendertext_blended;
  function render_utf8_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t renames renderutf8_blended;
  function render_unicode_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t renames renderunicode_blended;
  pragma inline (rendertext_blended);
  pragma inline (renderutf8_blended);
  pragma inline (renderunicode_blended);

  --
  -- Create a 32-bit ARGB surface and render the given glyph at high quality,
  -- using alpha blending to dither the font with the given color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function renderglyph_blended
   (font       : font_t;
    glyph      : sdl.uint16_t;
    foreground : color_t) return vid.surface_access_t;
  function render_glyph_blended
   (font       : font_t;
    glyph      : sdl.uint16_t;
    foreground : color_t) return vid.surface_access_t renames renderglyph_blended;
  pragma import (c, renderglyph_blended, "TTF_RenderGlyph_Blended");

  function renderglyph_blended
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_access_t;
  function render_glyph_blended
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_access_t renames renderglyph_blended;
  pragma inline (renderglyph_blended);

  --
  -- Close an opened font file
  --
  procedure closefont (font : font_t);
  procedure close_font (font : font_t) renames closefont;
  pragma import (c, closefont, "TTF_CloseFont");

  --
  -- De-initialize the TTF engine
  --
  procedure quit;
  pragma import (c, quit, "TTF_Quit");

  --
  -- Check if the TTF engine is initialized
  --
  function wasinit return c.int;
  function was_init return c.int renames wasinit;
  pragma import (c, wasinit, "TTF_WasInit");

  function wasinit return boolean;
  function was_init return boolean renames wasinit;
  pragma inline (wasinit);

end sdl.ttf;
