defmodule SecretHandshake do
  use Bitwise

  @bsecrets %{
    0b00001 => "wink",
    0b00010 => "double blink",
    0b00100 => "close your eyes",
    0b01000 => "jump"
  }

  @secret_reverse 0b10000

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when band(@secret_reverse, code) == @secret_reverse do
    Enum.reverse(commands(rem(code, @secret_reverse)))
  end

  def commands(code) do
    @bsecrets
    |> Enum.filter(fn {key, _} -> band(key, code) == key end)
    |> Enum.map(fn {_, val} -> val end)
  end
end
