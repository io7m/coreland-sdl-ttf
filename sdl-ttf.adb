package body sdl.ttf is
  use type c.int;

  function init return boolean is
    ret : constant c.int := init;
  begin
    if ret = 0 then
      return True;
    else
      return False;
    end if;
  end init;

  procedure byteswappedunicode (swapped : boolean) is
  begin
    if swapped then
      byteswappedunicode (c.int (1));
    else
      byteswappedunicode (c.int (0));
    end if;
  end byteswappedunicode;

  function openfont
   (file      : string;
    pointsize : integer)
    return font_t
  is
    ch_array : aliased c.char_array := c.to_c (file);
  begin
    return openfont
     (cs.to_chars_ptr (ch_array'unchecked_access),
      c.int (pointsize));
  end openfont;

  function openfontindex
   (file      : string;
    pointsize : integer;
    index     : long_integer) return font_t
  is
    ch_array : aliased c.char_array := c.to_c (file);
  begin
    return openfontindex
     (cs.to_chars_ptr (ch_array'unchecked_access),
      c.int (pointsize),
      c.long (index));
  end openfontindex;

  function openfontrw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : integer;
    pointsize : integer) return font_t is
  begin
    return openfontrw (src, c.int (freesrc), c.int (pointsize));
  end openfontrw;

  function openfontindexrw
   (src       : sdl.rwops.rwops_access_t;
    freesrc   : integer;
    pointsize : integer;
    index     : long_integer) return font_t is
  begin
    return openfontindexrw
     (src,
      c.int (freesrc),
      c.int (pointsize),
      c.long (index));
  end openfontindexrw;

  function fontheight (font : font_t) return integer is
    ret : constant c.int := fontheight (font);
  begin
    return integer (ret);
  end fontheight;

  function fontascent (font : font_t) return integer is
    ret : constant c.int := fontascent (font);
  begin
    return integer (ret);
  end fontascent;

  function fontdescent (font : font_t) return integer is
    ret : constant c.int := fontdescent (font);
  begin
    return integer (ret);
  end fontdescent;

  function fontlineskip (font : font_t) return integer is
    ret : constant c.int := fontlineskip (font);
  begin
    return integer (ret);
  end fontlineskip;

  function fontfaces (font : font_t) return long_integer is
    ret : constant c.long := fontfaces (font);
  begin
    return long_integer (ret);
  end fontfaces;

  function fontfaceisfixedwidth (font : font_t) return boolean is
    ret : constant c.int := fontfaceisfixedwidth (font);
  begin
    if ret = 1 then
      return True;
    else
      return False;
    end if;
  end fontfaceisfixedwidth;

  function fontfacefamilyname (font : font_t) return string is
  begin
    return cs.Value (fontfacefamilyname (font));
  end fontfacefamilyname;

  function fontfacestylename (font : font_t) return string is
  begin
    return cs.Value (fontfacestylename (font));
  end fontfacestylename;

  function glyphmetrics
   (font       : font_t;
    char_value : wide_character;
    min_x      : access integer;
    max_x      : access integer;
    min_y      : access integer;
    max_y      : access integer;
    advance    : access integer)
    return boolean
  is
    tmp_min_x : aliased c.int;
    tmp_max_x : aliased c.int;
    tmp_min_y : aliased c.int;
    tmp_max_y : aliased c.int;
    advan     : aliased c.int;
    ch16      : constant sdl.uint16_t := sdl.uint16_t (wide_character'pos (char_value));
    ret       : constant c.int        :=
      glyphmetrics
       (font,
        ch16,
        tmp_min_x'access,
        tmp_max_x'access,
        tmp_min_y'access,
        tmp_max_y'access,
        advan'access);
  begin
    if ret = 0 then
      min_x.all   := integer (tmp_min_x);
      max_x.all   := integer (tmp_max_x);
      min_y.all   := integer (tmp_min_y);
      max_y.all   := integer (tmp_max_y);
      advance.all := integer (advan);
      return True;
    else
      return False;
    end if;
  end glyphmetrics;

  function sizetext
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean
  is
    cw         : aliased c.int;
    char_value : aliased c.int;
    ch_array   : aliased c.char_array := c.to_c (text);
    ret        : constant c.int       := sizetext
       (font,
        cs.to_chars_ptr (ch_array'unchecked_access),
        cw'access,
        char_value'access);
  begin
    if ret = 0 then
      width.all  := integer (cw);
      height.all := integer (char_value);
      return True;
    else
      return False;
    end if;
  end sizetext;

  function sizeutf8
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean
  is
    cw         : aliased c.int;
    char_value : aliased c.int;
    ch_array   : aliased c.char_array := c.to_c (text);
    ret        : constant c.int       := sizeutf8
       (font,
        cs.to_chars_ptr (ch_array'unchecked_access),
        cw'access,
        char_value'access);
  begin
    if ret = 0 then
      width.all  := integer (cw);
      height.all := integer (char_value);
      return True;
    else
      return False;
    end if;
  end sizeutf8;

  function sizeunicode
   (font   : font_t;
    text   : string;
    width  : access integer;
    height : access integer) return boolean
  is
    cw         : aliased c.int;
    char_value : aliased c.int;
    ch_array   : aliased c.char_array := c.to_c (text);
    ret        : constant c.int       := sizeunicode
       (font,
        cs.to_chars_ptr (ch_array'unchecked_access),
        cw'access,
        char_value'access);
  begin
    if ret = 0 then
      width.all  := integer (cw);
      height.all := integer (char_value);
      return True;
    else
      return False;
    end if;
  end sizeunicode;

  function rendertext_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return rendertext_solid
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground);
  end rendertext_solid;

  function renderutf8_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return renderutf8_solid
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground);
  end renderutf8_solid;

  function renderunicode_solid
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return renderunicode_solid
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground);
  end renderunicode_solid;

  function renderglyph_solid
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_access_t is
  begin
    return renderglyph_solid
     (font,
      sdl.uint16_t (wide_character'pos (glyph)),
      foreground);
  end renderglyph_solid;

  function rendertext_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return rendertext_shaded
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground,
      background);
  end rendertext_shaded;

  function renderutf8_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return renderutf8_shaded
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground,
      background);
  end renderutf8_shaded;

  function renderunicode_shaded
   (font       : font_t;
    text       : string;
    foreground : color_t;
    background : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return renderunicode_shaded
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground,
      background);
  end renderunicode_shaded;

  function renderglyph_shaded
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t;
    background : color_t) return vid.surface_access_t is
  begin
    return renderglyph_shaded
     (font,
      sdl.uint16_t (wide_character'pos (glyph)),
      foreground,
      background);
  end renderglyph_shaded;

  function rendertext_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return rendertext_blended
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground);
  end rendertext_blended;

  function renderutf8_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return renderutf8_blended
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground);
  end renderutf8_blended;

  function renderunicode_blended
   (font       : font_t;
    text       : string;
    foreground : color_t) return vid.surface_access_t
  is
    ch_array : aliased c.char_array := c.to_c (text);
  begin
    return renderunicode_blended
     (font,
      cs.to_chars_ptr (ch_array'unchecked_access),
      foreground);
  end renderunicode_blended;

  function renderglyph_blended
   (font       : font_t;
    glyph      : wide_character;
    foreground : color_t) return vid.surface_access_t
  is
  begin
    return renderglyph_blended
     (font,
      sdl.uint16_t (wide_character'pos (glyph)),
      foreground);
  end renderglyph_blended;

  function wasinit return boolean is
  begin
    return wasinit = 1;
  end wasinit;

end sdl.ttf;
