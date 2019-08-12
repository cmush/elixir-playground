defmodule LiveViewCounterWeb.CounterLive do
  use Phoenix.LiveView
  alias LiveViewCounterWeb.CounterView

  def render(assigns) do
    CounterView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :val, 0)}
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end
end
