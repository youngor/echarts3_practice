chcp 65001

rem set cx1=凯越
set cx1=%1
cd 流向处理
rem ruby lxcl.rb

cd ..\网络数据
ruby wlsj.rb %cx1%

 pause

cd ..\周转天数
ruby zzts.rb

cd ..\..\client
ruby client_test.rb

cd ..\tools

del output /F /S /Q
mkdir output\%cx1%

xcopy /S /V /F /Y /I 流向处理\csv\*  output\%cx1%\流向处理
xcopy /S /V /F /Y /I 网络数据\csv\*  output\%cx1%\网络数据
xcopy /S /V /F /Y /I 周转天数\csv\*  output\%cx1%\周转天数

xcopy /S /V /F /Y /I ..\server\public\liuxiang\*  output\%cx1%\流向处理
xcopy /S /V /F /Y /I ..\server\public\wangluoshuju\* output\%cx1%\网络数据
xcopy /S /V /F /Y /I ..\server\public\zhouzhuantianshu\* output\%cx1%\周转天数
