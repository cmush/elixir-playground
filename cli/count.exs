# Youtube Source (Dennis Beatty): https://www.youtube.com/watch?v=_NXZJx1snkE
defmodule Count do
  def count(0), do: IO.puts("\nDone!")
  def count(current) do
    IO.write("\r#{current} ")
    Process.sleep(250)
    count(current - 1)
  end
end

Count.count(10)
