defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.


  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @letters_indexed Enum.to_list(?a..?z)
                |> to_string
                |> String.codepoints
                |> Enum.with_index

  @letters_indexed_map @letters_indexed |> Enum.into(%{})

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    Enum.reduce(String.codepoints(text), "", fn(character, acc) ->
      cond do
        is_letter?(character) == true ->
          acc <> rotate_character(character, shift)
        true ->
          acc <> character
      end
    end)
  end

  defp is_letter?(character) do
    Map.has_key?(@letters_indexed_map, String.downcase(character))
  end

  defp rotate_character(character, shift) do
    character_lower_cased = String.downcase(character)
    %{^character_lower_cased => old_index} = @letters_indexed_map
    new_index = shift_value(old_index, shift)
    %{^new_index => new_letter} = indexed_letters_map()

    cond do
      character_lower_cased === character ->
        new_letter
      true ->
        String.upcase(new_letter)
    end
  end

  defp shift_value(index, by) do
    Integer.mod(index + by, length(@letters_indexed))
  end

  defp indexed_letters_map() do
    Enum.map(@letters_indexed, &(&1 |> Tuple.to_list |> Enum.reverse |> List.to_tuple))
    |> Enum.into(%{})
  end
end
