require "pdflib"
require "./color"
require "./defaults"
require "./options"
require "./point"

module PDF
  class Writer
    @auto_path = true
    @doc : PDFlib::PDF*
    @in_doc = false
    @in_page = false
    @in_path = false
    @in_text = false
    @loc = {0.0, 0.0}
    @last_loc = {0.0, 0.0}
    @options = Options{
      "page_size" => PS_DEFAULT,
    }
    @page_count = 0
    @page_width : Float64
    @page_height : Float64
    @units = "pt"

    def initialize(@filename = "")
      @doc = PDFlib.new
      PDFlib.set_option(@doc, "errorpolicy=return")
      @page_width, @page_height = PAGE_SIZES[PS_DEFAULT]
    end

    def open(options = Options.new)
      raise Exception.new("Already in document") if @in_doc
      @options.merge!(options)
      result = PDFlib.begin_document(@doc, @filename, 0, "")
      if result != 1
        errmsg = String.new(PDFlib.get_errmsg(@doc))
        raise Exception.new(errmsg)
      end
      PDFlib.set_option(@doc, "compress=0")
      @in_doc = true
    end

    def close
      if @page_count == 0 # empty document needs at least one page
        open_page
      end
      close_page if @in_page
      if @in_doc
        PDFlib.end_document(@doc, "")
        if @filename == ""
          buf = PDFlib.get_buffer(@doc, out size)
          @to_s = String.new(buf, size)
        end
        @in_doc = false
      end
    end

    def open_page(options = Options.new)
      open unless @in_doc
      raise Exception.new("Already in page") if @in_page
      @options.merge!(options)

      page_size = @options["page_size"]
      @page_width, @page_height = PAGE_SIZES[page_size]? || PAGE_SIZES[PS_DEFAULT]
      if @options.get("orientation", "portrait") == "landscape"
        @page_width, @page_height = @page_height, @page_width
      end
      @page_width = @options.get("page_width", @page_width)
      @page_height = @options.get("page_height", @page_height)

      PDFlib.begin_page_ext(@doc, @page_width, @page_height, "")
      @in_page = true
      @page_count += 1
    end

    def close_page
      raise Exception.new("Not in page") unless @in_page
      end_text
      end_graph

      PDFlib.end_page_ext(@doc, "")
      @in_page = false
    end

    @to_s : String | Nil

    def to_s : String
      close
      @to_s || ""
    end

    def to_s(io : IO) : Nil
      io << to_s
    end

    # def add_font(family : String, options : Options) # ([]*font.Font, error)
    # end

    private def end_graph
      end_path if @in_path
      @in_graph = false
    end

    private def end_path
      if @auto_path
        PDFlib.stroke(@doc)
      end
      @in_path = false
    end

    private def end_text
    end

    private def flush_text
    end

    def font_color : Color
    end

    # def fonts : Array(Font) # []*font.Font
    # end

    def font_size : Float64
    end

    private def from_points(units : String, measurement : Float64) : Float64
      measurement / (UNIT_CONVERSION[units]? || 1.0)
    end

    def line_cap_style : LineCapStyle
    end

    def line_color : Color
    end

    def line_dash_pattern : String
    end

    def line_spacing : Float64
    end

    def line_to(p : Point) : Nil
      line_to(p[0], p[1])
    end

    def line_to(x : Float64, y : Float64) : Nil
      x, y = to_points(units, x), to_points(units, y)
      line_to_internal(x, translate(y))
    end

    private def line_to_internal(x : Float64, y : Float64) : Nil
      unless @last_loc == @loc
        if @in_path && @auto_path
          PDFlib.stroke(@doc)
        end
        @in_path = false
      end
      # check_set_line_color
      # check_set_line_width
      # check_set_line_dash_pattern

      start_graph unless @in_graph
      unless @in_path
        PDFlib.moveto(@doc, @loc[0], @loc[1])
      end
      move_to_internal(x, y)
      PDFlib.lineto(@doc, @loc[0], @loc[1])
      @in_path = true
      @last_loc = @loc
    end

    def line_width(units : String) : Float64
    end

    def move_to(x : Float64, y : Float64) : Nil
      x, y = to_points(units, x), to_points(units, y)
      move_to_internal(x, translate(y))
    end

    def move_to(p : Point) : Nil
      move_to(p[0], p[1])
    end

    private def move_to_internal(x : Float64, y : Float64) : Nil
      flush_text
      @loc = {x, y}
      @line_height = 0
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
      @page_height
    end

    def pages_up : Int32
    end

    def page_width : Float64
      @page_width
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

    def set_units(units : String) : String
      prev, @units = @units, units
      prev
    end

    private def start_graph
      raise Exception.new("Already in graph") if @in_graph
      open_page unless @in_page
      end_text if @in_text
      @last_loc = {0.0, 0.0}
      @in_graph = true
    end

    def strikeout : Bool
    end

    private def to_points(units : String, measurement : Float64) : Float64
      (UNIT_CONVERSION[units]? || 1.0) * measurement
    end

    private def translate(y : Float64) : Float64
      @page_height - y
    end

    def underline : Bool
    end

    getter units : String

    def x : Float64
      from_points(units, @loc[0])
    end

    def y : Float64
      from_points(units, translate(@loc[1]))
    end
  end
end
