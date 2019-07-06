module PDF
  PS_LETTER = {612, 792}
  PS_LEGAL  = {612, 1008}
  PS_A4     = {595, 842}
  PS_B5     = {499, 708}
  PS_C5     = {459, 649}

  PS_DEFAULT = "letter"

  PAGE_SIZES = Hash(String, Tuple(Int32, Int32)){
    "letter" => PS_LETTER,
    "legal"  => PS_LEGAL,
    "A4"     => PS_A4,
    "B5"     => PS_B5,
    "C5"     => PS_C5,
  }
end
