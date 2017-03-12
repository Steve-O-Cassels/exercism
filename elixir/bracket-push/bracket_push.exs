defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @open_brackets ["{", "[", "("]
  @close_brackets ["}", "]", ")"]

  @closed_bracket_map %{
    "}" => "{",
    "]" => "[",
    ")" => "("
  }

  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.trim
    |> String.codepoints
    |> trim_non_brackets
    |> is_valid_bracket_pattern?
  end

  defp is_valid_bracket_pattern?(input) do
     result = input |> match_brackets
     length(result) == 0
  end

  defp trim_non_brackets(input) do
    brackets = @open_brackets ++ @close_brackets
    input |> Enum.filter(&(&1 in brackets))
  end

  defp match_brackets(input) do
    Enum.reduce(input, [], fn(x, acc) ->
      with true <- is_open_bracket?(x) do
        acc ++ [x]
      else
        false ->
          case @closed_bracket_map[x] === List.last(acc) do
            true -> acc = pop(acc)
            _ -> acc ++ [x]
          end
      end
    end)
  end

  defp pop(state) do
    List.delete_at(state, -1)
  end

  defp is_open_bracket?(c) do
    c in @open_brackets
  end
end
