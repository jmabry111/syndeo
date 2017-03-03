defmodule Syndeo.PageController do
  use Syndeo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
