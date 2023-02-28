//
//  ContentView.swift
//  Skills_Compare
//
//  Created by Web_Dev on 2/28/23.
//

import SwiftUI
import CoreData


//    All Skills --->  Command + L

//    Skills by Category --->  Command + G

//    Resume Skills --->  Command + R

//    Compare Skills --->  Command + O

//    Clear --->  Command + K

//    Copy --->  Command + P


struct MainView: View {
    //    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    
    @State var all_Skills:String = ""
    @State var website_Skills:String = ""
    @State var resume_Skills:String = ""
    @State var missing_Skills:String = ""
    
    func ClearAllState() {
        all_Skills = ""
        website_Skills = ""
        resume_Skills = ""
        missing_Skills = ""
    }
    
    func Convert_LowerCase_Trim(inputString:String) -> String {
        if(inputString==""){
            return ""
        }
        return inputString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func ReplacetheSkillOccurances(skills:String,singleSkill:String) -> String {
        
       var finalresult = skills
        
        let skillName = singleSkill.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //word having single space
        let regTxt = "\\s" + skillName + "\\s"
        
        
        do {
            let atSearch = try Regex(regTxt.trimmingCharacters(in: .whitespacesAndNewlines)).ignoresCase()
            
            finalresult = finalresult.replacing(atSearch, with: "")
            
        } catch {
            print("Failed to create regex")
        }

        finalresult = finalresult.replacingOccurrences(of: ",,", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        return finalresult
        
    }
    
    
    func Compare_Skills() {
        
        self.missing_Skills = ""

        if(self.all_Skills == "")
        {
           print("All Skills Textbox should never be empty")
           return
        }

        var skill_by_category = self.website_Skills
        var resume_skills = self.resume_Skills
        
        if(skill_by_category == "")
        {
            skill_by_category = self.all_Skills
        }
        else
        {
            skill_by_category = skill_by_category.replacingOccurrences(of: "Technology Found", with: "", options: NSString.CompareOptions.literal, range: nil)
            skill_by_category = skill_by_category.replacingOccurrences(of: self.all_Skills, with: "", options: NSString.CompareOptions.literal, range: nil)
        }
        
        
        resume_skills = Convert_LowerCase_Trim(inputString: resume_skills)
        let arr_all_skills = self.all_Skills.components(separatedBy: ",")
        
        for skill_name in arr_all_skills {
            let currSkills = skill_name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            if (resume_skills.contains(currSkills)) {
                
                skill_by_category = ReplacetheSkillOccurances(skills: skill_by_category, singleSkill: skill_name)
            }
        }
        
        self.missing_Skills = skill_by_category

    
    }
    
    
    
    var body: some View {
        
        HStack {
            HStack {
                VStack {
                    HStack {
                        Spacer()

                        Text("Skills in Website")
                            .font(.largeTitle)
                        Spacer()
                    }
                    
                    HStack {
                        
                        let kequi:KeyEquivalent = "l"
                        PasteButtonView(keyshortcut: kequi,stateVariable:$all_Skills,kkey:"L")
                       
                        
                        Text("All Skills")
                            .font(.title)
                            .foregroundColor(.yellow)
                        Text("must be (,) delimiter")
                            .font(.title3)
                            .foregroundColor(.yellow)
   
                        Spacer()
                    }

                    TextEditor(text: $all_Skills)
                        .onChange(of: all_Skills, perform: { value in
//                            print("Value of text modified to = \(text)")
                            Compare_Skills()
                            
                        })
                        .frame(height: 200)
                        .multilineTextAlignment(.leading)
                        .cornerRadius(25)
                        .font(Font.custom("AvenirNext-Regular", size: 20, relativeTo: .body))
                        .disableAutocorrection(true)
                        .border(Color.gray, width: 3)
                        .padding([.leading, .bottom, .trailing])
                    
                    
                    
                    HStack {
                        let kequi:KeyEquivalent = "g"
                        PasteButtonView(keyshortcut: kequi,stateVariable:$website_Skills,kkey:"G")
                        Text("Skills by Category")
                            .font(.title)
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                    
                    TextEditor(text: $website_Skills)
                        .onChange(of:website_Skills, perform: { value in
//                            print("Value of text modified to = \(text)")
                            Compare_Skills()
                            
                        })
                        .multilineTextAlignment(.leading)
                        .cornerRadius(25)
                        .font(Font.custom("AvenirNext-Regular", size: 20, relativeTo: .body))
                        .disableAutocorrection(true)
                        .border(Color.gray, width: 3)
                        .padding([.leading, .bottom, .trailing])

                    Spacer()
                }
                .padding()
                Spacer()
            }
            .padding()
            HStack {
                Spacer()
                VStack {
                    Spacer()
                        .frame(height: 30)
                        .clipped()
                    HStack {
                        Spacer()
                        
                        
                        Button("Compare") {
                            Compare_Skills()
                            
                        }    .keyboardShortcut("o", modifiers: [.command])
                            .font(.title)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .font(.system(size: 10))
                            .foregroundColor(Color.white)
                            .background(.orange.opacity(0.5))
                            .buttonStyle(PlainButtonStyle())
                            .mask {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                            }
                        
                        
                        Spacer()
                            .frame(width: 40)
                            .clipped()
                        
                        
                        
                        Button("Clear") {
                            ClearAllState()
                           
                        }    .keyboardShortcut("k", modifiers: [.command])
                            .font(.title)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .font(.system(size: 10))
                            .foregroundColor(Color.white)
                            .background(.orange.opacity(0.5))
                            .buttonStyle(PlainButtonStyle())
                            .mask {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                            }
                        
                        
                        
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 30)
                        .clipped()
                    VStack {
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            Button("Copy") {
                                
                                let pasteboard = NSPasteboard.general
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(self.missing_Skills, forType: .string)
                                
                            }    .keyboardShortcut("p", modifiers: [.command])
                                .font(.title)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .font(.system(size: 10))
                                .foregroundColor(Color.white)
                                .background(.orange.opacity(0.5))
                                .buttonStyle(PlainButtonStyle())
                                .mask {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                }
                            Spacer()
                            
                            Text("Missing Skills")
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                            Spacer()
                        }

                        
                        
                        TextEditor(text: $missing_Skills)
                            .multilineTextAlignment(.leading)
                            .cornerRadius(25)
                            .font(Font.custom("AvenirNext-Regular", size: 20, relativeTo: .body))
                            .disableAutocorrection(true)
                            .border(Color.gray, width: 3)
                            .padding([.leading, .bottom, .trailing])
                    }
                }
            }
            .padding()
            .padding(.bottom, 40)
            HStack {
                VStack {
                    HStack {

                        let kequi:KeyEquivalent = "r"
                        PasteButtonView(keyshortcut: kequi,stateVariable:$resume_Skills,kkey:"R")
                        Spacer()
                            .frame(width: 30)
                            .clipped()
                        Text("Skills in Resume")
                            .font(.largeTitle)
                    }
                    
                    TextEditor(text: $resume_Skills)
                        .onChange(of: resume_Skills, perform: { value in
//                            print("Value of text modified to = \(text)")
                            Compare_Skills()
                            
                        })
                        .multilineTextAlignment(.leading)
                        .cornerRadius(25)
                        .font(Font.custom("AvenirNext-Regular", size: 20, relativeTo: .body))
                        .disableAutocorrection(true)
                        .border(Color.gray, width: 3)
                        .padding([.leading, .bottom, .trailing])

                    Spacer()
                }
                .padding()
            }
            .padding()
        }
        .frame(width: 1200, height: 1000)
        .clipped()
        .background(Color(.sRGB, red: 40/255, green: 44/255, blue: 51/255))
        .background {
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(Color.white)
        }
    }
    
}




    
    
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
  

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
//}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
