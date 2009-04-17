package body SDL.TTF is
  use type C.int;

  function Init return Boolean is
    Return_Code : constant C.int := Init;
  begin
    if Return_Code = 0 then
      return True;
    else
      return False;
    end if;
  end Init;

  procedure ByteSwappedUnicode (Swapped : Boolean) is
  begin
    if Swapped then
      ByteSwappedUnicode (C.int (1));
    else
      ByteSwappedUnicode (C.int (0));
    end if;
  end ByteSwappedUnicode;

  function OpenFont (File : String; Point_Size : Integer) return Font_t is
    Ch_Array : aliased C.char_array := C.To_C (File);
  begin
    return OpenFont (CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), C.int (Point_Size));
  end OpenFont;

  function OpenFontIndex
   (File       : String;
    Point_Size : Integer;
    Index      : Long_Integer)
    return       Font_t
  is
    Ch_Array : aliased C.char_array := C.To_C (File);
  begin
    return OpenFontIndex (CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), C.int (Point_Size), C.long (Index));
  end OpenFontIndex;

  function OpenFontRW
   (Source      : SDL.RWops.RWops_Access_t;
    Free_Source : Integer;
    Point_Size  : Integer)
    return        Font_t
  is
  begin
    return OpenFontRW (Source, C.int (Free_Source), C.int (Point_Size));
  end OpenFontRW;

  function OpenFontIndexRW
   (Source      : SDL.RWops.RWops_Access_t;
    Free_Source : Integer;
    Point_Size  : Integer;
    Index       : Long_Integer)
    return        Font_t
  is
  begin
    return OpenFontIndexRW (Source, C.int (Free_Source), C.int (Point_Size), C.long (Index));
  end OpenFontIndexRW;

  function FontHeight (Font : Font_t) return Integer is
    Return_Code : constant C.int := FontHeight (Font);
  begin
    return Integer (Return_Code);
  end FontHeight;

  function FontAscent (Font : Font_t) return Integer is
    Return_Code : constant C.int := FontAscent (Font);
  begin
    return Integer (Return_Code);
  end FontAscent;

  function FontDescent (Font : Font_t) return Integer is
    Return_Code : constant C.int := FontDescent (Font);
  begin
    return Integer (Return_Code);
  end FontDescent;

  function FontLineSkip (Font : Font_t) return Integer is
    Return_Code : constant C.int := FontLineSkip (Font);
  begin
    return Integer (Return_Code);
  end FontLineSkip;

  function FontFaces (Font : Font_t) return Long_Integer is
    Return_Code : constant C.long := FontFaces (Font);
  begin
    return Long_Integer (Return_Code);
  end FontFaces;

  function FontFaceIsFixedWidth (Font : Font_t) return Boolean is
    Return_Code : constant C.int := FontFaceIsFixedWidth (Font);
  begin
    if Return_Code = 1 then
      return True;
    else
      return False;
    end if;
  end FontFaceIsFixedWidth;

  function FontFaceFamilyName (Font : Font_t) return String is
  begin
    return CS.Value (FontFaceFamilyName (Font));
  end FontFaceFamilyName;

  function FontFaceStyleName (Font : Font_t) return String is
  begin
    return CS.Value (FontFaceStyleName (Font));
  end FontFaceStyleName;

  function GlyphMetrics
   (Font       : Font_t;
    Char_Value : Wide_Character;
    Min_X      : access Integer;
    Max_X      : access Integer;
    Min_Y      : access Integer;
    Max_Y      : access Integer;
    Advance    : access Integer)
    return       Boolean
  is
    Temp_Min_X  : aliased C.int;
    Temp_Max_X  : aliased C.int;
    Temp_Min_Y  : aliased C.int;
    Temp_Max_Y  : aliased C.int;
    advan       : aliased C.int;
    ch16        : constant SDL.Uint16_t := SDL.Uint16_t (Wide_Character'Pos (Char_Value));
    Return_Code : constant C.int        :=
      GlyphMetrics (Font, ch16, Temp_Min_X'Access, Temp_Max_X'Access, Temp_Min_Y'Access, Temp_Max_Y'Access, advan'Access);
  begin
    if Return_Code = 0 then
      Min_X.all   := Integer (Temp_Min_X);
      Max_X.all   := Integer (Temp_Max_X);
      Min_Y.all   := Integer (Temp_Min_Y);
      Max_Y.all   := Integer (Temp_Max_Y);
      Advance.all := Integer (advan);
      return True;
    else
      return False;
    end if;
  end GlyphMetrics;

  function SizeText
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean
  is
    Char_Width  : aliased C.int;
    Char_Value  : aliased C.int;
    Ch_Array    : aliased C.char_array := C.To_C (Text);
    Return_Code : constant C.int       :=
      SizeText (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Char_Width'Access, Char_Value'Access);
  begin
    if Return_Code = 0 then
      Width.all  := Integer (Char_Width);
      Height.all := Integer (Char_Value);
      return True;
    else
      return False;
    end if;
  end SizeText;

  function SizeUTF8
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean
  is
    Char_Width  : aliased C.int;
    Char_Value  : aliased C.int;
    Ch_Array    : aliased C.char_array := C.To_C (Text);
    Return_Code : constant C.int       :=
      SizeUTF8 (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Char_Width'Access, Char_Value'Access);
  begin
    if Return_Code = 0 then
      Width.all  := Integer (Char_Width);
      Height.all := Integer (Char_Value);
      return True;
    else
      return False;
    end if;
  end SizeUTF8;

  function SizeUnicode
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean
  is
    Char_Width  : aliased C.int;
    Char_Value  : aliased C.int;
    Ch_Array    : aliased C.char_array := C.To_C (Text);
    Return_Code : constant C.int       :=
      SizeUnicode (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Char_Width'Access, Char_Value'Access);
  begin
    if Return_Code = 0 then
      Width.all  := Integer (Char_Width);
      Height.all := Integer (Char_Value);
      return True;
    else
      return False;
    end if;
  end SizeUnicode;

  function RenderText_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderText_Solid (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground);
  end RenderText_Solid;

  function RenderUTF8_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderUTF8_Solid (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground);
  end RenderUTF8_Solid;

  function RenderUnicode_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderUnicode_Solid (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground);
  end RenderUnicode_Solid;

  function RenderGlyph_Solid
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
  begin
    return RenderGlyph_Solid (Font, SDL.Uint16_t (Wide_Character'Pos (Glyph)), Foreground);
  end RenderGlyph_Solid;

  function RenderText_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderText_Shaded (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground, Background);
  end RenderText_Shaded;

  function RenderUTF8_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderUTF8_Shaded (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground, Background);
  end RenderUTF8_Shaded;

  function RenderUnicode_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderUnicode_Shaded (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground, Background);
  end RenderUnicode_Shaded;

  function RenderGlyph_Shaded
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t
  is
  begin
    return RenderGlyph_Shaded (Font, SDL.Uint16_t (Wide_Character'Pos (Glyph)), Foreground, Background);
  end RenderGlyph_Shaded;

  function RenderText_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderText_Blended (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground);
  end RenderText_Blended;

  function RenderUTF8_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderUTF8_Blended (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground);
  end RenderUTF8_Blended;

  function RenderUnicode_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
    Ch_Array : aliased C.char_array := C.To_C (Text);
  begin
    return RenderUnicode_Blended (Font, CS.To_Chars_Ptr (Ch_Array'Unchecked_Access), Foreground);
  end RenderUnicode_Blended;

  function RenderGlyph_Blended
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t)
    return       Video.Surface_Access_t
  is
  begin
    return RenderGlyph_Blended (Font, SDL.Uint16_t (Wide_Character'Pos (Glyph)), Foreground);
  end RenderGlyph_Blended;

  function WasInit return Boolean is
  begin
    return WasInit = 1;
  end WasInit;

end SDL.TTF;
