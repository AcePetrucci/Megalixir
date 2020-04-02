defmodule MegalixirWeb.Live.Example do
  use Surface.LiveView

  def render(assigns) do
    ~H"""
    <link rel="stylesheet" href="/css/example.component.css" />
    <script src="/js/example.component.js"> </script>

    <section class="example-page">
      <Button text="Generic Button" />
      <Pannel />
      <ExampleButton />
    </section>
    """
  end
end
