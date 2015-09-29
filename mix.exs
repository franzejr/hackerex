defmodule Hackerex.Mixfile do
  use Mix.Project

  @description """
     Simple Elixir wrapper for the HackerNews API
       """

  def project do
    [ app: :hackerex,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      name: "Hackerex",
      description: @description,
      package: package,
      deps: deps ]
  end

  def application do
    [ applications: [ :httpoison, :exjsx ] ]
  end

  defp deps do
    [ { :httpoison, "~> 0.6.0" },
      { :exjsx, "~> 3.0" },
      { :meck, "~> 0.8.2", only: :test } ]
  end

  defp package do
    [ contributors: ["Franzé Jr"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/franzejr/hackerex/" } ]
  end
end
