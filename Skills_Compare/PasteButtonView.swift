//
//  PasteButtonView.swift
//  Capture_JOB_AnySite
//
//  Created by Web_Dev on 2/2/23.
//

import SwiftUI






struct PasteButtonView: View {
    
    var keyshortcut:KeyEquivalent
    @Binding var stateVariable:String
    var kkey:String

    
    enum CopyContent:Error {
        case notExist
    }
    
    func CopyFromClipboard_Paste() throws -> String {
        
        let p = NSPasteboard.general
        let x = p.readObjects(forClasses: [NSString.self], options: nil)
        let s = x as! [NSString]
        
        if 0 < s.count {
            return s[0] as String
        }
        throw CopyContent.notExist
        
    }
    
    func ReadFromClipboard() -> String {
        do {
            if let result =  try? CopyFromClipboard_Paste() {
               return result
            }
            throw CopyContent.notExist
        }
        catch let error {
            switch error{
                
            case CopyContent.notExist :
                print("not Exist")
                return ""
            default:
                print("default")
                return ""
            }
        }
    }

    
//    func AssignToStateVariable(fieldname:String)  {
//        stateVariable = stateVariable+" "+ReadFromClipboard()
//    }
    
    var body: some View {

        Button(action: {
            
            //appending with existing
            //stateVariable = stateVariable+" "+ReadFromClipboard()
            
            //DONT append
            stateVariable = ReadFromClipboard()
            
//            AssignToStateVariable(fieldname: fieldname)
            
        }){
            Image(systemName: "doc.on.doc").resizable()
                .frame(width: 50, height: 50).padding(5)
                        .foregroundColor(Color.black)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("paste"), Color("ClrTxtField")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(Rectangle())
        }.buttonStyle(PlainButtonStyle()).cornerRadius(6) .keyboardShortcut(keyshortcut, modifiers: [.command]).help("Press Command + "+kkey)
    }
}



struct PasteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PasteButtonView(keyshortcut: "o", stateVariable: .constant("company"), kkey: "o")
    }
}
