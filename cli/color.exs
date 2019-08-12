# Youtube Source (Dennis Beatty): https://www.youtube.com/watch?v=sN7Fy5pwOdE&t=1s
defmodule Color do
  def green(text) do
    IO.ANSI.green() <> text <> IO.ANSI.reset()
  end

  def red(text) do
    IO.ANSI.red() <> text <> IO.ANSI.reset()
  end

  def code(code, text) do
    IO.ANSI.color(code) <> text <> IO.ANSI.reset()
  end
end

# demo
IO.puts(Color.green("Text colored green"))
IO.puts(Color.red("Text colored red"))

0..255
|> Enum.each(fn code ->
  IO.puts(Color.code(code, "Code #{code}"))
  Process.sleep(250)
end)
