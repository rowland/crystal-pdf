module PDF
  PS_LETTER = {612.0, 792.0}
  PS_LEGAL  = {612.0, 1008.0}
  PS_LEDGER = {1224.0, 792.0}
  PS_11X17  = {792.0, 1224.0}
  PS_A0     = {2380.0, 3368.0}
  PS_A1     = {1684.0, 2380.0}
  PS_A2     = {1190.0, 1684.0}
  PS_A3     = {842.0, 1190.0}
  PS_A4     = {595.0, 842.0}
  PS_A5     = {421.0, 595.0}
  PS_A6     = {297.0, 421.0}
  PS_B5     = {499.0, 708.0}
  PS_C5     = {459.0, 649.0}

  PS_DEFAULT = "letter"

  PAGE_SIZES = Hash(String, Tuple(Float64, Float64)){
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
