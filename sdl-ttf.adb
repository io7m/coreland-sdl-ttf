package body SDL.ttf is
  use type c.int;

  function Init return boolean is
    ret : constant c.int := Init;
  begin
    if ret = 0 then
      return true;
    else
      return false;
    end if;
  end Init;

  procedure ByteSwappedUNICODE (swapped : boolean) is
  begin
    if swapped then
      ByteSwappedUNICODE (c.int (1));
    else
      ByteSwappedUNICODE (c.int (0));
    end if;
  end ByteSwappedUNICODE;

  function OpenFont
   (file      : string;
    pointsize : integer) return font_t
  is
    ch_array  : aliased c.char_array := c.to_c (file);
  begin
    return OpenFont (cs.to_chars_ptr (ch_array'unchecked_access),
      c.int (pointsize));
  end OpenFont;

  function OpenFontIndex
   (file      : string;
    pointsize : integer;
    index     : long_integer) return font_t
  is
    ch_array  : aliased c.char_array := c.to_c (file);
  begin
    return OpenFontIndex (cs.to_chars_ptr (ch_array'unchecked_access),
      c.int (pointsize), c.long (index));
  end OpenFontIndex;

  function OpenFontRW
   (src       : SDL.RWops.rwops_ptr_t;
    freesrc   : integer;
    pointsize : integer) return font_t is
  begin
    return OpenFontRW (src, c.int (freesrc), c.int (pointsize));
  end OpenFontRW;

  function OpenFontIndexRW
   (src       : SDL.RWops.rwops_ptr_t;
    freesrc   : integer;
    pointsize : integer;
    index     : long_integer) return font_t is
  begin
    return OpenFontIndexRW (src, c.int (freesrc), c.int (pointsize),
      c.long (index));
  end OpenFontIndexRW;

  function FontHeight (font : font_t) return integer is
    ret : constant c.int := FontHeight (font);
  begin
    return integer (ret);
  end FontHeight;

  function FontAscent (font : font_t) return integer is
    ret : constant c.int := FontAscent (font);
  begin
    return integer (ret);
  end FontAscent;

  function FontDescent (font : font_t) return integer is
    ret : constant c.int := FontDescent (font);
  begin
    return integer (ret);
  end FontDescent;

  function FontLineSkip (font : font_t) return integer is
    ret : constant c.int := FontLineSkip (font);
  begin
    return integer (ret);
  end FontLineSkip;

  function FontFaces (font : font_t) return long_integer is
    ret : constant c.long := FontFaces (font);
  begin
    return long_integer (ret);
  end FontFaces;

  function FontFaceIsFixedWidth (font : font_t) return boolean is
    ret : constant c.int := FontFaceIsFixedWidth (font);
  begin
    if ret = 1 then
      return true;
    else
      return false;
    end if;
  end FontFaceIsFixedWidth;

  function FontFaceFamilyName (font : font_t) return string is
  begin
    return cs.value (FontFaceFamilyName (font));
  end FontFaceFamilyName;

  function FontFaceStyleName (font : font_t) return string is
  begin
    return cs.value (FontFaceStyleName (font));
  end FontFaceStyleName;
 
  function GlyphMetrics
   (font       : font_t;
    char_value : wide_character;
    min_x      : access integer;
    max_x      : access integer;
    min_y      : access integer;
    max_y      : access integer;
    advance    : access integer) return boolean
  is
    tmp_min_x : aliased c.int;
    tmp_max_x : aliased c.int;
    tmp_min_y : aliased c.int;
    tmp_max_y : aliased c.int;
    advan : aliased c.int;
     ch16 : constant sdl.uint16 := sdl.uint16 (wide_character'pos (char_value));
      ret : constant c.int :=
        GlyphMetrics (font, ch16, tmp_min_x'access, tmp_max_x'access,
          tmp_min_y'access, tmp_max_y'access, advan'access);
  begin
    if ret = 0 then
      min_x.all := integer (tmp_min_x);
      max_x.all := integer (tmp_max_x);
      min_y.all := integer (tmp_min_y);
      max_y.all := integer (tmp_max_y);
      advance.all := integer (advan);
      return true;
    else
      return false;
    end if;
  end GlyphMetrics;

  function SizeText
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean
  is
    cw         : aliased c.int;
    char_value : aliased c.int;
    ch_array   : aliased c.char_array := c.to_c (text);
    ret        : constant c.int := SizeText (font,
      cs.to_chars_ptr (ch_array'unchecked_access), cw'access, char_value'access);
  begin
    if ret = 0 then
      width.all := integer (cw);
      height.all := integer (char_value);
      return true;
    else
      return false;
    end if;
  end SizeText;

  function SizeUTF8
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean
  is
    cw         : aliased c.int;
    char_value : aliased c.int;
    ch_array   : aliased c.char_array := c.to_c (text);
    ret        : constant c.int := SizeUTF8 (font,
      cs.to_chars_ptr (ch_array'unchecked_access), cw'access, char_value'access);
  begin
    if ret = 0 then
      width.all := integer (cw);
      height.all := integer (char_value);
      return true;
    else
      return false;
    end if;
  end SizeUTF8;

  function SizeUNICODE
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean
  is
    cw         : aliased c.int;
    char_value : aliased c.int;
    ch_array   : aliased c.char_array := c.to_c (text);
    ret        : constant c.int := SizeUNICODE (font,
      cs.to_chars_ptr (ch_array'unchecked_access), cw'access, char_value'access);
  begin
    if ret = 0 then
      width.all := integer (cw);
      height.all := integer (char_value);
      return true;
    else
      return false;
    end if;
  end SizeUNICODE;

  function RenderText_Solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderText_Solid (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground);
  end RenderText_Solid;

  function RenderUTF8_Solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderUTF8_Solid (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground);
  end RenderUTF8_Solid;

  function RenderUNICODE_Solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderUNICODE_Solid (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground);
  end RenderUNICODE_Solid;

  function RenderGlyph_Solid
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_ptr_t is
  begin
    return RenderGlyph_Solid (font, sdl.uint16 (wide_character'pos (glyph)), foreground);
  end RenderGlyph_Solid;
 
  function RenderText_Shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderText_Shaded (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground, background);
  end RenderText_Shaded;

  function RenderUTF8_Shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderUTF8_Shaded (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground, background);
  end RenderUTF8_Shaded;

  function RenderUNICODE_Shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderUNICODE_Shaded (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground, background);
  end RenderUNICODE_Shaded;

  function RenderGlyph_Shaded
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t;
    background : color_t) return vid.surface_ptr_t is
  begin
    return RenderGlyph_Shaded (font, sdl.uint16 (wide_character'pos (glyph)), foreground, background);
  end RenderGlyph_Shaded;
 
  function RenderText_Blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderText_Blended (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground);
  end RenderText_Blended;

  function RenderUTF8_Blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderUTF8_Blended (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground);
  end RenderUTF8_Blended;

  function RenderUNICODE_Blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_ptr_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return RenderUNICODE_Blended (font, cs.to_chars_ptr (ch_array'unchecked_access), foreground);
  end RenderUNICODE_Blended;

  function RenderGlyph_Blended
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_ptr_t is
  begin
    return RenderGlyph_Blended (font, sdl.uint16 (wide_character'pos (glyph)), foreground);
  end RenderGlyph_Blended;

  function WasInit return boolean is
  begin
    return WasInit = 1;
  end WasInit;

end SDL.ttf;
