defmodule Myclient.ApiTest do
  use ExUnit.Case

  test "get" do
    {200, _body} = Myclient.Api.get("http://localhost:4000")
    {404, _body} = Myclient.Api.get("http://localhost:4000/garbage")
    {:error, _reason} = Myclient.Api.get("ppq://url.com")
  end

end
