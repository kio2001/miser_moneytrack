import SwiftUI

@main
struct HelloWorldApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var message: String = "Hello World"
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Text(message)
                .padding()
            Button(action: {
                fetchMessage()
            }) {
                Text(isLoading ? "Loading..." : "Fetch Message")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(isLoading)
        }
        .padding()
    }
    
    func fetchMessage() {
        guard let url = URL(string: "https://6pqgs2ecd7.execute-api.ap-northeast-1.amazonaws.com/stg/test") else {
            print("Invalid URL")
            return
        }
        
        isLoading = true
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let body = jsonResponse["body"] as? String {
                    DispatchQueue.main.async {
                        self.message = body
                    }
                }
            } catch {
                print("JSON parsing error: \(error)")
            }
        }
        
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
