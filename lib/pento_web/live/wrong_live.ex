defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(
      socket,
      score: 0,
      message: "Make a guess:",
      finished?: false,
      target: Enum.random(1..10)
    )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <%= if @finished? do %>
      <a href="#" phx-click="retry"> Retry </a>
    <% else %>
      <h2>
        <%= for n <- 1..10 do %>
          <a href="#" phx-click="guess" phx-value-number={n}> <%= n %> </a>
        <% end %>
      </h2>
    <% end %>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {finished?, message} =
      if String.to_integer(guess) == socket.assigns.target do
        {true, "Your guess: #{guess}. You Win!"}
      else
        {false, "Your guess: #{guess}. Wrong. Guess again."}
      end
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(socket, message: message, score: score, finished?: finished?)
    }
  end

  def handle_event("retry", _, socket) do
    {:ok, socket} = mount(%{}, %{}, socket)
    {:noreply, socket}
  end
end
