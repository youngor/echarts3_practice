# -*- coding: UTF-8 -*-

require 'rubygems'
require 'pp'
require '../流向处理/city'
require 'date'

$ec_2_gbk = Encoding::Converter.new("utf-8", "gbk")
$ec_2_utf8 = Encoding::Converter.new("gbk","utf-8")


#首次发布时间 update_date 标准品牌    标准车系    车源发布状态  标价

def read_csv_gbk(file_name,n,sep=',')
    recs = []
    File.foreach(file_name,:encoding=>"gbk") { |line|
        #pp line  
        a = line.chomp.split(/#{sep}/)
        #pp a
        #gets

        bb = []
        (1..n-1).each do |i|
            bb[i] = ''
        end
        i = 0
        a.each do |item|
            bb[i] = a[i]
            i += 1
        end
        recs << bb
        #pp bb
        #gets
        #pp bb
        #pp recs
        #exit
    }
    #pp recs
    recs 
end

recs = read_csv_gbk('csv/in_原始数据.csv',6)[1..-1]
#puts recs[0].length
#exit

#保持N位小数点转化

def to_n_point_float(f,n=2)
    sprintf("%.#{n}f", f).to_f
end


#//['a',20],['b',50],['c',40]
def write_area(recs,name_col,val_col,file_name)

    name_str = ''
    val_str = ''

    (0..recs.length-1).each do |i|
        t = recs[i]
        #pp t
        #pp recs
        name_str += "'" + $ec_2_utf8.convert(t[name_col].to_s)  + "',\n"
        val_str += "['" + t[name_col].to_s + "'," + $ec_2_utf8.convert(t[val_col].to_s) + "],\n"
    end
    

    data = IO.read('../template/area.template',:encoding=>"utf-8")
    data.gsub!(/PARAM0/,"#{name_str}")
    data.gsub!(/PARAM1/,"#{val_str}")
    
    puts data

    IO.write("../../server/public/my_js/#{file_name}.js",data,:encoding=>"utf-8")
end

def group_by_col(recs,col,cs_name)
    h = {}

    cs_name.each do |cs|
        h[cs] = 0

        recs.each do |r|
            h[cs] += 1 if r[col] == cs
        end
    end
    h
end

#车源周转天数表_out.csv

h = recs.map { |e|  [e[1],(Date.parse(e[1])-Date.parse(e[0])).to_i]}
#pp h
h = h.sort { |a,b|    Date.parse(b[0]) <=> Date.parse(a[0]) }

#pp h

#update_date    车源周转天数
#write out csv...
File.open("csv/车源周转天数表_out.csv", "w",:encoding=>"gbk") { |iol|  
    iol << "update_date*,车源周转天数" << "\n"
    h.each do |i|
        iol << "#{i[0]},#{i[1]}\n"
    end
}


#车系周转天数表_out.csv
#write out csv...
ind = 0
#puts h.length

dates = h.map { |e|  e[0]}.uniq.sort { |a,b|    Date.parse(b) <=> Date.parse(a) }

#pp dates
#exit

h1 = dates.map { |d|
    avg = 0
    t = 0
    h.each  { |i|

        if Date.parse(i[0]) < Date.parse(d) && Date.parse(d) - Date.parse(i[0]) <= 30
            avg += i[1].to_i
            t += 1
        end
    }
    t = 1 if t == 0
    avg = to_n_point_float(avg * 1.0 / t) + 1
    printf "\b\b\b%d",ind
    #pp d,avg,t
    ind +=1
    [d,avg]
}

File.open("csv/车系周转天数表_out.csv", "w",:encoding=>"gbk") { |iol|  
    iol << "update_date*,车系周转天数" << "\n"
    h1.each do |i|
        iol << "#{i[0]},#{i[1]}\n"
    end
}

#generate area...
write_area(h1[0..-2-29],0,1,'zzts_cxzzts')

ind = 0
########################车系价格波动表_out.csv
h = recs.map { |e|  [e[1],e[-1]]}
#pp h
h = h.sort { |a,b|    Date.parse(b[0]) <=> Date.parse(a[0]) }

h1 = dates.map { |d|
    avg = 0
    t = 0
    h.each  { |i|
        if Date.parse(i[0]) < Date.parse(d) && Date.parse(d) - Date.parse(i[0]) <= 30
            avg += i[1].to_f
            t += 1    
        end
    }
    t = 1 if t == 0

    avg = to_n_point_float (avg / t) 
    printf "\b\b\b%d",ind
    #pp d,avg,t
    ind +=1

    [d,avg]
}

File.open("csv/车系价格波动表_out.csv", "w",:encoding=>"gbk") { |iol|  
    iol << "update_date*,车系平均价格" << "\n"
    h1.each do |i|
        iol << "#{i[0]},#{i[1]}\n"
    end
}

#generate area...
write_area(h1[0..-2-29],0,1,'zzts_jgbd')

#http://127.0.0.1:4567/zzts_cxzzts.html
#http://127.0.0.1:4567/zzts_jgbd.html
