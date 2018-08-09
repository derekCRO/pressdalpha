json.array! @partner_opening_times do |partneropeningtime|
  json.id partneropeningtime.id
  json.title partneropeningtime.title
  json.start partneropeningtime.start.strftime(date_format)
  json.end partneropeningtime.end.strftime(date_format)
  json.update_url partneropeningtime_path(partneropeningtime, method: :patch)
  json.edit_url edit_partneropeningtime_path(partneropeningtime)
end
