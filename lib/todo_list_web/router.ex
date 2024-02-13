defmodule TodoListWeb.Router do
  use TodoListWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TodoListWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoListWeb do
    pipe_through :browser

    get "/", PageController, :home
    resources "/items", ItemController
    get "/items/toggle/:id", ItemController, :toggle
    get "/:filter", ItemController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoListWeb do
  #   pipe_through :api
  # end
end
