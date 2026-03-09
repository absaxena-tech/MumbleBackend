import SwiftUI

struct HomeView: View {
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.4, blue: 0.6),
                    Color.purple
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white.opacity(0.15))
                        .font(.system(size: 80))
                        .offset(x: animate ? -30 : 30, y: -200)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white.opacity(0.15))
                        .font(.system(size: 100))
                        .offset(x: animate ? 30 : -30, y: 200)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 4).repeatForever()) {
                    animate.toggle()
                }
            }
            
            VStack(spacing: 40) {
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Text("Mumble")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Interest Matching Platform 💕")
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    
                    NavigationLink(destination: CreateProfileView()) {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.plus")
                            Text("Create Profile")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.pink)
                        .cornerRadius(18)
                    }
                    
                    NavigationLink(destination: MatchView()) {
                        HStack {
                            Image(systemName: "heart.circle.fill")
                            Text("Find Matches")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThinMaterial)
                        .foregroundColor(.white)
                        .cornerRadius(18)
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
        }
    }
}
