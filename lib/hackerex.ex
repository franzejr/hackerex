defmodule Hackerex do
  use HTTPoison.Base
  defmodule Client do

    defstruct endpoint: "https://hacker-news.firebaseio.com/v0/"

    @type t :: %__MODULE__{endpoint: binary}

    @spec new() :: t
    def new(), do: %__MODULE__{}

    @spec new(binary) :: t
    def new(endpoint) do
      endpoint = if String.ends_with?(endpoint, "/") do
        endpoint
      else
        endpoint <> "/"
      end
      %__MODULE__{endpoint: endpoint}
    end
  end

  @type response :: {integer, any} | :jsx.json_term

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(response) do
    status_code = response.status_code
    headers = response.headers
    body = response.body
    response = unless body == "", do: body |> JSX.decode!,
  else: nil

  if (status_code == 200), do: response,
  else: {status_code, response}
  end

  @spec url(client :: Client.t, path :: binary) :: binary
  defp url(client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  @spec build_qs([{atom, binary}]) :: binary
  defp build_qs([]), do: ""
  defp build_qs(kvs), do: to_string('?' ++ URI.encode_query(kvs))

  def get(path, client, params \\ []) do
    url = url(client, path)
    url = <<url :: binary, build_qs(params) :: binary>>
    _request(:get, url)
  end

  def _request(method, url, body \\ "") do
    json_request(method, url, body)
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    request!(method, url, JSX.encode!(body), headers, options) |> process_response
  end

end
