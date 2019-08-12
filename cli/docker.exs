defmodule Docker do
  @done_text IO.ANSI.green() <> "done" <> IO.ANSI.reset()
  def up do
    IO.puts("Creating network \"dgraph_default\" with default driver")
    IO.puts("Creating dgraph_zero_1 ... ")
    IO.puts("Creating dgraph_server_1 ... ")
    IO.puts("Creating dgraph_rate1_1 ... ")

    1..3
    |> Enum.shuffle()
    |> Enum.each(&line_done/1)
  end

  defp line_done(line) do
    Process.sleep(500)

    offset = 4 - line

    offset
    |> IO.ANSI.cursor_up()
    |> Kernel.<>(IO.ANSI.cursor_right(30))
    |> Kernel.<>(@done_text)
    |> Kernel.<>(IO.ANSI.cursor_down(offset))
    |> Kernel.<>("\r")
    |> IO.write()
  end
end

Docker.up()
