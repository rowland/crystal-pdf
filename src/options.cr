module PDF
  class Options < Hash(String, String | Int32 | Float64)
    def get(key : String, default : String) : String
      case value = self[key]?
      when String
        value
      when Int32
        value.to_s
      when Float64
        value.to_s
      else
        default
      end
    end

    def get(key : String, default : Int32) : Int32
      case value = self[key]?
      when String
        value.to_i? || default
      when Int32
        value
      when Float64
        value.to_i
      else
        default
      end
    end

    def get(key : String, default : Float64) : Float64
      case value = self[key]?
      when String
        value.to_f? || default
      when Int32
        value.to_f
      when Float64
        value
      else
        default
      end
    end
  end
end
