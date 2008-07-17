package body SDL.ttf is
  use type c.int;

  function Init return boolean is
    ret: constant c.int := Init;
  begin
    if ret = 0 then
      return true;
    else
      return false;
    end if;
  end Init;

  procedure ByteSwappedUNICODE (swapped: boolean) is
  begin
    if swapped then
      ByteSwappedUNICODE (c.int (1));
    else
      ByteSwappedUNICODE (c.int (0));
    end if;
  end ByteSwappedUNICODE;

  function OpenFont (file: string; ptsize: integer) return font_t is
  begin
    return OpenFont (cs.new_string (file), c.int (ptsize));
  end OpenFont;

  function OpenFontIndex (file: string; ptsize: integer; index: long_integer) return font_t is
  begin
    return OpenFontIndex (cs.new_string (file), c.int (ptsize), c.long (index));
  end OpenFontIndex;

  function OpenFontRW (src: SDL.RWops.rwops_ptr_t; freesrc, ptsize: integer) return font_t is
  begin
    return OpenFontRW (src, c.int (freesrc), c.int (ptsize));
  end OpenFontRW;

  function OpenFontIndexRW (src: SDL.RWops.rwops_ptr_t; freesrc, ptsize: integer; index: long_integer) return font_t is
  begin
    return OpenFontIndexRW (src, c.int (freesrc), c.int (ptsize), c.long (index));
  end OpenFontIndexRW;

  function FontHeight (f: font_t) return integer is
    ret: constant c.int := FontHeight (f);
  begin
    return integer (ret);
  end FontHeight;

  function FontAscent (f: font_t) return integer is
    ret: constant c.int := FontAscent (f);
  begin
    return integer (ret);
  end FontAscent;

  function FontDescent (f: font_t) return integer is
    ret: constant c.int := FontDescent (f);
  begin
    return integer (ret);
  end FontDescent;

  function FontLineSkip (f: font_t) return integer is
    ret: constant c.int := FontLineSkip (f);
  begin
    return integer (ret);
  end FontLineSkip;

  function FontFaces (f: font_t) return long_integer is
    ret: constant c.long := FontFaces (f);
  begin
    return long_integer (ret);
  end FontFaces;

  function FontFaceIsFixedWidth (f: font_t) return boolean is
    ret: constant c.int := FontFaceIsFixedWidth (f);
  begin
    if ret = 1 then
      return true;
    else
      return false;
    end if;
  end FontFaceIsFixedWidth;

  function FontFaceFamilyName (f: font_t) return string is
  begin
    return cs.value (FontFaceFamilyName (f));
  end FontFaceFamilyName;

  function FontFaceStyleName (f: font_t) return string is
  begin
    return cs.value (FontFaceStyleName (f));
  end FontFaceStyleName;
 
  function GlyphMetrics (f: font_t; ch: wide_character; minx, maxx, miny, maxy, advance: access integer) return boolean is
    min_x: aliased c.int;
    max_x: aliased c.int;
    min_y: aliased c.int;
    max_y: aliased c.int;
    advan: aliased c.int;
     ch16: constant sdl.uint16 := sdl.uint16 (wide_character'pos (ch));
      ret: constant c.int :=
        GlyphMetrics (f, ch16, min_x'access, max_x'access, min_y'access, max_y'access, advan'access);
  begin
    if ret = 0 then
      minx.all := integer (min_x);
      maxx.all := integer (max_x);
      miny.all := integer (min_y);
      maxy.all := integer (max_y);
      advance.all := integer (advan);
      return true;
    else
      return false;
    end if;
  end GlyphMetrics;

  function SizeText (f: font_t; text: string; w, h: access integer) return boolean is
    cw: aliased c.int;
    ch: aliased c.int;
    ret: constant c.int := SizeText (f, cs.new_string (text), cw'access, ch'access);
  begin
    if ret = 0 then
      w.all := integer (cw);
      h.all := integer (ch);
      return true;
    else
      return false;
    end if;
  end SizeText;

  function SizeUTF8 (f: font_t; text: string; w, h: access integer) return boolean is
    cw: aliased c.int;
    ch: aliased c.int;
    ret: constant c.int := SizeUTF8 (f, cs.new_string (text), cw'access, ch'access);
  begin
    if ret = 0 then
      w.all := integer (cw);
      h.all := integer (ch);
      return true;
    else
      return false;
    end if;
  end SizeUTF8;

  function SizeUNICODE (f: font_t; text: string; w, h: access integer) return boolean is
    cw: aliased c.int;
    ch: aliased c.int;
    ret: constant c.int := SizeUNICODE (f, cs.new_string (text), cw'access, ch'access);
  begin
    if ret = 0 then
      w.all := integer (cw);
      h.all := integer (ch);
      return true;
    else
      return false;
    end if;
  end SizeUNICODE;

  function RenderText_Solid (f: font_t; text: string; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderText_Solid (f, cs.new_string (text), fg);
  end RenderText_Solid;

  function RenderUTF8_Solid (f: font_t; text: string; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderUTF8_Solid (f, cs.new_string (text), fg);
  end RenderUTF8_Solid;

  function RenderUNICODE_Solid (f: font_t; text: string; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderUNICODE_Solid (f, cs.new_string (text), fg);
  end RenderUNICODE_Solid;

  function RenderGlyph_Solid (f: font_t; glyph: wide_character; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderGlyph_Solid (f, sdl.uint16 (wide_character'pos (glyph)), fg);
  end RenderGlyph_Solid;
 
  function RenderText_Shaded (f: font_t; text: string; fg: color_t; bg: color_t) return vid.surface_ptr_t is
  begin
    return RenderText_Shaded (f, cs.new_string (text), fg, bg);
  end RenderText_Shaded;

  function RenderUTF8_Shaded (f: font_t; text: string; fg: color_t; bg: color_t) return vid.surface_ptr_t is
  begin
    return RenderUTF8_Shaded (f, cs.new_string (text), fg, bg);
  end RenderUTF8_Shaded;

  function RenderUNICODE_Shaded (f: font_t; text: string; fg: color_t; bg: color_t) return vid.surface_ptr_t is
  begin
    return RenderUNICODE_Shaded (f, cs.new_string (text), fg, bg);
  end RenderUNICODE_Shaded;

  function RenderGlyph_Shaded (f: font_t; glyph: wide_character; fg: color_t; bg: color_t) return vid.surface_ptr_t is
  begin
    return RenderGlyph_Shaded (f, sdl.uint16 (wide_character'pos (glyph)), fg, bg);
  end RenderGlyph_Shaded;
 
  function RenderText_Blended (f: font_t; text: string; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderText_Blended (f, cs.new_string (text), fg);
  end RenderText_Blended;

  function RenderUTF8_Blended (f: font_t; text: string; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderUTF8_Blended (f, cs.new_string (text), fg);
  end RenderUTF8_Blended;

  function RenderUNICODE_Blended (f: font_t; text: string; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderUNICODE_Blended (f, cs.new_string (text), fg);
  end RenderUNICODE_Blended;

  function RenderGlyph_Blended (f: font_t; glyph: wide_character; fg: color_t) return vid.surface_ptr_t is
  begin
    return RenderGlyph_Blended (f, sdl.uint16 (wide_character'pos (glyph)), fg);
  end RenderGlyph_Blended;

  function WasInit return boolean is
  begin
    return WasInit = 1;
  end WasInit;

end SDL.ttf;
