# We are defining a custom plug here
# It stores logged in users in a map
# TODO: modify this to use more pattern matching
# TODO: for some reason the original code that mentor gave me doesnt work.. so thanks gpt
# SOLVED TODO /\: This part of the app is very weird, according to gpt, the previous account_id = get_session(conn, :account_id) code that mentor wrote is only supposed to look at cookies. This is despite the fact that he definetly did not do that with the api test he showed. This is also confirmed by the docs: https://hexdocs.pm/plug/Plug.Conn.html#module-session-vs-assigns. Sooo.. this is fine for now.
defmodule RealDealApiWeb.Auth.SetAccount do
  alias RealDealApiWeb.Auth.ErrorResponse
  alias RealDealApi.Accounts
  import Plug.Conn

  def init(_options) do
  end

  def call(conn, _opts) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        # no valid token → unauthorized
        raise ErrorResponse.Unauthorized

      account ->
        # assign the loaded account so downstream code can use conn.assigns.account
        assign(conn, :account, account)
    end
  end
end
