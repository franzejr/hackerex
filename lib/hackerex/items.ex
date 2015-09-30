defmodule  Hackerex.Items do
  import Hackerex
  alias Hackerex.Client

  @spec find(binary, Client.t) :: Hackerex.response
  def find(item, client \\ %Client{}) do
    get "item/#{item}.json", client
  end

end
