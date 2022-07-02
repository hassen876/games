defmodule USER do
  @doc """
    USER.play() to start the game and you make a guess and a computer gives you back
    instructions 'l' for low , 'b' for big or 'c' for correct answer.
  """
  @high 100
  def play do
    random = random()
    compare(random)
  end

  def random,
    do: Enum.random(1..@high)

  def guess,
    do:
      IO.gets("Enter a value between 1 and #{@high}: ")
      |> String.trim()
      |> String.to_integer()

  def compare(random) do
    guess = guess()

    cond do
      guess == random ->
        "Yeeh, you've guessed right."

      guess < random ->
        IO.puts("Noop, #{guess} is low, try again ")
        compare(random)

      guess > random ->
        IO.puts("Noop, #{guess} is high, try again ")
        compare(random)
    end
  end
end
