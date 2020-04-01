defmodule MegalixirWeb.ExampleController do
  use MegalixirWeb, :controller
  import Phoenix.LiveView.Controller

  def index(conn, _params) do
    live_render(conn, MegalixirWeb.Live.Example)
  end
end
