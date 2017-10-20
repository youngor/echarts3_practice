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
    vo_arr << vo
    vl_arr << vl
end

vomax=vo_arr.max
vlmax=vl_arr.max

recs = []

File.open('csv/流向统计_out.csv', "w",:encoding=>"gbk") { |iol|  
    iol << head << "\n"
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

#head = "地区0,外迁量O1,流入量I2,本地过户量L3,总交易量Q(O+I+L）4,外迁率KO（O/Q）5,本地过户率KL（L/Q）6,外迁值VO(KO*O)的平方根7,外迁指数IO=VO/VOmax8,本地交易值VL(KL*L)的平方根9,本地交易指数IL=VL/Vlmax10"

        vo = to_n_point_float(vo)
        io = to_n_point_float(vo/vomax)
        vl = to_n_point_float(vl)
        il = to_n_point_float(vl/vlmax)

        iol << "#{c},#{o},#{i},#{l},#{q},#{ko},#{kl},#{vo},#{io},#{vl},#{il}\n"
        recs << [c,o,i,l,q,ko,kl,vo,io,vl,il]
    end
}

# "地区 本地过户率KL 本地交易指数IL  本地过户量L** "  => 本地交易TOP50城市
recs = recs.sort_by { |a| -a[3]  }  #本地过户量L

File.open('csv/本地交易TOP50城市_out.csv', "w",:encoding=>"gbk") { |iol|  
    iol << "地区,本地过户率KL,本地交易指数IL,本地过户量L*" << "\n"
    (0...50).each do |i|
        t = recs[i]
        iol << "#{t[0]},#{t[6]},#{t[10]},#{t[3]}\n"
    end
}

#
#pie 


#//{value:335, name:'直接访问'}, {value:310, name:'邮件营销'},
def write_pie(recs,name_col,val_col,file_name)
    str1 = ''
    min = 0
    max = 0

    (0..recs.length-1).each do |i|
        t = recs[i]
        str1 += '{value:' + t[val_col].to_s + ",name:'" + t[name_col].to_s  + "'},\n"
        
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

#//{name: '海门', value: 9}, {name: '大庆', value: 279}
def write_map(recs,name_col,val_col,file_name)
    str1 = ''
    min = 0
    max = 0

    (0..recs.length-1).each do |i|
        t = recs[i]
        str1 += '{value:' + t[val_col].to_s + ",name:'" + t[name_col].to_s  + "'},\n"
        min = t[val_col] if min > t[val_col]
        max = t[val_col] if max < t[val_col]
    end

    min = (min * 0.9).round
    max = (max * 1.1).round

    data = IO.read('../template/map.template',:encoding=>"utf-8")
    data.gsub!(/PARAM0/,"#{str1}")
    data.gsub!(/PARAM1/,"#{$cities_gis}")
    data.gsub!(/PARAM2/,"#{min}")
    data.gsub!(/PARAM3/,"#{max}")

    puts data

    IO.write("../../server/public/my_js/#{file_name}.js",data,:encoding=>"utf-8")
end

write_map(recs,0,3,'bd_top50')


# 地区  外迁率vo 外迁指数io    外迁量o** => 外迁TOP50城市

recs = recs.sort_by { |a| -a[1]  }  #外迁量o**

File.open('csv/外迁TOP50城市_out.csv', "w",:encoding=>"gbk") { |iol|  
    iol << "地区,外迁率vo,外迁指数io,外迁量o*" << "\n"
    (0...50).each do |i|
        t = recs[i]
        iol << "#{t[0]},#{t[7]},#{t[8]},#{t[1]}\n"
    end
}

write_map(recs,0,1,'w_top50')

#五个城市是 recs[0..4]
#puts recs[0..4].join(',')



#年份0  季度1  企业2  品牌3  车型4  排量5  原城市6 流向城市7    车龄年8 数量9
org = []
File.foreach('csv/原始数据.csv', :encoding=>"gbk") { |iol|  
    org << iol.split(/,/)
}

#puts org[1]
#pp org[1]

def sum(org,org_c,tar_c)
    #pp "#{org_c}"
    #pp "#{tar_c}"
    t = org.select { |e|  e[6] == org_c and e[7] == tar_c}
    #t = org.select { |e|  pp "#{org_c},#{tar_c},#{e[6]},#{e[7]}",e[6] == org_c and e[7] == tar_c}
    #pp t
    s = 0
    t.each { |e| s+= e[9].to_i }
    s
end

ec = Encoding::Converter.new("utf-8", "gbk")

#puts sum(org,ec.convert('北京市'),ec.convert('长沙市'))
#exit


# 流出目标地区  外迁量(**) 集中度(top 15) ==> 外迁TOP1..5
def sum_org_waiqian(c,org,cities,n)
    ec = Encoding::Converter.new("utf-8", "gbk")

    arr = []
    cities.each do |i|
        #puts i,c
        next if c == i
        arr << [i,sum(org,ec.convert(c),ec.convert(i))]
    end

    arr = arr.sort_by { |e|  -e[1]}

    t15 = 0
    (0..14).each do |i|
        t15 += arr[i][1].to_i
    end

    total = 0
    (0...arr.length).each do |i|
        total += arr[i][1].to_i
    end

    File.open("csv/外迁TOP#{n}_out.csv", "w",:encoding=>"gbk") { |iol|  
        iol << "#{c}流出目标地区,外迁量o*" << "\n"
        arr.each do |i|
            iol << "#{i.join(',')}\n"
        end
        iol << "max: #{to_n_point_float(t15/total.to_f)*100}%"
    }

    write_pie(arr[0..4],0,1,"w_t#{n}_1")
    write_map(arr,0,1,"w_t#{n}_2")
end

(0..4).each do |i|
    puts "processing #{i}...."
    sum_org_waiqian(recs[i][0],org,$cities,i+1)
end






