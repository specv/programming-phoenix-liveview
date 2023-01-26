defmodule PentoWeb.RedirectLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <p>
      <a href="/guess"> Redirect </a>
    </p>

    <%= live_redirect "Live Redirect", to: "/guess" %>
    """
  end
end
