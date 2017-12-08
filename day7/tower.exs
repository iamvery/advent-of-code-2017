defmodule Tower do
  @program ~r/(?<name>\w{4}) \((?<weight>\d+)\)( -> (?<children>.*))?/

  def parse(data) do
    data
      |> lines
      |> Enum.map(&parse_line/1)
  end

  defp lines(s), do: String.split(s, "\n")
  defp parse_line(line), do: Regex.named_captures(@program, line) |> format

  defp format(%{"name" => name, "weight" => weight, "children" => children}) do
    weight = String.to_integer(weight)
    children = String.split(children, ", ", trim: true)
    {name, weight, children}
  end
end

ExUnit.start

defmodule TestTest do
  use ExUnit.Case

  test "parse" do
    data = "pbga (66)"
    assert Tower.parse(data) |> hd == {"pbga", 66, []}

    data = "fwft (72) -> ktlj, cntj, xhth"
    assert Tower.parse(data) |> hd == {"fwft", 72, ["ktlj", "cntj", "xhth"]}
  end
end
