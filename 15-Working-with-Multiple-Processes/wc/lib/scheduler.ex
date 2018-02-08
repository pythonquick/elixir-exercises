defmodule Scheduler do
  def run(num_processes, worker, func, work_queue) do
    1..num_processes
    |> Enum.map(fn(_) -> spawn(worker, func, [self()]) end)
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

