require 'watir'

#$HIDE_IE = true  #hide windows

b = Watir::Browser.new  :firefox  
b.goto('http://127.0.0.1:4567/e2.html')

