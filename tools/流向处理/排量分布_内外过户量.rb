# -*- coding: UTF-8 -*-

require 'rubygems'
require 'pp'


k1 = []
v1 = []

#2.0L   4592
File.foreach("csv/外迁过户量.csv",:encoding=>"utf-8") { |line|  
    a = line.split(/\s+/)
    #pp a
    k1<< "'"+a[0]+"'"
    v1<<a[1]
}

k2 = []
v2 = []

File.foreach("csv/本地过户量.csv",:encoding=>"utf-8") { |line|  
    a = line.split(/\s+/)
    #pp a
    k2<< "'"+a[0]+"'" 
    v2<<a[1]
}

puts k1.join(',')
puts v1.join(',')
puts k2.join(',')
puts v2.join(',')
#pp k
#pp v
k3 = k1 

k2.each do |t|
    k3 << t unless k1.include?(t)
end

k3 = k3.sort {
    |a,b| a <=> b
}

#[{value:5122, name:'1.5L'}, {value:29071, name:'1.6L'}]

str1 = ''
str2 = ''

(0..v1.length-1).each do |i|
    str1 += '{value:' + v1[i] + ",name:" + k1[i]  + "},"
end

(0..v2.length-1).each do |i|
    str2 += '{value:' + v2[i] + ",name:" + k2[i]  + "},"
end

data = IO.read('../template/ring.template',:encoding=>"utf-8")
data.gsub!(/PARAM0/,"[#{k3.join(',')}]")
data.gsub!(/PARAM1/,"[#{str1}]")
data.gsub!(/PARAM2/,"[#{str2}]")


puts data

IO.write('../../server/public/my_js/hhh.js',data,:encoding=>"utf-8")


head = "排量,本地过户量,外迁过户量"
File.open('csv/排量发布_out.csv', "w") { |io|  
    io << head << "\n"
    (0...k3.length).each do |i|
        t = k2.index(k3[i])
        pp t
        pp v2
        a = t ? v2[t] : 0
        pp t
        pp i
        pp k3[i]
        t = k1.index(k3[i])
        b = t ? v1[t] : 0 

        io << "#{k3[i]},#{a},#{b}\n"
    end
}
