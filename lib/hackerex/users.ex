defmodule  Hackerex.Users do
  import Hackerex
  import Hackerex.Client
  @spec find(binary, Client.t) :: Hackerex.response
  def find(user, client \\ %Client{}) do
    get "user/#{user}.json", client
  end
end
