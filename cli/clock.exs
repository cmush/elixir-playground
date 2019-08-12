# Youtube Source (Dennis Beatty): https://www.youtube.com/watch?v=_NXZJx1snkE
defmodule Clock do
  def start do
    time_string = Time.utc_now()
    |> Time.truncate(:second)
    |> Time.to_string()

    IO.write("\r#{time_string}")

    Process.sleep(1_000)
    start()
  end
end

Clock.start()
