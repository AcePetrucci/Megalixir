defmodule Button do
  use Surface.Component

  @doc "Inner Button Text"
  property text, :string

  def render(assigns) do
    ~H"""
    <link rel="stylesheet" href="/css/Button.component.css" />
    <script src="/js/Button.component.js"> </script>

    <button class="button-comp button is-primary" >
      {{ @text }}
    </button>
    """
  end
end
