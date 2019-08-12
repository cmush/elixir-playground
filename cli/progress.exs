# Youtube Source (Dennis Beatty): https://www.youtube.com/watch?v=_NXZJx1snkE
defmodule Progress do
  @rounding_precision 2
  @progress_bar_size 50

  def bar(count, total) do

    percent = percent_complete(count, total)
    divisor = 100 / @progress_bar_size

    completed_count = round(percent / divisor)
    incomplete_count = @progress_bar_size - completed_count

    "#{repeat(completed_count, "▓")}#{repeat(incomplete_count, "░")} (#{percent}%)"
  end

  defp percent_complete(count, total) do
    Float.round(100.0 * count / total, @rounding_precision)
  end

  def repeat(count, _str) when count < 1, do: ""
  def repeat(count, str) do
    1..count
    |> Enum.map(fn (_) -> str end)
    |> Enum.join()
  end
end

total = 50
Enum.each(1..total, fn(task)->
IO.write("\r#{Progress.bar(task, total)}")
Process.sleep(50)
end)
IO.write("\n")
