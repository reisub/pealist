defmodule Pealist do
  @moduledoc """
  The entry point for reading plist data.
  """

  @type result :: any

  @doc """
  Parse the data provided as an XML or binary format plist,
  depending on the header.
  """
  @spec decode(String.t()) :: result
  def decode(data) do
    case String.slice(data, 0, 8) do
      "bplist00" -> Pealist.Binary.decode(data)
      "<?xml ve" -> Pealist.XML.decode(data)
      _ -> raise "Unknown plist format"
    end
  end

  @doc false
  @deprecated "Use decode/1 instead"
  @doc since: "0.0.6"
  def parse(data) do
    decode(data)
  end

  @doc """
  Encode the data provided as an XML format plist.
  """
  @spec encode(term()) :: String.t()
  def encode(data) do
    Pealist.XML.encode(data)
  end
end
