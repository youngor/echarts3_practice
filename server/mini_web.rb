require 'rubygems'
require 'sinatra'
require 'open-uri'
require "base64" 

  get '/' do
         '----------'
  end

  post '/' do
    puts params.to_s
    b = /(?<=base64,)[\S|\s]+/.match(params['baseimg'])
    #puts   b  
    File.open(params['file_name'],"wb") {|f|
        f.write(Base64.decode64(b.to_s))  
    }
    'done!' #+ params.to_s

  end             
