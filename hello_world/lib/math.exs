defmodule Math do
  def sum(a, b) do
    a + b
  end

  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false

  def sum_list([head|tail], accumulator) do
    sum_list(tail, head + accumulator)
  end
  def sum_list([], accumulator) do
    accumulator
  end

  def double_each([head|tail]) do
    [head * 2 | double_each(tail)]
  end
  def double_each([]) do
    []
  end
end
