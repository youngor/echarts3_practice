# -*- coding: UTF-8 -*-

require 'rubygems'
require 'pp'

#1-2年   198
k = []
v = []
sum = 0

#保持N位小数点转化

def to_n_point_float(f,n)
    ((f * 10^n).round/10^n).to_f
end

File.foreach("csv/车龄发布.csv",:encoding=>"utf-8") { |line|  
    a = line.split(/\s+/)
    #pp a
    k<< "'"+a[0]+"'"
    v<<a[1]
    sum += a[1].to_i
}

v1 = v.map { |e|  e.to_i*1000.round/sum/10.to_f }

pp v1

puts k.join(',')
puts v1.join(',')
#pp k
#pp v

data = IO.read('../template/bar.template',:encoding=>"utf-8")
data.gsub!(/PARAM0/,"[#{k.join(',')}]")
data.gsub!(/PARAM1/,"[#{v1.join(',')}]")


puts data

IO.write('../../server/public/my_js/hhh.js',data,:encoding=>"utf-8")

head = "上牌年限,各年份上牌比例"
File.open('csv/车龄发布_out.csv', "w",:encoding=>"gbk") { |io|  
    io << head << "\n"
    (0...k.length).each do |i|
        io << "#{k[i][1..-2]},#{v1[i]}%\n"
    end
}
