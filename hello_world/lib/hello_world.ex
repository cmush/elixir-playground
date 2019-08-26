defmodule HelloWorld do
  def hello subject do
    IO.puts "Hello #{subject}"
  end

  def ourListenFunction do
    receive do
      {:print_hello, subject} -> IO.puts "Received: Hello #{subject}"
    end
    ourListenFunction()
  end
end
