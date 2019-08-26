defmodule Myclient.HttpoisonTest do
  use ExUnit.Case

  test "make a HTTP successful call" do
    url = "http://localhost:4000"
    %{body: _body,
      status_code: 200,
      request_url: ^url,
      headers: _headers} = HTTPoison.get!(url)
  end

  test "make a failed HTTP call" do
    url = "http://localhost:4000/garbage"
    %{body: _body,
      status_code: 404,
      request_url: ^url,
      headers: _headers} = HTTPoison.get!(url)
  end

  test "make :ok/:error call" do
    url = "http://localhost:4000/garbage"
    {:ok, %HTTPoison.Response{body: _body,
                              status_code: 404,
                              request_url: ^url,
                              headers: _headers}} = HTTPoison.get(url)

    url = "ppq://url.com"
    {:error, %HTTPoison.Error{reason: :nxdomain}} = HTTPoison.get(url)
  end

  test "test parse JSON" do
    {:ok, %{a: 1}} = Poison.decode("{\"a\": 1}", keys: :atoms)
    {:error, {:invalid, "g", 1}} = Poison.decode("{goop}", keys: :atoms)
  end

end
