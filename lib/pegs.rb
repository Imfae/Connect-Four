# Colored pegs
module Pegs
  def empty_peg
    "\u25ef"
  end

  def red_peg
    "\e[91m\u2b24\e[0m"
  end
  
  def blue_peg
    "\e[94m\u2b24\e[0m"
  end
end
