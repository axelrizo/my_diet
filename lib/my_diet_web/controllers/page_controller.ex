defmodule MyDietWeb.PageController do
  use MyDietWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
