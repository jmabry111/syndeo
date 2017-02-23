defmodule ConnectionCard.PageController do
  use ConnectionCard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
