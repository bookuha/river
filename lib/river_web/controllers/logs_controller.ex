defmodule RiverWeb.LogsController do
  use RiverWeb, :controller

  def index(conn, _params) do
    json(conn, %{message: "Acknowledged"})
  end

  def create(conn, %{"owner" => owner, "timestamp" => timestamp, "body" => body}) do
    %River.Log{owner: owner, timestamp: timestamp, body: body}
    |> River.store_log()

    json(conn, %{owner: owner, timestamp: timestamp, body: body})
  end

  def create(conn, %{"owner" => owner, "body" => body}) do
    # Decode body from JSON string to map
    case Jason.decode(body) do
      {:ok, decoded_body} ->
        # Prepare the attrs for changeset
        attrs = %{
          "owner" => owner,
          "timestamp" => DateTime.utc_now() |> DateTime.truncate(:second),
          "body" => decoded_body
        }

        changeset = River.Log.changeset(%River.Log{}, attrs)

        case River.store_log(changeset) do
          {:ok, log} ->
            json(conn, log)

          {:error} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: 1})
        end

      {:error, _reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Invalid JSON in body"})
    end
  end
end
