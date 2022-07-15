defmodule Pac do
  @doc """
    Pac.play() to start the game and you and computer play Rock/paper/scissors
  """
  def play do
    user = user()
    cpu = Enum.random(['r', 'p', 's'])

    cond do
      user == cpu -> "It's tie 'against #{cpu}' "
      is_win?(user, cpu) -> "Yeeh, you won against '#{cpu}' "
      is_win?(cpu, user) -> " you loose !against '#{cpu}' "
    end
  end

  def user,
    do:
      IO.gets("Enter 'p' for paper ,'s' Scissors or 'r' for rock :")
      |> String.trim()
      |> String.to_charlist()

  def is_win?(p1, p2),
    do:
      if((p1 == 'r' and p2 == 's') or (p1 == 's' and p2 == 'p') or (p1 == 'p' and p2 == 'r'),
        do: true
      )
end
