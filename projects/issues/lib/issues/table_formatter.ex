defmodule Issues.TableFormatter do

  import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]

  @doc """
  Takes a list of row data, where each row is a HashDict, and a list of
  headers. Prints a table to STDOUT of the data from each row
  identified by each header. That is, each header identifies a column,
  and those columns are extracted and printed from the rows.

  We calculate the width of each column to fit the longest element
  in that column.
  """
  def format(data, headers) do
    data_in_columns = rotate_and_stringify_list(data, headers)
    column_widths = get_column_widths(data_in_columns)

    output_format = get_format(column_widths)

    print_line(headers, output_format)
    IO.puts separator(column_widths)
    print_body(data_in_columns, output_format)
  end

  @doc """
  Given a list of rows, where each row contains a keyed list
  of columns, return a list containing lists of the data in
  each column. The `headers` parameter contains the
  list of columns to extract

  ## Example

      iex> list = [Enum.into([{"a", "1"},{"b", "2"},{"c", "3"}], HashDict.new),
      ...>         Enum.into([{"a", "4"},{"b", "5"},{"c", "6"}], HashDict.new)]
      iex> Issues.TableFormatter.rotate_and_stringify_list(list, [ "a", "b", "c" ])
      [ ["1", "4"], ["2", "5"], ["3", "6"] ]

  """
  def rotate_and_stringify_list(list, headers) do
    for header <- headers do
      for list_item <- list, do: stringify_data(list_item[header])
    end
  end

  @doc """
  Return a binary (string) version of our parameter.
  ## Examples
      iex> Issues.TableFormatter.stringify_data("a")
      "a"
      iex> Issues.TableFormatter.stringify_data(99)
      "99"
  """
  def stringify_data(data) when is_binary(data) , do: data
  def stringify_data(data), do: to_string(data)

  @doc """
  Given a list containing sublists, where each sublist contains the data for
  a column, return a list containing the maximum width of each column

  ## Example
      iex> data = [ [ "cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Issues.TableFormatter.get_column_widths(data)
      [ 6, 8 ]
  """
  def get_column_widths(list) do
    for list_item <- list, do: list_item |> map(&String.length/1) |> max
  end

  @doc """
  Return a format string that hard codes the widths of a set of columns.
  We put `" | "` between each column.

  ## Example
      iex> widths = [5,6,99]
      iex> Issues.TableFormatter.get_format(widths)
      "~-5s | ~-6s | ~-99s~n"
  """
  def get_format(column_widths) do
    map_join(column_widths, " | ", fn(width) -> "~-#{width}s" end) <> "~n"
  end

  @doc """
  Generate the line that goes below the column headings. It is a string of
  hyphens, with + signs where the vertical bar between the columns goes.

  ## Example
      iex> widths = [5,6,9]
      iex> Issues.TableFormatter.separator(widths)
      "------+--------+----------"
  """
  def separator(column_widths) do
    map_join(column_widths, "-+-", fn(width) -> List.duplicate("-", width) end)
  end

  @doc """
  Given a list containing rows of data, a list containing the header selectors,
  and a format string, write the extracted data under control of the format string.
  """
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
