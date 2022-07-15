defmodule Hang do
  @moduledoc """
    start Hang game with Hangman.play() ,the default level is 0 you will start with 3 letters easy !!!
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
  defstruct level: 1, word: "", guess: "", guesses: {}, msg: ""
  import Hang.{Data,Disp}
  def play() do
    game = new_game()

    game
    |> guess_input()
    |> random_word()
    |> compare_guess_word()
  end
  def new_game(), do: %Hang{}
  def guess_input(%Hang{level: level, guesses: guesses} = game) do
    guess =
      IO.gets("try Hangman ,enter a word with #{game.level + 3} words: ")|> String.trim("\n")|>String.upcase()
      if String.length(guess) == level + 3 do
      %{game | guess: guess, guesses: Tuple.append(guesses, guess)}
    else
      guess_input(game)
    end
  end
  def compare_guess_word(%Hang{guesses: guesses, word: word, guess: guess})
      when tuple_size(guesses) == 7 and word !== guess,
      do: "#{error("GAME OVER ")} the word was :#{word}"|>IO.puts
  def compare_guess_word(%Hang{level: level,word: word, guess: guess, guesses: guesses} = game) do
    disp(game)
    case String.equivalent?(word, guess) do
      true ->
        level=level+1
        game=%{game | msg: :"YOU WIN", level: level,guesses: {} }
        user=IO.gets("Do you want to continue next level? 'y' for Yes 'n' for NO: ")|>String.trim("\n")|>String.to_charlist()
        case user do
          'y'-> game
                |> guess_input()
                |> random_word()
                |> compare_guess_word()
          'n' ->"Thanks for playing Hangman :-)"
        end
      false ->
        %Hang{guess: guess} = guess_input(game)
        game = %{game | guess: guess, guesses: Tuple.append(guesses, guess)}
        compare_guess_word(game)
    end
  end
  def random_word(%Hang{level: level} = game) do
    word =
      data()
      |> Enum.filter(&(String.length(&1) == level + 3))
      |> Enum.random()
      |> String.upcase()

    %{game | word: word}
  end

  def disp(%Hang{guess: guess, word: word}) do
    guess=String.codepoints(guess)|>Enum.with_index()
    word_list=String.codepoints(word)|>Enum.with_index()
    Enum.map(guess,fn {x,index}-> if Enum.at(guess,index)==Enum.at(word_list,index),
          do: correct(x), else: if (String.contains?(word,x) and Enum.at(guess,index) !==Enum.at(word_list,index)),
           do: warn(x), else: normal(x) end)
    |>Enum.join(" ")
    |>IO.puts
  end

end
