# -*- coding: UTF-8 -*-

require 'rubygems'
require 'pp'
require '../utils/city'
require 'date'


recs = read_csv_gbk('csv/in_原始数据.csv',6)[1..-1]


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
    avg = to_n_point_float(avg * 1.0 / t + 1)
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
