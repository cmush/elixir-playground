defmodule Myclient.Oauth2 do
  use GenServer

  alias GenServer, as: GS
  alias Myclient.Oauth2, as: W

  ### Public API

  @doc"""
  Resolve the client_id based on the :myclient, :oauth2, :client_id
  """
  def client_id() do
    Application.get_env(:myclient, :oauth2)
    |> (fn %{client_id: client_id} -> client_id end).()
    |> case do
         {:system, lookup} -> System.get_env(lookup)
         t -> t
       end
  end

  @doc"""
  Resolve the redirect_uri based on the :myclient, :oauth2, :redirect_uri
  """
  def redirect_uri() do
    Application.get_env(:myclient, :oauth2)
    |> (fn %{redirect_uri: redirect_uri} -> redirect_uri end).()
    |> case do
         {:system, lookup} -> System.get_env(lookup)
         t -> t
       end
  end

  def start_link() do
    {:ok, _pid} = GS.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc"""
  Manually provide the refresh token.

  ## Examples

      iex> Myclient.Oauth2.manual_token("good1234")
      %{token_type: "Bearer", refresh_token: "good1234", expires_in: 1800, access_token: "access1234"}

  """
  def manual_token(refresh_token) do
    GS.call(W, {:refresh_token, %{"refresh_token" => refresh_token}})
  end

  @doc"""
  Retrieve a token using an access code

  ## Examples

      iex> Myclient.Oauth2.access_code("code1234")
      %{token_type: "Bearer", refresh_token: "good1234", expires_in: 1800, access_token: "access1234"}

  """
  def access_code(code) do
    GS.call(W, {:access_code, code})
  end

  def access_token() do
    GS.call(W, :lookup_token)
  end

  def refresh_token(token_data) do
    GS.call(W, {:refresh_token, token_data})
  end

  def restore_token(token_data) do
    GS.call(W, {:restore_token, token_data})
  end

  ### Server Callbacks

  def init(_) do
    {:ok, %{}}
  end

  def handle_call(:lookup_token, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:refresh_token, nil}, _from, state) do
    handle_fetch_call({:refesh_token, state["refresh_token"]})
  end

  def handle_call({:refresh_token, %{"refresh_token" => refresh_token}}, _from, _state) do
    handle_fetch_call({:refresh_token, refresh_token})
  end

  def handle_call({:access_code, access_code}, _from, _state) do
    handle_fetch_call({:access_code, access_code})
  end

  def handle_call({:restore_token, token_data}, _from, _state) do
    {:reply, token_data, token_data}
  end

  def handle_fetch_call(oauth_data) do
    oauth_data
    |> fetch_token
    |> (fn {200, token} -> {:reply, token, token} end).()
  end

  @doc"""
  Retrieve your access token using your manually assigned token
  """
  def fetch_token({:refresh_token, refresh_token}) do
    Myclient.Api.post(
      "/oauth2/token",
      %{grant_type: :refresh_token,
        refresh_token: refresh_token})
  end

  @doc"""
  Retrieve your access token using your manually assigned token

  """
  def fetch_token({:access_code, access_code}) do
    Myclient.Api.post(
      "/oauth2/token",
      %{client_id: client_id(),
        grant_type: :authorization_code,
        redirect_uri: redirect_uri(),
        code: access_code})
  end

end
