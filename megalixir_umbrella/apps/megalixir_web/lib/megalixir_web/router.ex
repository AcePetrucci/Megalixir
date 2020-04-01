defmodule MegalixirWeb.Router do
  use MegalixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MegalixirWeb do
    pipe_through :browser

    get "/", ExampleController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MegalixirWeb do
  #   pipe_through :api
  # end
end
