defmodule ListOps do
  require Logger
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer

  def count([]), do: 0

  def count([_head | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse([]), do: []
  # def reverse([_a]), do: [_a]
  # def reverse([a, b]), do: [b, a]
  def reverse([head | []]) do
    Logger.info("head_empty")
    [head]
  end

  def reverse([head | tail]) do
    Logger.info("head_tail")
    reverse(tail)
  end

  @spec map(list, (any -> any)) :: list
  def map([], f), do: []
  def map([head | tail], f), do: [f.(head) | map(tail, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], f) do
    []
  end

  def filter([head | tail], f) do
    if f.(head) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, f) do
    acc
  end

  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
  end
end

list = [1, 2, 3]
IO.inspect(ListOps.reverse(list))
