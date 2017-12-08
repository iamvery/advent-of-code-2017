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

  def assemble(_programs) do
    #
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

  @tag :skip
  test "example 1" do
    data = """
    pbga (66)
    xhth (57)
    ebii (61)
    havc (66)
    ktlj (57)
    fwft (72) -> ktlj, cntj, xhth
    qoyq (66)
    padx (45) -> pbga, havc, qoyq
    tknk (41) -> ugml, padx, fwft
    jptl (61)
    ugml (68) -> gyxo, ebii, jptl
    gyxo (61)
    cntj (57)
    """ |> String.trim

    tower = data |> Tower.parse |> Tower.assemble
    {bottom, _weight, [{first_child, _weigh, _children} | _rest]} = tower

    assert bottom == "tknk"
    assert first_child == "ugml"
  end
end
