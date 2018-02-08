defmodule WorkOccurrenceWorker do
  def do_work(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:task, work_item} ->
        {file_path, word} = work_item
        count = count_in_file(file_path, word)
        file_name = Path.basename(file_path)
        send scheduler, {:answer, file_name, count, self()}
        do_work(scheduler)
      :shutdown ->
        exit(:normal)
    end
  end


  def count_in_file(file_path, word) do
    content = File.read!(file_path)
    length(String.split(content, word)) - 1
  end
end
