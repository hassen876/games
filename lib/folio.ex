defmodule USER do
  @high 100
  def play do
    random = random()
    compare(random)
  end

  def random, do: Enum.random(1..@high)

  def guess do
    IO.gets("Enter a value between 1 and #{@high}: ")
    |> String.split("\n")
    |> List.first()
    |> String.to_integer()
  end

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
