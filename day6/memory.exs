defmodule Memory do
  def redistribute(banks, past \\ [], cycles \\ 1) do
    {max, index} = banks |> Enum.with_index |> Enum.max_by(fn ({blocks, _}) -> blocks end)
    banks = List.replace_at(banks, index, 0)
    banks = distribute(banks, max, index+1)

    if Enum.member?(past, banks) do
      {banks, cycles}
    else
      past = [banks | past]
      redistribute(banks, past, cycles + 1)
    end
  end

  defp distribute(banks, 0, _), do: banks
  defp distribute(banks, blocks, index) when index >= length(banks) do
    distribute(banks, blocks, 0)
  end
  defp distribute(banks, blocks, index) do
    banks = List.update_at(banks, index, &(&1+1))
    distribute(banks, blocks - 1, index + 1)
  end
end

ExUnit.start

defmodule MemoryTest do
  use ExUnit.Case

  test "example 1" do
    banks = [0, 2, 7, 0]
    {redistributed_banks, cycles} = Memory.redistribute(banks)

    assert redistributed_banks == [2, 4, 1, 2]
    assert cycles == 5
  end
end

input = [4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5]
IO.puts "The answer is:"
IO.inspect Memory.redistribute(input)
