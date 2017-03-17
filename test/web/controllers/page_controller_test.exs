defmodule Rumbl.Web.PageControllerTest do
  use Rumbl.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Rumbl.io!"
  end
end
