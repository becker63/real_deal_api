# We are defining a custom plug here
# It stores logged in users in a map
# TODO: modify this to use more pattern matching
defmodule RealDealApiWeb.Auth.SetAccount do
  alias RealDealApiWeb.Auth.ErrorResponse
  alias RealDealApi.Accounts
  import Plug.Conn

  def init(options) do
  end

  def call(conn, _options) do
    if conn.assigns[:account] do
      conn
    else
      account_id = get_session(conn, :account_id)

      if account_id == nil, do: raise(ErrorResponse.Unauthorized)
      account = Accounts.get_account!(account_id)

      cond do
        account_id && account -> assign(conn, :account, account)
        true -> assign(conn, :account_id, nil)
      end
    end
  end
end
