defmodule Collapse do
  use Phoenix.LiveComponent

  def update(%{title: title, description: description} = _assigns, socket) do
    {:ok, assign(
      socket,
      title: title,
      description: description
    )}
  end

  def render(assigns) do
    ~L"""
    <div class="collapse-comp" data-collapse>
      <h4 class="title"> <%= @title %> </h4>

      <p class="description">
        <%= @description %>
      </p>
    </div>
    """
  end
end
