defmodule FibonacciWorker do
  def fib(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:task, n} ->
        send scheduler, {:answer, n, fibo(n), self()}
        fib(scheduler)
      :shutdown ->
        exit(:normal)
    end
  end

  # Inefficient, deliberately:
  defp fibo(0), do: 0
  defp fibo(1), do: 1
  defp fibo(n), do: fibo(n-1) + fibo(n-2)
end

