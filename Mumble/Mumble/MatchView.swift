import SwiftUI

struct MatchView: View {
    
    @State private var users: [User] = []
    
    @State private var selectedUser1Id: Int?
    @State private var selectedUser2Id: Int?
    
    @State private var matchResult: String = ""
    @State private var isLoading: Bool = false
    
    let baseURL = "http://127.0.0.1:8080/api/users"
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [Color.pink.opacity(0.35), Color.purple.opacity(0.35)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 35) {
                    
                    Text("Love Match 💘")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.top,20)
                    
                    
                    // USER CARD
                    
                    VStack(spacing: 25) {
                        
                        userPicker(
                            title: "Select First User",
                            icon: "person.fill",
                            selection: $selectedUser1Id
                        )
                        
                        userPicker(
                            title: "Select Second User",
                            icon: "person.2.fill",
                            selection: $selectedUser2Id
                        )
                        
                    }
                    .padding(25)
                    .background(Color.white.opacity(0.95))
                    .cornerRadius(22)
                    .shadow(color: .black.opacity(0.15), radius: 15)
                    
                    
                    // BUTTON
                    
                    Button {
                        calculateMatch()
                    } label: {
                        
                        HStack {
                            
                            if isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Image(systemName: "heart.fill")
                            }
                            
                            Text(isLoading ? "Finding Match..." : "Find Match %")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.red, Color.pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: .pink.opacity(0.4), radius: 12)
                    }
                    .disabled(selectedUser1Id == nil || selectedUser2Id == nil || isLoading)
                    .opacity((selectedUser1Id == nil || selectedUser2Id == nil) ? 0.6 : 1)
                    
                    
                    // LOADER
                    
                    if isLoading {
                        
                        VStack(spacing: 12) {
                            
                            ProgressView()
                                .scaleEffect(1.6)
                            
                            Text("AI analyzing compatibility...")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth:.infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 8)
                    }
                    
                    
                    // RESULT
                    
                    if !matchResult.isEmpty {
                        
                        VStack(spacing: 15) {
                            
                            Image(systemName: "sparkles")
                                .font(.largeTitle)
                                .foregroundColor(.pink)
                            
                            if let u1 = users.first(where: {$0.id == selectedUser1Id}),
                               let u2 = users.first(where: {$0.id == selectedUser2Id}) {
                                
                                Text("\(u1.name) ❤️ \(u2.name)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                            
                            Divider()
                            
                            Text(matchResult)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding()
                            
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(22)
                        .shadow(radius: 10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            fetchUsers()
        }
    }
    
    
    // USER PICKER
    
    func userPicker(title:String,
                    icon:String,
                    selection:Binding<Int?>) -> some View {
        
        VStack(alignment:.leading, spacing:10) {
            
            HStack(spacing:8){
                Image(systemName: icon)
                Text(title)
                    .font(.headline)
            }
            
            Picker("User", selection: selection) {
                
                Text("Choose user").tag(Int?.none)
                
                ForEach(users) { user in
                    Text(user.name).tag(Optional(user.id))
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth:.infinity)
            .padding()
            .background(Color.gray.opacity(0.08))
            .cornerRadius(12)
        }
    }
    
    
    // FETCH USERS
    
    func fetchUsers(){
        
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with:url){ data,_,error in
            
            if let data = data,
               let decoded = try? JSONDecoder().decode([User].self, from:data){
                
                DispatchQueue.main.async{
                    users = decoded
                }
            }
            
        }.resume()
    }
    
    
    // MATCH
    
    func calculateMatch(){
        
        guard let id1 = selectedUser1Id,
              let id2 = selectedUser2Id else { return }
        
        if id1 == id2 {
            matchResult = "⚠️ Please select two different users."
            return
        }
        
        isLoading = true
        matchResult = ""
        
        let matchURL = "\(baseURL)/match?user1=\(id1)&user2=\(id2)"
        
        guard let url = URL(string: matchURL) else { return }
        
        URLSession.shared.dataTask(with:url){ data,_,_ in
            
            DispatchQueue.main.async{
                isLoading = false
            }
            
            if let data = data,
               let result = String(data:data, encoding:.utf8){
                
                DispatchQueue.main.async{
                    matchResult = result
                }
            }
            
        }.resume()
    }
}
