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


defmodule Scheduler do
  def run(num_processes, worker, _func, work_queue) do
    1..num_processes
    |> Enum.map(fn(_) -> spawn(worker, :fib, [self()]) end)
    |> schedule_work(work_queue, [])
  end

  def schedule_work(processes, work_queue, results) do
    receive do
      {:ready, worker_pid} when length(work_queue) > 0 ->
        [next_work_item | remaining_work_queue] = work_queue
        send worker_pid, {:task, next_work_item}
        schedule_work(processes, remaining_work_queue, results)
      {:ready, worker_pid} ->
        send worker_pid, :shutdown
        if length(processes) > 1 do 
          schedule_work(List.delete(processes, worker_pid), work_queue, results)
        else
          results
        end
      {:answer, work_item, result, _worker_pid} ->
        schedule_work(processes, work_queue, [{work_item, result} | results])
    end
  end
end


to_process = List.duplicate(37, 20)

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, FibonacciWorker, :fib, to_process]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B       ~.2f~n", [num_processes, time / 1_000_000.0]
end
