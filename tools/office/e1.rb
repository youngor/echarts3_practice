require 'win32ole'

def excel
    #file ='c:/temp/15w_1708.xlsx'
    file =Dir.pwd+'./15w_1708.xlsx'

    excel = WIN32OLE.new('Excel.Application')
    excel.visible = true
    excel.WorkBooks.Open(file)
    worksheet = excel.ActiveWorkbook.WorkSheets(1)
end

def word
    file ='c:/temp/t1.docx'

    word = WIN32OLE.new('Word.Application')
    word.visible = true
    worddoc = word.Documents.Open(file)
    
    0.upto(10){
        worddoc.Content.Text="asdf"
    }
    #worksheet = excel.ActiveWorkbook.WorkSheets(1)
end


def outlook
    file ='c:/temp/t1.docx'
    outlook = WIN32OLE.new('Outlook.Application') 
    #outlook.visible = true    
    message = outlook.CreateItem(0)     
    message.Subject = 'Subject line here'    
    message.Body = 'This is the body of your message.'     
    message.To = 'xiaofan2350@yahoo.com.cn'     
    message.Attachments.Add(file, 1)     
    message.Send 
end

#outlook
#excel
#word