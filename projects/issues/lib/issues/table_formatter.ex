defmodule Issues.TableFormatter do

  import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]

  def format(data, headers) do
    data_by_columns = split_into_columns(data, headers)
    column_widths = column_widths(data_by_columns)
    io_format = get_io_format(column_widths)

    puts_one_line_in_columns(io_format, headers)
    puts_separator(column_widths)
    puts_in_columns(data_by_columns, io_format)
  end

  def split_into_columns(data_rows, headers) do
    for header <- headers do
      for data_row <- data_rows do
        stringify_data(data_row[header])
      end
    end
  end

  def stringify_data(data) when is_binary(data), do: data
  def stringify_data(data), do: to_string(data)

  def column_widths(columns) do
    for column <- columns, do: column |> map(&String.length/1) |> max
  end

  def get_io_format(column_widths) do
    map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip
    |> map(&Tuple.to_list/1)
    |> each(&puts_one_line_in_columns(format, &1))
  end

  def puts_one_line_in_columns(format, fields) do
    :io.format(format, fields)
  end

  def puts_separator(column_widths) do
    IO.puts map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end
end
