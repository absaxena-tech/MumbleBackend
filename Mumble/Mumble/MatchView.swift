import SwiftUI

struct MatchView: View {
    
    @State private var users: [User] = []
    @State private var selectedUser1: User?
    @State private var selectedUser2: User?
    @State private var matchPercentage: Double?
    
    let baseURL = "http://127.0.0.1:8080/api/users"
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Find Match 💘")
                .font(.title)
                .bold()
            
            Picker("User 1", selection: $selectedUser1) {
                Text("Select User 1").tag(User?.none)
                ForEach(users, id: \.self) { user in
                    Text(user.name).tag(Optional(user))
                }
            }
            .pickerStyle(.menu)
            
            Picker("User 2", selection: $selectedUser2) {
                Text("Select User 2").tag(User?.none)
                ForEach(users, id: \.self) { user in
                    Text(user.name).tag(Optional(user))
                }
            }
            .pickerStyle(.menu)
            
            Button("Calculate Match") {
                calculateMatch()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            if let match = matchPercentage {
                Text("\(String(format: "%.0f", match))% Compatible ❤️")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.pink)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            fetchUsers()
        }
    }
    
    func fetchUsers() {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let decoded = try? JSONDecoder().decode([User].self, from: data) {
                DispatchQueue.main.async {
                    users = decoded
                }
            }
        }.resume()
    }
    
    func calculateMatch() {
        guard let user1 = selectedUser1,
              let user2 = selectedUser2,
              let id1 = user1.id,
              let id2 = user2.id else { return }
        
        let matchURL = "\(baseURL)/match?user1=\(id1)&user2=\(id2)"
        
        guard let url = URL(string: matchURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let result = try? JSONDecoder().decode(Double.self, from: data) {
                DispatchQueue.main.async {
                    matchPercentage = result
                }
            }
        }.resume()
    }
}

