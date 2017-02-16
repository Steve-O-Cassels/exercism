defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([nil], []), do: :superlist
  def compare([],[nil]), do: :sublist
  def compare(a,b) when a == b, do: :equal
  def compare(a,b) when a != b and length(b) == 1, do: :unequal
  def compare(a,b) when a != b and length(a) == length(b), do: :unequal
  def compare(a,b) when length(a) > length(b) do
    case is_sublist(b,a) do
      :sublist -> :superlist
      _ -> :unequal
    end
  end
  def compare(a,b) when a != b do
    is_sublist(a,b)
  end

  defp is_sublist(a,b) do
    matches = sublist(a,a,b,b,acc = [])
    case length(matches) == length(a) do
      true -> :sublist
      _ -> :unequal
    end
  end

  defp sublist([],_,_,_,acc), do: acc
  defp sublist(_,_,[],_,acc), do: acc
  defp sublist([ahead|atail],a, [bhead|btail],b, acc) do
    non_match_start_next = fn ->
      next_b = List.delete_at(b, 0)
      sublist(a,a,next_b,next_b,[])
    end
    match_start_next = fn ->
      acc = List.insert_at(acc, 0, ahead)
      sublist(atail,a,btail,b,acc)
    end
    case ahead === bhead do
      false -> non_match_start_next.()
      true -> match_start_next.()
    end
  end
end
