defmodule River.Log do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:owner, :timestamp, :body]}
  schema "logs" do
    field :owner, :string
    field :timestamp, :utc_datetime
    field :body, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:owner, :body, :timestamp])
    |> validate_required([:owner, :timestamp])
  end
end
