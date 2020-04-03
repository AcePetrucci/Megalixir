defmodule CollapseCompositionDescription do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <p class="description">
      <%= @inner_content.(assigns) %>
    </p>
    """
  end
end
