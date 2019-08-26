defmodule Myclient.Client do

  @doc"""
  Extract the current version

  ## Examples

      iex> Myclient.Client.current_version()
      "0.1.0"

  """
  def current_version() do
    ""
    |> Myclient.Api.get
    |> (fn {200, %{version: version}} -> version end).()
  end

  @doc"""
  Set the next version

  ## Examples

      iex> Myclient.Client.next_version("1.2.3")
      "1.2.3"

  """
  def next_version(version) do
    ""
    |> Myclient.Api.post(%{version: version})
    |> (fn {201, %{version: version}} -> version end).()
  end

  @doc"""
  Extract the profile data for the provided token

  ## Examples

      iex> Myclient.Client.profile("abc123")
      {:ok, %{answer: 42}}

      iex> Myclient.Client.profile("def456")
      {:error, "Forbidden; No access to this resource"}

      iex> Myclient.Client.profile("xxx")
      {:error, "Unauthorized; Invalid credentials"}

  """
  def profile(token \\ nil) do
    "/profile"
    |> Myclient.Api.get([], [Myclient.Api.authorization_header(token)])
    |> (fn
          {200, answer} -> {:ok, answer}
          {_, %{error: error, reason: reason}} -> {:error, "#{error}; #{reason}"}
          {_, reason} -> {:error, reason}
        end).()
  end

end