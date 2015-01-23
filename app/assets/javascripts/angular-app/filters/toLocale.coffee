@app.filter 'toLocale', ->
  MONTH_NAMES = [ "January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December" ];
  format = (d, time) ->
    hh = d.getHours()
    mm = d.getMinutes()
    day = d.getDate()
#    month = MONTH_NAMES[d.getMonth()]
    month = d.getMonth()+1
    year = d.getFullYear()
    tm = " #{hh}:#{mm}"
    res = "#{day}/#{month}/#{year}"
    if time then res+tm else res

  (date, time=true) ->
    if _.isString(date)
      return format(new Date(date), time)
    if _.isDate(date)
      return format(date, time)
    date
