defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    #using pipe for readabiity
    String.split(m, "\n")
    |> Enum.map(fn t -> process(t) end)
    |> Enum.join()
    |> patch()
  end



  # getting rid of multiple if and using pipe

  defp process(<<h>> <> _rest = t) when <<h>> ==  "#" do
    parse_header_md_level(t)
    |> enclose_with_header_tag()

  end

  defp process(<<h>> <> _rest = t) when <<h>> ==  "*" do

    parse_list_md_level(t)

  end

  defp process(t) do
    String.split(t)
    |> enclose_with_paragraph_tag()
  end


  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    t = String.split(String.trim_leading(l, "* "))
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h" <> hl <> ">" <> htl <> "</h" <> hl <> ">"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    # using pipe for readability
    Enum.map(t, fn w -> replace_md_with_tag(w) end)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    # using pipe for readability
    replace_prefix_md(w)
    |> replace_suffix_md()

  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp patch(l) do
    #using pipe for readability
    String.replace(l, "<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
