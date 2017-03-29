defmodule Syndeo.Button do
  import Phoenix.HTML.Link

  def delete_button(options, [do: contents]) do
    options =
      options
      |> Keyword.put(:method, :delete)
      |> Keyword.put(:form, [class: ""])
      button options, [do: contents]
  end
end
