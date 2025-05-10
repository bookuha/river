defmodule River.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RiverWeb.Telemetry,
      River.Repo,
      {DNSCluster, query: Application.get_env(:river, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: River.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: River.Finch},
      # Start a worker by calling: River.Worker.start_link(arg)
      # {River.Worker, arg},
      # Start to serve requests, typically the last entry
      RiverWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: River.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RiverWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
