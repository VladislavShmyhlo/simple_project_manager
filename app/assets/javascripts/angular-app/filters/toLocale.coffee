@app.filter 'toLocale', ->
  MONTH_NAMES = [ "January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December" ];
  format = (d) ->
    day = d.getDate()
    month = MONTH_NAMES[d.getMonth()]
    year = d.getFullYear()
    "#{day} of #{month}, #{year}"

  (date) ->
    if _.isString(date)
      return format(new Date(date))
    if _.isDate(date)
      return format(date)
    date
