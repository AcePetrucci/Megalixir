defmodule MegalixirWeb.Live.Example do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <link rel="stylesheet" href="/css/example.page.css" />

    <section class="example-page">
      <%= live_component(
        @socket,
        Collapse,
        title: "Collapse Without Composition",
        description: "This is a Collapse component made without composition. This means that all this data is being passed down as properties inside the Collapse component. Of course, it has its own advantages and disadvantages.",
      ) %>

      <%= live_component(@socket, CollapseComposition) do %>
        <%= live_component(@socket, CollapseCompositionTitle) do %>
          Collapse With Composition
        <% end %>

        <%= live_component(@socket, CollapseCompositionDescription) do %>
          <span> This is a Collapse component made with composition. Component Composition basically means to compose a component (heh) using tiny micro-components. The main advantage is flexibility. </span>

          <span> In a component without composition, any new changes you'd want to make has to be passed down as properties. If it's a small component, that's fine, but in large components it can get very polluted. </span>

          <span> A composable component can be modified and adapted no matter the feature, and it won't impact the component usage in other places, and so maintenance is easier. </span>
        <% end %>
      <% end %>
    </section>

    <script src="/js/example.page.js"> </script>
    """
  end
end
