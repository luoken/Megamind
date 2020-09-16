defmodule Megamind do
  use GenServer

  @moduledoc """
  Documentation for `Megamind`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Megamind.hello()
      :world

  """
  def hard_worker(list) do
    {:ok, pid} = GenServer.start_link(__MODULE__, list)

    caller(pid, :read)
  end

  def caller(pid, func) do
    call = GenServer.call(pid, func)

    IO.inspect(call, label: "CALLER")

    case call do
      nil -> nil
      _ -> Process.sleep(1000)
    end

    caller(pid, func)
  end

  @impl true
  def init(list) do
    {:ok, list}
  end

  @impl true
  def handle_call(:read, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:read, _from, []) do
    {:stop, nil, []}
  end
end
