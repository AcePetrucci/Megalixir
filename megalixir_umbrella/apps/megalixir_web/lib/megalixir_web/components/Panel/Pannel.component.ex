defmodule Pannel do
  use Surface.Component

  def render(assigns) do
    ~H"""
    <Button text="Shared Component"/>
    """
  end
end
