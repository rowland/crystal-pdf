module PDF
  PS_LETTER = {612, 792}
  PS_LEGAL  = {612, 1008}
  PS_LEDGER = {1224, 792}
  PS_11X17  = {792, 1224}
  PS_A0     = {2380, 3368}
  PS_A1     = {1684, 2380}
  PS_A2     = {1190, 1684}
  PS_A3     = {842, 1190}
  PS_A4     = {595, 842}
  PS_A5     = {421, 595}
  PS_A6     = {297, 421}
  PS_B5     = {499, 708}
  PS_C5     = {459, 649}

  PS_DEFAULT = "letter"

  PAGE_SIZES = Hash(String, Tuple(Int32, Int32)){
    "letter" => PS_LETTER,
    "legal"  => PS_LEGAL,
    "ledger" => PS_LEDGER,
    "A0"     => PS_A0,
    "A1"     => PS_A1,
    "A2"     => PS_A2,
    "A3"     => PS_A3,
    "A4"     => PS_A4,
    "A5"     => PS_A5,
    "A6"     => PS_A6,
    "B5"     => PS_B5,
    "C5"     => PS_C5,
  }
end
