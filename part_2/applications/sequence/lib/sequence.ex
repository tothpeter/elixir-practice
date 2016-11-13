defmodule Sequence do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _params) do
    initial_number = Application.get_env(:sequence, :initial_number)
    {:ok, _pid} = Sequence.Supervisor.start_link(initial_number)
  end
end
