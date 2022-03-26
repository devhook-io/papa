defmodule PapaWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :papa

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Absinthe.Plug,
    schema: PapaWeb.Schema
end
