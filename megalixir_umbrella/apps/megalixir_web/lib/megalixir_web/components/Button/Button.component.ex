defmodule Button do
  use Surface.Component

  def render(assigns) do
    ~H"""
    <button class="button-comp button is-primary" >
      {{ @inner_content.() }}
    </button>
    """
  end
end
