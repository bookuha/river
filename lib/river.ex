defmodule River do
  alias River.Repo

  def store_log(log) do
    Repo.insert(log)
  end
end
