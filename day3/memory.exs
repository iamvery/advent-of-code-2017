defmodule Memory do
  import :math

  # https://math.stackexchange.com/a/163101
  def coordinate(n) do
    k = ceil((sqrt(n)-1)/2) |> round
    t = 2*k+1
    m = t*t
    t = t-1

    if n >= m-t do
      {k-(m-n), -k}
    else
      m = m-t
      if n >= m-t do
        {-k, -k+(m-n)}
      else
        m = m-t
        if n >= m-t do
          {-k+(m-n), k}
        else
          {k, k-(m-n-t)}
        end
      end
    end
  end

  def spiral(_, _ \\ [])
  def spiral(0, l), do: l
  def spiral(n, l) do
    coord = coordinate(n)
    spiral(n-1, [coord | l])
  end

  # https://en.wikipedia.org/wiki/Taxicab_geometry
  def distance(n) do
    {x, y} = coordinate(n)
    abs(x) + abs(y)
  end
end

ExUnit.start

defmodule MemoryTest do
  use ExUnit.Case

  test "coordinates" do
    assert Memory.coordinate(1) == {0.0, 0.0}
    assert Memory.coordinate(11) == {2.0, 0.0}
    assert Memory.coordinate(18) == {-2.0, 1.0}
    assert Memory.coordinate(22) == {-1.0, -2.0}
  end

  test "spiral" do
    assert Memory.spiral(1) == [{0,0}]
    assert Memory.spiral(2) == [{0,0}, {1,0}]
    assert Memory.spiral(3) == [{0,0}, {1,0}, {1,1}]
  end

  test "example 1" do
    assert Memory.distance(1) == 0
    assert Memory.distance(12) == 3
    assert Memory.distance(23) == 2
    assert Memory.distance(1024) == 31
  end
end

input = 277678
IO.puts "The answer to part 1 is:"
IO.puts Memory.distance(input)
