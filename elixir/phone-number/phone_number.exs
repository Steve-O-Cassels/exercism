defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    clean = fn(raw_list) ->
      dirty = ["(", ")", "-", ".", " "]
      raw_list
      |> String.codepoints
      |> Enum.filter(&(&1 in dirty |> Kernel.not))
    end
    has_letters = fn(raw_list) ->
      Enum.any?(raw_list, &(&1 === "a"))
    end

    error_response = fn() ->
      "0000000000"
    end

    process_numbers = fn(cleaned_list) ->
      number_list = cleaned_list |> Enum.map(&(String.to_integer(&1)))
      list_length = length(number_list)

      cond do
        list_length < 10 -> error_response.()
        list_length == 10 -> number_list |> Enum.join
        list_length == 11 ->
          case hd(number_list) do
             1 -> tl(number_list) |> Enum.join
             _ -> error_response.()
           end
      end
    end

    cleaned_list = raw |> clean.()
    cond do
      has_letters.(cleaned_list) -> error_response.()
      true -> process_numbers.(cleaned_list)
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw
  end
end
