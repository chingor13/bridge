# Bridge ![](https://travis-ci.org/chingor13/bridge.svg?branch=master)

This library is written in elixir to handle scoring contract bridge games.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add bridge to your list of dependencies in `mix.exs`:

        def deps do
          [{:bridge, "~> 0.0.1"}]
        end

  2. Ensure bridge is started before your application:

        def application do
          [applications: [:bridge]]
        end
