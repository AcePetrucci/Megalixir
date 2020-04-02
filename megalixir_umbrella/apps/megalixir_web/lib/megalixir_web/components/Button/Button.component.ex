defmodule Button do
  use Surface.Component

  @doc "Inner Button Text"
  property text, :string

  def render(assigns) do
    ~H"""
    <button class="button-comp button is-primary" >
      {{ @text }}
    </button>
    """
  end
end
