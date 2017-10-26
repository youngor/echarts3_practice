# -*- coding: UTF-8 -*-

require 'rubygems'
require 'pp'
require '../流向处理/city'
require 'date'

$ec_2_gbk = Encoding::Converter.new("utf-8", "gbk")
$ec_2_utf8 = Encoding::Converter.new("gbk","utf-8")

#城市 首次发布时间  标准品牌    标准车系    站点  成份车商名   来源  天眼属性
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

recs = read_csv_gbk('csv/in_原始数据.csv',8)
#puts recs[0].length
#exit

#保持N位小数点转化

def to_n_point_float(f,n=2)
    sprintf("%.#{n}f", f).to_f
end

#//{value:335, name:'直接访问'}, {value:310, name:'邮件营销'},
def write_pie(recs,name_col,val_col,file_name)

    str1 = ''
    min = 0
    max = 0

    (0..recs.length-1).each do |i|
        t = recs[i]
        str1 += '{value:' + t[val_col].to_s + ",name:'" + $ec_2_utf8.convert(t[name_col].to_s)  + "'},\n"
        
        min = t[val_col] if min > t[val_col]
        max = t[val_col] if max < t[val_col]
    end

    #puts min,max
    min = (min * 0.9).round
    max = (max * 1.1).round
    #puts min,max

    
    data = IO.read('../template/pie.template',:encoding=>"utf-8")
    data.gsub!(/PARAM0/,"#{min}")
    data.gsub!(/PARAM1/,"#{max}")
    data.gsub!(/PARAM2/,"#{str1}")


    puts data

    IO.write("../../server/public/my_js/#{file_name}.js",data,:encoding=>"utf-8")
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
#pp recs
#gets

series = '凯越' #ARGV[1] 
source = $map_4s[series.to_sym] 
#pp source 
#gets
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

def get_excel_and_chart(recs,col,source,file_name,js_file)

    recs_4s = recs.select { |e|  $ec_2_utf8.convert(e[col]) == source } 

    #pp recs_4s


    cs_name = []
    recs_4s.each do |cs|
        cs_name << cs[-3]
    end

    cs_name.uniq!

    #pp cs_name


    h = group_by_col(recs_4s,-3,cs_name)
    h = h.sort_by {|k,v| -v }

    pp h
    cs_tol = 0

    h.each { |k,v|  cs_tol += v }
    pp cs_tol

    t10 = 0
    (0...10).each do |i|
        t10 += h[i][1]    
    end

    pp t10p =  to_n_point_float(t10*100.0/cs_tol,2)
    
    #write out csv...
    File.open(file_name, "w",:encoding=>"gbk") { |iol|  
        iol << "车商名字,发布量*" << "\n"
        h.each do |k,v|
            iol << "#{k},#{v}\n"
        end
        iol << "," << cs_tol << "\n"
        iol << ","  << t10p << "\n"
    }

    #generate pie...

    write_pie(h[0..5],0,1,js_file)

end

#http://127.0.0.1:4567/wl_4s.html
#http://127.0.0.1:4567/wl_dlcs.html
#http://127.0.0.1:4567/wl_dstop100.html
#http://127.0.0.1:4567/wl_gyzs.html

get_excel_and_chart(recs,-2,source,'csv/4s_out.csv','wl_4s') 
get_excel_and_chart(recs,-2,'网络媒体','csv/独立车商_out.csv','wl_dlcs') 

#'瓜子网' '人人车网'

recs_4s = recs.select { |e|  $ec_2_utf8.convert(e[-2]) == '瓜子网' || $ec_2_utf8.convert(e[-2]) == '人人车网' }

cs_name = []

recs_4s.each do |i|
    cs_name << i[0]
end

cs_name.uniq!

h = group_by_col(recs_4s,0,cs_name).sort_by {|a| -a[1]}

#top 100
cs_name = []
h[0..100].each do |v|
    cs_name << v[0]
end

#pp cs_name

dates = []

recs.each do |v|
    dates << v[1]   unless $ec_2_utf8.convert(v[1]) == '首次发布时间'     
end

dates = dates.uniq!.sort {|a,b| Date.parse(b) <=> Date.parse(a)}

#pp dates

h = {}
dates.each do |d|
    h[d] = 0
    print "."
    cs_name.each do |c|
        recs_4s.each do |e|  
            h[d] += 1 if e[0] == c && e[1] == d 
        end
    end
end

pp h
#write out csv...
File.open('csv/电商top100_out.csv', "w",:encoding=>"gbk") { |iol|  
    iol << "首次发布时间,C2C电商平台在前100个城市每日发布的车源总量*" << "\n"
    h.each do |k,v|
        iol << "#{k},#{v}\n"
    end
}

#generate area graph...
write_area(h.to_a,0,1,'wl_dstop100')

# 供应指数
h = {}
dates.each do |d|
    h[d] = 0
    print "."
    recs.each do |v|
        #pp v
        if v[1] == d && v[-1] == '3'  
            h[d] += 1 
            #puts "--",d,v[1],v[-1]
        end

    end
end

pp h
h = h.to_a

def get_avg(h,i,n=30)
    v = 0

    num = 0
    (i...h.length).each do |k|
        #pp h[i][0],h[k][0]
        if Date.parse(h[i][0]) - Date.parse(h[k][0]) < n
            num += 1
            v += h[k][1]
        end
    end
    pp v,num
    to_n_point_float(v*1.0/num,2)
end

max = 0
#write out csv...
File.open('csv/供应指数_out.csv', "w",:encoding=>"gbk") { |iol|  
    iol << "日期,30天日均发布量*,成分车商每日发布量" << "\n"
    (0...h.length).each do |i|
        #pp h[i]
        if Date.parse(h[0][0]) - Date.parse(h[i][0]) <= 60
            iol << "#{h[i][0]},#{get_avg(h,i)},#{h[i][1]}\n"
            max = i
        else
            iol << "#{h[i][0]},,#{h[i][1]}\n"
        end

        #pp "#{h[i][0]},#{get_avg(h,i)},#{h[i][1]}\n"
    end
}


write_area(h[0..max],0,1,'wl_gyzs')

#############价格波动！
## TODO,read from db or tianyan?
##

