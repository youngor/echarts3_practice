# -*- coding: UTF-8 -*-

require 'rubygems'
require 'pp'
require './city'

#保持N位小数点转化

def to_n_point_float(f,n=2)
    sprintf("%.#{n}f", f).to_f
end

#puts to_n_point_float(0.10545,3)
#exit


k1 = []
v1 = []

#2.0L   4592
File.foreach("csv/本地统计.csv",:encoding=>"utf-8") { |line|  
    a = line.split(/\s+/)
    #pp a
    k1<< "'"+a[0]+"'"
    v1<<a[1]
}

k2 = []
v2 = []

File.foreach("csv/流出统计.csv",:encoding=>"utf-8") { |line|  
    a = line.split(/\s+/)
    #pp a
    k2<< "'"+a[0]+"'" 
    v2<<a[1]
}

k3 = []
v3 = []

File.foreach("csv/流入统计.csv",:encoding=>"utf-8") { |line|  
    a = line.split(/\s+/)
    #pp a
    k3<< "'"+a[0]+"'" 
    v3<<a[1]
}


head = "地区,外迁量O,流入量I,本地过户量L,总交易量Q(O+I+L）,外迁率KO（O/Q）,本地过户率KL（L/Q）,外迁值VO(KO*O)的平方根,外迁指数IO=VO/VOmax,本地交易值VL(KL*L)的平方根,本地交易指数IL=VL/Vlmax"

vo_arr = []
vl_arr = []

vomax=0
vlmax=0

$cities.each do |c|
    t = k2.index("'"+c+"'")
    o = (t ? v2[t] : 0).to_i
    
    t = k3.index("'"+c+"'")
    i = (t ? v3[t] : 0).to_i

    t = k1.index("'"+c+"'")
    l = (t ? v1[t] : 0).to_i

    q = o+i+l

    begin
        ko = o*100.round/q/100.to_f
    rescue
        ko = 0
    end

    begin
        kl = l*100.round/q/100.to_f
    rescue
        kl = 0
    end
    vo = Math.sqrt(ko*o)
    vl = Math.sqrt(kl*l)
    vo_arr << vo
    vl_arr << vl
end

vomax=vo_arr.max
vlmax=vl_arr.max

File.open('csv/流向统计_out.csv', "w",:encoding=>"gbk") { |io|  
    io << head << "\n"
    $cities.each do |c|
        t = k2.index("'"+c+"'")
        o = (t ? v2[t] : 0).to_i
        
        #pp k2[0]
        #pp c

        #pp a
        #pp t
        
        t = k3.index("'"+c+"'")
        i = (t ? v3[t] : 0).to_i

        t = k1.index("'"+c+"'")
        l = (t ? v1[t] : 0).to_i

        q = o+i+l

        begin
            ko = to_n_point_float(o.to_f/q)
        rescue
            ko = 0
        end

        begin
            kl = to_n_point_float(l.to_f/q)
        rescue
            kl = 0
        end

        vo = Math.sqrt(ko*o)
        vl = Math.sqrt(kl*l)

#head = "地区,外迁量O,流入量I,本地过户量L,总交易量Q(O+I+L）,外迁率KO（O/Q）,本地过户率KL（L/Q）,外迁值VO(KO*O)的平方根,外迁指数IO=VO/VOmax,本地交易值VL(KL*L)的平方根,本地交易指数IL=VL/Vlmax"

        io << "#{c},#{o},#{i},#{l},#{q},#{ko*100}%,#{kl*100}%,#{to_n_point_float(vo)},#{to_n_point_float(vo/vomax)},#{to_n_point_float(vl)},#{to_n_point_float(vl/vlmax)}\n"
    end
}


=begin
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
File.open('csv/排量发布_out.csv', "w",:encoding=>"gbk") { |io|  
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

        io << "#{k3[i][1..-2]},#{a},#{b}\n"
    end
}

=end
