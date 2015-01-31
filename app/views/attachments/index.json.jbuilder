json.array!(@attachments) do |attachment|
  json.partial! attachment
end