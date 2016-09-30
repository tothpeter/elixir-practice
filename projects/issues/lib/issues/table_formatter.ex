defmodule Issues.TableFormatter do

  import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]

  def format(data, headers) do
    data_in_columns = rotate_and_stringify_list(data, headers)
    column_widths = get_column_widths(data_in_columns)

    output_format = get_format(column_widths)

    print_line(headers, output_format)
    print_separator(column_widths)
    print_body(data_in_columns, output_format)
  end

  def rotate_and_stringify_list(list, headers) do
    for header <- headers do
      for list_item <- list, do: stringify_data(list_item[header])
    end
  end

  def stringify_data(data) when is_binary(data) , do: data
  def stringify_data(data), do: to_string(data)

  def get_column_widths(list) do
    for list_item <- list, do: list_item |> map(&String.length/1) |> max
  end

  def get_format(column_widths) do
    map_join(column_widths, " | ", fn(width) -> "~-#{width}s" end) <> "~n"
  end

  def print_separator(column_widths) do
    IO.puts map_join(column_widths, "-+-", fn(width) -> List.duplicate("-", width) end)
  end

  def print_body(data_in_columns, format) do
    data_in_columns
    |> List.zip
    |> map(&Tuple.to_list/1)
    |> each(&print_line(&1, format))
  end

  def print_line(data, format) do
    :io.format(format, data)
  end
end
