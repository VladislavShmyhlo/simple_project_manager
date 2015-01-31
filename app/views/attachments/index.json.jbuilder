json.array!(@attachments) do |attachment|
  json.partial! attachment
  json.url attachment_url(attachment, format: :json)
end