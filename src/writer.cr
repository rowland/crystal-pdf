require "pdflib"
require "./color"
require "./defaults"
require "./options"
require "./point"

module PDF
  class Writer
    @doc : PDFlib::PDF*
    @page_count = 0
    @in_doc = false
    @in_page = false
    @options = Options{
      "page_size" => PS_DEFAULT,
    }

    def initialize(@filename = "")
      @doc = PDFlib.new
      PDFlib.set_option(@doc, "errorpolicy=return")
    end

    def open(options = Options.new)
      raise Exception.new("Already in document") if @in_doc
      @options.merge!(options)
      result = PDFlib.begin_document(@doc, @filename, 0, "")
      if result != 1
        errmsg = String.new(PDFlib.get_errmsg(@doc))
        raise Exception.new(errmsg)
      end
      @in_doc = true
    end

    def close
      if @page_count == 0 # empty document needs at least one page
        open
        open_page
      end
      close_page if @in_page
      PDFlib.end_document(@doc, "") if @in_doc
      @in_doc = false
    end

    def open_page(options = Options.new)
      raise Exception.new("Already in page") if @in_page
      @options.merge!(options)
      page_size = @options["page_size"]
      width, height = PAGE_SIZES[page_size]? || PAGE_SIZES[PS_DEFAULT]
      PDFlib.begin_page_ext(@doc, width, height, "")
      @in_page = true
      @page_count += 1
    end

    def close_page
      raise Exception.new("Not in page") unless @in_page
      PDFlib.end_page_ext(@doc, "")
      @in_page = false
    end

    @to_s : String | Nil

    def to_s : String
      @to_s ||= begin
        close
        buf = PDFlib.get_buffer(@doc, out size)
        s = String.new(buf, size)
        PDFlib.delete(@doc)
        s
      end
    end

    def to_s(io : IO) : Nil
      io << to_s
    end

    # def add_font(family : String, options : Options) # ([]*font.Font, error)
    # end

    def font_color : Color
    end

    # def fonts : Array(Font) # []*font.Font
    # end

    def font_size : Float64
    end

    def line_cap_style : LineCapStyle
    end

    def line_color : Color
    end

    def line_dash_pattern : String
    end

    def line_spacing : Float64
    end

    def line_to(x : Float64, y : Float64) : Nil
    end

    def line_width(units : String) : Float64
    end

    def loc : Point
    end

    def move_to(x, y float64) : Nil
    end

    def move_to(p : Point) : Nil
    end

    def new_page
    end

    def new_page(options : Options)
    end

    def pages_across : Int32
    end

    def pages_down : Int32
    end

    def page_height : Float64
    end

    def pages_up : Int32
    end

    def page_width : Float64
    end

    def print(text : String)
    end

    # print_paragraph(para []*rich_text.RichText, options options.Options)
    # print_rich_text(text *rich_text.RichText)

    def rectangle(x : Float64, y : Float64,
                  width : Float64, height : Float64,
                  border : Bool, fill : Bool)
    end

    def rectangle(x : Float64, y : Float64,
                  width : Float64, height : Float64,
                  border : Bool, fill : Bool,
                  corners : Array(Float64),
                  path : Bool, reverse : Bool)
    end

    def set_font(name : String, size : Float64, options : Options) # ([]*font.Font, error)
    end

    def set_fill_color(color : Color) : Color
    end

    def set_font(name : String, size : Float64, options : Options) # ([]*font.Font, error)
    end

    def set_font_color(color : Color) : Color
    end

    def set_font_size(size : Float64) : Float64
    end

    def set_font_style(style : String) : String
    end

    def set_line_color(color : Color) : Color
    end

    def set_line_dash_pattern(pattern : String)
    end

    def set_line_spacing(line_spacing : Float64) : Float64
    end

    def set_line_width(width : Float64) : Float64
    end

    def set_options(options : Options)
    end

    def set_strikeout(strikeout : Bool) : Bool
    end

    def set_underline(underline : Bool) : Bool
    end

    def set_units(units : String)
    end

    def strikeout : Bool
    end

    def underline : Bool
    end

    def x : Float64
    end

    def y : Float64
    end
  end
end
