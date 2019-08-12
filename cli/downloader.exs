# Youtube Source (Dennis Beatty): https://www.youtube.com/watch?v=sN7Fy5pwOdE&t=1s
defmodule Downloader do
  @background_color 53
  @label_color 15
  @input_color 183
  @label_text "Filename"
  @input_size 20
  @input_text_color 53

  def get_filename do
    draw_background()
    draw_input()

    filename = IO.read(:line)

    reset()

    String.trim(filename)
  end

  defp draw_input do
    {rows, cols} = screen_size()

    row = Float.floor(rows / 2) |> trunc()
    column = Float.floor((cols - @input_size) / 2) |> trunc()

    IO.write(IO.ANSI.cursor(row, column) <> IO.ANSI.color(@label_color) <> @label_text)

    IO.write(
      IO.ANSI.cursor(row + 1, column) <> IO.ANSI.color_background(@input_color) <> input_box()
    )

    IO.write(IO.ANSI.cursor(row + 1, column) <> IO.ANSI.color(@input_text_color))
  end

  defp input_box do
    String.duplicate(" ", @input_size)
  end

  defp draw_background do
    IO.write(IO.ANSI.color_background(@background_color) <> IO.ANSI.clear())
  end

  defp reset do
    IO.write(IO.ANSI.reset() <> IO.ANSI.clear() <> IO.ANSI.home())
  end

  defp screen_size do
    {num("lines"), num("cols")}
  end

  defp num(subcommand) do
    case System.cmd("tput", [subcommand]) do
      {text, 0} ->
        text
        |> String.trim()
        |> String.to_integer()

      _error ->
        0
    end
  end
end

Downloader.get_filename()
|> IO.inspect(label: "Filename")
