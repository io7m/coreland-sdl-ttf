with SDL;
with SDL.RWops;
with SDL.Video;
with Interfaces.C.Strings;
with Interfaces.C;
with System;

package SDL.TTF is
  package C renames Interfaces.C;
  package CS renames Interfaces.C.Strings;

  -- TTF_Font type is completely abstract
  type Font_t is access System.Address;

  -- Specialized color type, necessary because SDL_TTF expects color structures
  -- by value and this requires a pragma convention.

  type Color_t is record
    R : SDL.Uint8_t;
    G : SDL.Uint8_t;
    B : SDL.Uint8_t;
    A : SDL.Uint8_t;
  end record;
  pragma Convention (C_Pass_By_Copy, Color_t);

  --
  -- This function tells the library whether UNICODE text is generally
  -- byteswapped.  A UNICODE BOM character in a string will override
  -- this setting for the remainder of that string.
  --
  procedure ByteSwappedUnicode (Swapped : C.int);
  procedure Byte_Swapped_Unicode (Swapped : C.int) renames ByteSwappedUnicode;
  pragma Import (C, ByteSwappedUnicode, "TTF_ByteSwappedUnicode");

  procedure ByteSwappedUnicode (Swapped : Boolean);
  pragma Inline (ByteSwappedUnicode);

  --
  -- Initialize the TTF engine - return s 0 if successful, -1 on error
  --
  function Init return  C.int;
  pragma Import (C, Init, "TTF_Init");

  function Init return Boolean;
  pragma Inline (Init);

  --
  -- Open a font file and create a font of the specified point size.
  -- Some .fon fonts will have several sizes embedded in the file, so the
  -- point size becomes the index of choosing which size.  If the value
  -- is too high, the last indexed size will be the default.
  --

  function OpenFont (File : CS.chars_ptr; Point_Size : C.int) return Font_t;

  function OpenFontIndex
   (File      : CS.chars_ptr;
    Point_Size : C.int;
    Index     : C.long)
    return      Font_t;

  function OpenFontRW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : C.int;
    Point_Size : C.int)
    return      Font_t;

  function OpenFontIndexRW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : C.int;
    Point_Size : C.int;
    Index     : C.long)
    return      Font_t;

  function Open_Font (File : CS.chars_ptr; Point_Size : C.int) return Font_t renames OpenFont;

  function Open_Font_Index
   (File      : CS.chars_ptr;
    Point_Size : C.int;
    Index     : C.long)
    return      Font_t renames OpenFontIndex;

  function Open_Font_RW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : C.int;
    Point_Size : C.int)
    return      Font_t renames OpenFontRW;

  function Open_Font_Index_RW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : C.int;
    Point_Size : C.int;
    Index     : C.long)
    return      Font_t renames OpenFontIndexRW;

  pragma Import (C, OpenFont, "TTF_OpenFont");
  pragma Import (C, OpenFontIndex, "TTF_OpenFontIndex");
  pragma Import (C, OpenFontRW, "TTF_OpenFontRW");
  pragma Import (C, OpenFontIndexRW, "TTF_OpenFontIndexRW");

  function OpenFont (File : String; Point_Size : Integer) return Font_t;

  function OpenFontIndex
   (File      : String;
    Point_Size : Integer;
    Index     : Long_Integer)
    return      Font_t;

  function OpenFontRW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : Integer;
    Point_Size : Integer)
    return      Font_t;

  function OpenFontIndexRW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : Integer;
    Point_Size : Integer;
    Index     : Long_Integer)
    return      Font_t;

  function Open_Font (File : String; Point_Size : Integer) return Font_t renames OpenFont;

  function Open_Font_Index
   (File      : String;
    Point_Size : Integer;
    Index     : Long_Integer)
    return      Font_t renames OpenFontIndex;

  function Open_Font_RW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : Integer;
    Point_Size : Integer)
    return      Font_t renames OpenFontRW;

  function Open_Font_Index_RW
   (Source       : RWops.RWops_Access_t;
    Free_Source   : Integer;
    Point_Size : Integer;
    Index     : Long_Integer)
    return      Font_t renames OpenFontIndexRW;

  pragma Inline (OpenFont);
  pragma Inline (OpenFontIndex);
  pragma Inline (OpenFontRW);
  pragma Inline (OpenFontIndexRW);

  --
  -- Set and retrieve the font style.
  -- This font style is implemented by modifying the font glyphs, and
  -- doesn't reflect any inherent properties of the truetype font file.
  --

  Style_Normal    : constant := 2#00000000#;
  Style_Bold      : constant := 2#00000001#;
  Style_Italic    : constant := 2#00000010#;
  Style_Underline : constant := 2#00000100#;

  function GetFontStyle (Font : Font_t) return C.int;
  function Get_Font_Style (Font : Font_t) return C.int renames GetFontStyle;
  procedure SetFontStyle (Font : Font_t; Style : C.int);
  procedure Set_Font_Style (Font : Font_t; Style : C.int) renames SetFontStyle;
  pragma Import (C, GetFontStyle, "TTF_GetFontStyle");
  pragma Import (C, SetFontStyle, "TTF_SetFontStyle");

  --
  -- Get the total height of the font - usually equal to point size
  --
  function FontHeight (Font : Font_t) return C.int;
  function Font_Height (Font : Font_t) return C.int renames FontHeight;
  pragma Import (C, FontHeight, "TTF_FontHeight");

  function FontHeight (Font : Font_t) return Integer;
  function Font_Height (Font : Font_t) return Integer renames FontHeight;
  pragma Inline (FontHeight);

  --
  -- Get the offset from the baseline to the top of the font
  -- This is a positive value, relative to the baseline.
  --
  function FontAscent (Font : Font_t) return C.int;
  function Font_Ascent (Font : Font_t) return C.int renames FontAscent;
  pragma Import (C, FontAscent, "TTF_FontAscent");

  function FontAscent (Font : Font_t) return Integer;
  function Font_Ascent (Font : Font_t) return Integer renames FontAscent;
  pragma Inline (FontAscent);

  --
  -- Get the offset from the baseline to the bottom of the font
  -- This is a negative value, relative to the baseline.
  --
  function FontDescent (Font : Font_t) return C.int;
  function Font_Descent (Font : Font_t) return C.int renames FontDescent;
  pragma Import (C, FontDescent, "TTF_FontDescent");

  function FontDescent (Font : Font_t) return Integer;
  function Font_Descent (Font : Font_t) return Integer renames FontDescent;
  pragma Inline (FontDescent);

  --
  -- Get the recommended spacing between lines of text for this font
  --
  function FontLineSkip (Font : Font_t) return C.int;
  function Font_Line_Skip (Font : Font_t) return C.int renames FontLineSkip;
  pragma Import (C, FontLineSkip, "TTF_FontLineSkip");

  function FontLineSkip (Font : Font_t) return Integer;
  function Font_Line_Skip (Font : Font_t) return Integer renames FontLineSkip;
  pragma Inline (FontLineSkip);

  --
  -- Get the number of faces of the font
  --
  function FontFaces (Font : Font_t) return C.long;
  function Font_Faces (Font : Font_t) return C.long renames FontFaces;
  pragma Import (C, FontFaces, "TTF_FontFaces");

  function FontFaces (Font : Font_t) return Long_Integer;
  function Font_Faces (Font : Font_t) return Long_Integer renames FontFaces;
  pragma Inline (FontFaces);

  --
  -- Get the font face attributes, if any.
  --
  function FontFaceIsFixedWidth (Font : Font_t) return C.int;
  function FontFaceFamilyName (Font : Font_t) return CS.chars_ptr;
  function FontFaceStyleName (Font : Font_t) return CS.chars_ptr;
  function Font_Face_Is_Fixed_Width (Font : Font_t) return C.int renames FontFaceIsFixedWidth;
  function Font_Face_Family_Name (Font : Font_t) return CS.chars_ptr renames FontFaceFamilyName;
  function Font_Face_Style_Name (Font : Font_t) return CS.chars_ptr renames FontFaceStyleName;
  pragma Import (C, FontFaceIsFixedWidth, "TTF_FontFaceIsFixedWidth");
  pragma Import (C, FontFaceFamilyName, "TTF_FontFaceFamilyName");
  pragma Import (C, FontFaceStyleName, "TTF_FontFaceStyleName");

  function FontFaceIsFixedWidth (Font : Font_t) return Boolean;
  function FontFaceFamilyName (Font : Font_t) return String;
  function FontFaceStyleName (Font : Font_t) return String;
  function Font_Face_Is_Fixed_Width (Font : Font_t) return Boolean renames FontFaceIsFixedWidth;
  function Font_Face_Family_Name (Font : Font_t) return String renames FontFaceFamilyName;
  function Font_Face_Style_Name (Font : Font_t) return String renames FontFaceStyleName;
  pragma Inline (FontFaceIsFixedWidth);
  pragma Inline (FontFaceFamilyName);
  pragma Inline (FontFaceStyleName);

  --
  -- Get the metriCS (dimensions) of a glyph
  -- To understand what these metriCS mean, here is a useful link :
  -- http ://freetype.sourceforge.net/freetype2/doCS/tutorial/step2.html
  --
  function GlyphMetrics
   (Font       : Font_t;
    Char_Value : SDL.Uint16_t;
    Min_X      : access C.int;
    Max_X      : access C.int;
    Min_Y      : access C.int;
    Max_Y      : access C.int;
    Advance    : access C.int)
    return       C.int;
  function Glyph_Metrics
   (Font       : Font_t;
    Char_Value : SDL.Uint16_t;
    Min_X      : access C.int;
    Max_X      : access C.int;
    Min_Y      : access C.int;
    Max_Y      : access C.int;
    Advance    : access C.int)
    return       C.int renames GlyphMetrics;
  pragma Import (C, GlyphMetrics, "TTF_GlyphMetrics");

  function GlyphMetrics
   (Font       : Font_t;
    Char_Value : Wide_Character;
    Min_X      : access Integer;
    Max_X      : access Integer;
    Min_Y      : access Integer;
    Max_Y      : access Integer;
    Advance    : access Integer)
    return       Boolean;

  function Glyph_Metrics
   (Font       : Font_t;
    Char_Value : Wide_Character;
    Min_X      : access Integer;
    Max_X      : access Integer;
    Min_Y      : access Integer;
    Max_Y      : access Integer;
    Advance    : access Integer)
    return       Boolean renames GlyphMetrics;
  pragma Inline (GlyphMetrics);

  --
  -- Get the dimensions of a rendered string of text
  --
  function SizeText
   (Font   : Font_t;
    Text   : CS.chars_ptr;
    Width  : access C.int;
    Height : access C.int)
    return   C.int;

  function SizeUTF8
   (Font   : Font_t;
    Text   : CS.chars_ptr;
    Width  : access C.int;
    Height : access C.int)
    return   C.int;

  function SizeUnicode
   (Font   : Font_t;
    Text   : CS.chars_ptr;
    Width  : access C.int;
    Height : access C.int)
    return   C.int;

  function Size_Text
   (Font   : Font_t;
    Text   : CS.chars_ptr;
    Width  : access C.int;
    Height : access C.int)
    return   C.int renames SizeText;

  function Size_UTF8
   (Font   : Font_t;
    Text   : CS.chars_ptr;
    Width  : access C.int;
    Height : access C.int)
    return   C.int renames SizeUTF8;

  function Size_Unicode
   (Font   : Font_t;
    Text   : CS.chars_ptr;
    Width  : access C.int;
    Height : access C.int)
    return   C.int renames SizeUnicode;

  pragma Import (C, SizeText, "TTF_SizeText");
  pragma Import (C, SizeUTF8, "TTF_SizeUTF8");
  pragma Import (C, SizeUnicode, "TTF_SizeUnicode");

  function SizeText
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean;

  function SizeUTF8
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean;

  function SizeUnicode
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean;

  function Size_Text
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean renames SizeText;

  function Size_UTF8
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean renames SizeUTF8;

  function Size_Unicode
   (Font   : Font_t;
    Text   : String;
    Width  : access Integer;
    Height : access Integer)
    return   Boolean renames SizeUnicode;

  pragma Inline (SizeText);
  pragma Inline (SizeUTF8);
  pragma Inline (SizeUnicode);

  --
  -- Create an 8-bit palettized surface and render the given text at
  -- fast quality with the given font and color.  The 0 pixel is the
  -- colorkey, giving a transparent background, and the 1 pixel is set
  -- to the text color.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function RenderText_Solid
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t;

  function RenderUTF8_Solid
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t;

  function RenderUnicode_Solid
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t;

  function Render_Text_Solid
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderText_Solid;

  function Render_Utf8_Solid
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUTF8_Solid;

  function Render_Unicode_Solid
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUnicode_Solid;

  pragma Import (C, RenderText_Solid, "TTF_RenderText_Solid");
  pragma Import (C, RenderUTF8_Solid, "TTF_RenderUTF8_Solid");
  pragma Import (C, RenderUnicode_Solid, "TTF_RenderUnicode_Solid");

  function RenderText_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t;

  function RenderUTF8_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t;

  function RenderUnicode_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t;

  function Render_Text_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderText_Solid;

  function Render_Utf8_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUTF8_Solid;

  function Render_Unicode_Solid
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUnicode_Solid;

  pragma Inline (RenderText_Solid);
  pragma Inline (RenderUTF8_Solid);
  pragma Inline (RenderUnicode_Solid);

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- fast quality with the given font and color.  The 0 pixel is the
  -- colorkey, giving a transparent background, and the 1 pixel is set
  -- to the text color.  The glyph is rendered without any padding or
  -- centering in the X direction, and aligned normally in the Y direction.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Solid
   (Font       : Font_t;
    Glyph      : SDL.Uint16_t;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function Render_Glyph_Solid
   (Font       : Font_t;
    Glyph      : SDL.Uint16_t;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderGlyph_Solid;
  pragma Import (C, RenderGlyph_Solid, "TTF_RenderGlyph_Solid");

  function RenderGlyph_Solid
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function Render_Glyph_Solid
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderGlyph_Solid;
  pragma Inline (RenderGlyph_Solid);

  --
  -- Create an 8-bit palettized surface and render the given text at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function RenderText_Shaded
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function RenderUTF8_Shaded
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function RenderUnicode_Shaded
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function Render_Text_Shaded
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderText_Shaded;
  function Render_Utf8_Shaded
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderUTF8_Shaded;
  function Render_Unicode_Shaded
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderUnicode_Shaded;
  pragma Import (C, RenderText_Shaded, "TTF_RenderText_Shaded");
  pragma Import (C, RenderUTF8_Shaded, "TTF_RenderUTF8_Shaded");
  pragma Import (C, RenderUnicode_Shaded, "TTF_RenderUnicode_Shaded");

  function RenderText_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function RenderUTF8_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function RenderUnicode_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function Render_Text_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderText_Shaded;
  function Render_Utf8_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderUTF8_Shaded;
  function Render_Unicode_Shaded
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderUnicode_Shaded;
  pragma Inline (RenderText_Shaded);
  pragma Inline (RenderUTF8_Shaded);
  pragma Inline (RenderUnicode_Shaded);

  --
  -- Create an 8-bit palettized surface and render the given glyph at
  -- high quality with the given font and colors.  The 0 pixel is background,
  -- while other pixels have varying degrees of the foreground color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Shaded
   (Font       : Font_t;
    Glyph      : SDL.Uint16_t;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function Render_Glyph_Shaded
   (Font       : Font_t;
    Glyph      : SDL.Uint16_t;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderGlyph_Shaded;
  pragma Import (C, RenderGlyph_Shaded, "TTF_RenderGlyph_Shaded");

  function RenderGlyph_Shaded
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t;
  function Render_Glyph_Shaded
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t;
    Background : Color_t)
    return       Video.Surface_Access_t renames RenderGlyph_Shaded;
  pragma Inline (RenderGlyph_Shaded);

  --
  -- Create a 32-bit ARGB surface and render the given text at high quality,
  -- using alpha blending to dither the font with the given color.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function RenderText_Blended
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function RenderUTF8_Blended
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function RenderUnicode_Blended
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function Render_Text_Blended
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderText_Blended;
  function Render_Utf8_Blended
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUTF8_Blended;
  function Render_Unicode_Blended
   (Font       : Font_t;
    Text       : CS.chars_ptr;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUnicode_Blended;
  pragma Import (C, RenderText_Blended, "TTF_RenderText_Blended");
  pragma Import (C, RenderUTF8_Blended, "TTF_RenderUTF8_Blended");
  pragma Import (C, RenderUnicode_Blended, "TTF_RenderUnicode_Blended");

  function RenderText_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function RenderUTF8_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function RenderUnicode_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function Render_Text_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderText_Blended;
  function Render_Utf8_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUTF8_Blended;
  function Render_Unicode_Blended
   (Font       : Font_t;
    Text       : String;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderUnicode_Blended;
  pragma Inline (RenderText_Blended);
  pragma Inline (RenderUTF8_Blended);
  pragma Inline (RenderUnicode_Blended);

  --
  -- Create a 32-bit ARGB surface and render the given glyph at high quality,
  -- using alpha blending to dither the font with the given color.
  -- The glyph is rendered without any padding or centering in the X
  -- direction, and aligned normally in the Y direction.
  -- This function return s the new surface, or NULL if there was an error.
  --
  function RenderGlyph_Blended
   (Font       : Font_t;
    Glyph      : SDL.Uint16_t;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function Render_Glyph_Blended
   (Font       : Font_t;
    Glyph      : SDL.Uint16_t;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderGlyph_Blended;
  pragma Import (C, RenderGlyph_Blended, "TTF_RenderGlyph_Blended");

  function RenderGlyph_Blended
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t)
    return       Video.Surface_Access_t;
  function Render_Glyph_Blended
   (Font       : Font_t;
    Glyph      : Wide_Character;
    Foreground : Color_t)
    return       Video.Surface_Access_t renames RenderGlyph_Blended;
  pragma Inline (RenderGlyph_Blended);

  --
  -- Close an opened font file
  --
  procedure CloseFont (Font : Font_t);
  procedure Close_Font (Font : Font_t) renames CloseFont;
  pragma Import (C, CloseFont, "TTF_CloseFont");

  --
  -- De-initialize the TTF engine
  --
  procedure Quit;
  pragma Import (C, Quit, "TTF_Quit");

  --
  -- Check if the TTF engine is initialized
  --
  function WasInit return  C.int;
  function Was_Init return  C.int renames WasInit;
  pragma Import (C, WasInit, "TTF_WasInit");

  function WasInit return Boolean;
  function Was_Init return Boolean renames WasInit;
  pragma Inline (WasInit);

end SDL.TTF;
