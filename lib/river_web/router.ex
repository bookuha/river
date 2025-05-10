defmodule RiverWeb.Router do
  use RiverWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", RiverWeb do
    pipe_through(:api)

    get("/ack", LogsController, :index)
    post("/logs", LogsController, :create)
  end
end
