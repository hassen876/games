defmodule Hang.Disp do
  def correct(letter),
    do: IO.ANSI.color_background(0, 2, 1) <> " #{letter} " <> IO.ANSI.reset()

  def warn(letter),
    do: IO.ANSI.color_background(5, 3, 1) <> " #{letter} " <> IO.ANSI.reset()

  def normal(letter),
    do: IO.ANSI.color_background(3, 3, 3) <> " #{letter} " <> IO.ANSI.reset()

  def error(letter),
    do: IO.ANSI.color_background(5, 1, 1) <> " #{letter} " <> IO.ANSI.reset()
end
