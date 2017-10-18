# -*- coding: UTF-8 -*-

require 'rubygems'
require 'pp'

#1-2年   198
k = []
v = []

File.foreach("车龄发布.csv",:encoding=>"utf-8") { |line|  
    a = line.split(/\s+/)
    #pp a
    k<< "'"+a[0]+"'"
    v<<a[1]
    
}

puts k.join(',')
puts v.join(',')
#pp k
#pp v

data = IO.read('../template/bar.template',:encoding=>"utf-8")
data.gsub!(/PARAM0/,"[#{k.join(',')}]")
data.gsub!(/PARAM1/,"[#{v.join(',')}]")

puts data

IO.write('../../server/public/my_js/hhh.js',data,:encoding=>"utf-8")