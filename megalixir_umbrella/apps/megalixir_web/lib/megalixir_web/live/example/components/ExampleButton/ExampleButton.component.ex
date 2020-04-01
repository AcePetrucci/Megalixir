defmodule ExampleButton do
  use Surface.Component

  @doc "Inner Button Text"
  property text, :string

  def render(assigns) do
    ~H"""
    <Button text="Feature Component" />
    """
  end
end
