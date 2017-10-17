require 'rubygems'
require 'sinatra'
require 'open-uri'
require "base64" 

  get '/' do
         '----------'
  end

=begin
$picInfo = $_POST['baseimg'];

　　$streamFileRand = date('YmdHis').rand(1000,9999); //图片名

　　$picType ='.png';//图片后缀

　　$streamFilename = "/www/echarts/".$streamFileRand .$picType; //图片保存地址

　　preg_match('/(?<=base64,)[\S|\s]+/',$picInfo,$picInfoW);//处理base64文本

　　file_put_contents($streamFilename,base64_decode($picInfoW[0]));//文件写入

data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAlgAAAGQCAYAAAByNR6YAAAgAElEQVR4nO3dT2wkZ3rfcZ6TS98C33jMiVNTRSpaY5O04aFGzl9CpAADwYZNYbq0MWKbCZIcmD20RjHiTdZ50504XCW2mrazM0w4XQUkAI1NYJSGs80q2Ic2ViNE4KWB6JBjz8F35tBVVLGm+v+f532rvh/ggUZk/+EUNcOfnvep993YAAAAAAAAAAAAAAAAAAAUluM4p47jHEp/HQAAAAsJLKtytWOrVzsPe1c7DwdXOw9vl1T9l9tWY9T72rZ94jjO7ZR1Gj/nsW3blzmvdWnb9knmY1vJ83I+fjvmazpN/Tr367Fte2vGywwAAMrk5bbVWGKoe
=end

  post '/' do
    b = /(?<=base64,)[\S|\s]+/.match(params['baseimg'])
    puts   b  
    File.open("myfile.png","wb") {|f|
        f.write(Base64.decode64(b.to_s))  
    }
    'done!' #+ params.to_s

  end             
