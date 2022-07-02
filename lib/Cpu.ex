defmodule CPU do

  @doc """
    CPU.play() to start the game and you a computer makes a guess and you give back
    instructions 'l' for low , 'b' for big or 'c' for correct answer.
  """
  @high 1000
  defstruct low: 1, high: @high

  def play do
    IO.puts("game will start ; pick a number from 1 to #{@high}")
    Process.sleep(2000)
    new_range = new_range()
    random = random(new_range)
    print(random)
    compare(random, new_range)
  end

  def new_range,
    do:
      %CPU{}

  def random(struct),
    do:
      Enum.random(struct.low..struct.high)

  def print(val),
    do:
      IO.puts("I guess it's #{val}")

  def feedback ,
    do:
      IO.gets("enter feedback 'c' correct 'l' low 'b' big: ")
      |> String.trim()
      |> String.downcase()

  def compare(random, new_range) do
    feedback = feedback()

    case feedback do
      "c" ->
        "Yeeeh, you've guessed right!"

      "l" ->
        new_range = %{new_range | high: random - 1}
        repeated(new_range)

      "b" ->
        new_range = %{new_range | low: random + 1}
        repeated(new_range)

      _ ->
        :error
    end
  end

  defp repeated(new_range) do
    new_random = random(new_range)
    print(new_random)
    compare(new_random, new_range)
  end
end
