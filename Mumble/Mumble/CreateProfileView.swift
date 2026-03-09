import SwiftUI

struct CreateProfileView: View {
    
    @State private var name = ""
    @State private var interests = ""
    @State private var message = ""
    
    let baseURL = "http://127.0.0.1:8080/api/users"
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [Color.pink.opacity(0.6), Color.purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack(spacing: 25) {
                    
                    Text("Create Your Profile")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    VStack(spacing: 20) {
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.pink)
                            
                            TextField("Your Name", text: $name)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading) {
                            
                            Label("Your Interests", systemImage: "heart.fill")
                                .foregroundColor(.pink)
                            
                            TextEditor(text: $interests)
                                .frame(height: 120)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            createUser()
                        }) {
                            Text("Create Profile")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color.pink, Color.purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(14)
                                .shadow(radius: 10)
                        }
                        
                        if !message.isEmpty {
                            Text(message)
                                .fontWeight(.medium)
                                .foregroundColor(.green)
                        }
                    }
                    .padding(25)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 20)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func createUser() {
        guard let url = URL(string: baseURL) else { return }
        
        let newUser = User(id: nil, name: name, interests: interests)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(newUser)
        
        URLSession.shared.dataTask(with: request) { _, _, _ in
            DispatchQueue.main.async {
                message = "Profile Created ❤️"
                name = ""
                interests = ""
            }
        }.resume()
    }
}
