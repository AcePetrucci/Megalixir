defmodule CollapseCompositionTitle do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <h4 class="title">
      <%= @inner_content.(assigns) %>
    </h4>
    """
  end
end
