defmodule Megamind do
  use GenServer

  @moduledoc """
  Megamind is an example application to play around with GenServer and illustrate how they would work. 
  """

  def hard_worker(list) do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])

    :timer.tc(fn -> iterate_list(pid, list) end)
    |> format_string()
  end

  defp iterate_list(pid, [head | tail]) do
    GenServer.call(pid, {:read, head})
    Process.sleep(1_000)
    iterate_list(pid, tail)
  end

  defp iterate_list(pid, []) do
    GenServer.call(pid, {:read, nil})
  end

  defp format_string({time, list}) do
    time_to_complete = handle_time(time)

    "The list [#{Enum.join(list, ", ")}] took #{time_to_complete} seconds to complete."
  end

  defp handle_time(time) do
    time
    |> Kernel./(1_000_000)
  end

  @impl true
  def init(_arg) do
    {:ok, []}
  end

  @impl true
  def handle_call({:read, nil}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:read, val}, _from, state) do
    state = state ++ [val]
    {:reply, state, state}
  end
end
