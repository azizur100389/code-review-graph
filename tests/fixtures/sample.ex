# sample.ex - Elixir test fixture for tree-sitter parsing
# Exercises modules (including nested), def/defp, imports, ExUnit tests,
# pipe operator, and Module.function calls.

defmodule Calculator do
  @moduledoc "A simple calculator module for fixture testing."

  alias Calculator.Helpers
  import Enum, only: [sum: 1]
  require Logger
  use GenServer

  @doc "Adds two integers."
  def add(a, b) do
    Logger.info("adding")
    Helpers.log("add called")
    a + b
  end

  # Short-form function definition
  def multiply(a, b), do: a * b

  # Public function using the pipe operator
  def sum_list(list) do
    list
    |> Enum.filter(fn x -> x > 0 end)
    |> Enum.sum()
  end

  # Private function
  defp private_helper(x) do
    x * 2
  end

  # Nested module
  defmodule Helpers do
    def log(msg) do
      IO.puts(msg)
    end

    def format_number(n), do: Integer.to_string(n)
  end
end

defmodule CalculatorTest do
  use ExUnit.Case

  alias Calculator

  test "adds two numbers" do
    assert Calculator.add(1, 2) == 3
  end

  test "multiplies numbers" do
    result = Calculator.multiply(2, 3)
    assert result == 6
  end

  test "sums positive numbers" do
    result = Calculator.sum_list([-1, 2, 3, -4, 5])
    assert result == 10
  end
end
