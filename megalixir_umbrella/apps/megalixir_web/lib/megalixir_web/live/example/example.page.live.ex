defmodule MegalixirWeb.Live.Example do
  use Surface.LiveView

  def render(assigns) do
    ~H"""
    <link rel="stylesheet" href="/css/example.page.css" />
    <script src="/js/example.page.js"> </script>

    <section class="example-page">
      <Button text="Generic Button" />
      <ExampleButton />
    </section>
    """
  end
end
