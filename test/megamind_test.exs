defmodule MegamindTest do
  use ExUnit.Case
  doctest Megamind

  test "greets the world" do
    assert Megamind.hello() == :world
  end
end
