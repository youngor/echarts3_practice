require 'win32ole'
require 'date'

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

def replace_doc(doc, find, repl)
    begin
        word = WIN32OLE.new('Word.Application')
        word.Visible = true
        doc = word.Documents.Open(doc)

        word.Selection.HomeKey(unit=6)
        finder = word.Selection.Find
        finder.Text = "[#{find}]"

        while word.Selection.Find.Execute
            word.Selection.TypeText(text=repl)
        end

        doc.SaveAs(doc)
        doc.Close
    rescue Exception => e
        puts e.message
        puts "Unable to edit file."
    end
    #doc.sentences.each{ |x| @content = @content + x.text }

end



def gen_word_replace
    file =Dir.pwd+'./template.docx'

    word = WIN32OLE.new('Word.Application')
    word.visible = true
    old_doc = word.Documents.Open(file) 

    {
        '凯越' => '奔驰',
        'date' => Date.today.strftime('%B %d, %Y'),
        '2017' => '2018'
    }.each do |key, value|
        word.Selection.HomeKey(unit=6) # start at beginning
        find = word.Selection.Find
        find.Text = "#{key}" # text must be in square brackets
        while word.Selection.Find.Execute
            word.Selection.TypeText(text=value) #replace
        end
    end
    #old_doc.Activate
    old_doc.Content.InsertAfter (" The end.") 
    #puts f = old_doc.Content.Find("凯越")
    #puts f.Replacement("奔驰")
    #puts old_doc.Content.Find.Found 
    #puts old_doc.Content.Find.Execute "2017"
    #puts old_doc.Content.Find.Found 
    #puts old_doc.Content.Text
    #puts old_doc.Selection.Text


    #new_doc = word.documents.Add
    #text = old_doc.selection.
    #0.upto(10){
        #new_doc.Selection.TypeText("Hello Ruby Relatives!")
        #new_doc.Selection.TypeParagraph
    #}
    #old_doc.SaveAs Dir.pwd + "./out.doc"
    #new_doc.close
    old_doc.Save
    old_doc.close
    word.quit
end

gen_word_replace
