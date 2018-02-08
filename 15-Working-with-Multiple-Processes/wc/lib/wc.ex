defmodule Wc do
  #import FibonacciWorker
  #import Scheduler

  @moduledoc """
  Documentation for Wc.
  """

  def run(directory, word) do
    {:ok, dir_content} = File.ls(directory)
    dir_entries_paths = Enum.map(dir_content, fn(entry) -> Path.join([directory, entry]) end)
    file_paths = for entry <- dir_entries_paths, File.dir?(entry) == false, do: entry
    to_process = Enum.map(file_paths, &({&1, word}))

    Enum.each 1..10, fn num_processes ->
      {time, result} = :timer.tc(
        Scheduler, :run,
        [num_processes, WorkOccurrenceWorker, :do_work, to_process]
      )

      if num_processes == 1 do
        IO.puts inspect result
        IO.puts "\n #   time (s)"
      end
      :io.format "~2B       ~.2f~n", [num_processes, time / 1_000_000.0]
    end
  end

end
