defmodule Hangman do
  @moduledoc """
    start Hangman game with Hangman.play() ,the default level is 0 you will start with 3 letters easy !!!
      level 0 -> words with 3 letters
      level 1 -> words with 4 letters
      level 2 -> words with 5 letters
      level 3 -> words with 6 letters
      level 4 -> words with 7 letters
      level 5 -> words with 8 letters
      level 6 -> words with 9 letters
      level 7 -> words with 10 letters
      level 8 -> words with 11 letters
      level 9 -> words with 12 letters
      level 10 -> words with 13 letters
  """
  defstruct level: 0
  import Hangman.Data

  def play() do
    new = new()
    tup={}
    word = random_word(new.level)
    guess = user_input(new.level)
    IO.inspect({guess, word}, label: "development help ")
    compare(guess, word, tup, new)
  end

  def new(), do: %Hangman{}

  def is_equal?(w1, w2) do
    cond do
      w1 == w2 -> true
      w1 !== w2 -> false
    end
  end

  defguard check_length(tup) when tuple_size(tup)==6

  def compare(_guess, _word, tup, _new) when check_length(tup) ,do: :game_over
  def compare(guess, word, tup, new) do
    case is_equal?(guess, word) do
      true ->
        "Yeeh correct"

      false ->
        tup = Tuple.append(tup, guess)
        new_guess = user_input(new.level)
        IO.inspect({new_guess, tup}, label: "dev tools ")
        compare(new_guess, word, tup, new)
    end
  end

  def random_word(level \\ 0),
    do:
      data()
      |> Enum.filter(&(String.length(&1) == level + 3))
      |> Enum.random()
      |> String.upcase()

  def colorify(text, color) do
    IO.puts(IO.ANSI.format([color, text]))
  end

  def user_input(level) do
    user =
      IO.gets("try Hangman ,enter a word with #{level + 3} words: ")
      |> String.trim("\n")

    if String.length(user) == level + 3 do
      user |> String.upcase()
    else
      user_input(level)
    end
  end
end
