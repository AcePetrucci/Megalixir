defmodule CollapseComposition do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <div class="collapse-comp-composition" data-collapse-composition>
      <%= @inner_content.(assigns) %>
    </div>
    """
  end
end
