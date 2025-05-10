defmodule RiverWeb.LogsController do
  use RiverWeb, :controller

  def index(conn, _params) do
    json(conn, %{message: "Acknowledged"})
  end

  def create(conn, %{"owner" => owner, "timestamp" => timestamp, "job" => job}) do
    json(conn, %{owner: owner, timestamp: timestamp, job: job})
  end

  def create(conn, %{"timestamp" => timestamp}) do
    json(conn, %{timestamp: timestamp})
  end
end
