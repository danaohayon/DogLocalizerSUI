import SwiftUI
struct About: View {
    
    @Binding var isAboutOpen: Bool
    
    var body: some View {
        
            ZStack(alignment: .center){
                Color("panelColor")
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(width: 350, height: 770)
                    .cornerRadius(25)
                Color(.brown.opacity(0.1))
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(width: 350, height: 770)
                    .cornerRadius(25)
                ScrollView {
                VStack(alignment: .center) {
                    
                    Text("About My Project")
                        .font(.custom("TrebuchetMS", size: 20))
                        .fontWeight(.bold)
                    
                    Rectangle()
                        .frame(width: 200, height: 1)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical, 5)
                    
                    Text("My project is an app, meant to help people discover the breed of dogs they find and / or adopt. \n my app is built on the basis of a Convolutional Neural Network, specifically using transfer learning from the Xception network. \n Any extra training or tuning I did was done using the Stanford Dogs dataset of 120 different dog breeds. \n My network can also draw a bounding box around the dog in the photo, to better demonstrate its learning.")
                        .font(.custom("TrebuchetMS", size: 13))
                        .lineSpacing(10.0)
                        .padding(.bottom)
                    
                    Text("How does it work?")
                        .font(.custom("TrebuchetMS", size: 15))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text("When you input a photo into the app it undergoes a few steps:")
                        .font(.custom("TrebuchetMS", size: 13))
                        .lineSpacing(10.0)
                    
                    Image("photo1")
                        .resizable()
                        .scaledToFit()
                        .padding(.all)
                    
                    Text("1. It gets resized to a 224x224 image, to fit my model's requirements.")
                        .font(.custom("TrebuchetMS", size: 13))
                        .lineSpacing(10.0)
                    
                    Image("photo3")
                        .resizable()
                        .scaledToFit()
                        .padding(.all)
                    
                    Text("2. It is passed through the model on Inference mode, to return a prediction. \n 3. The prediction is then transformed into a breed and a bounding box.")
                        .font(.custom("TrebuchetMS", size: 13))
                        .lineSpacing(10.0)
                        .padding(.horizontal, 10)
                    
//                    Text ("3. The prediction is then transformed into a breed and a bounding box.")
//                        .font(.custom("TrebuchetMS", size: 13))
//                        .lineSpacing(10.0)
                    
                    Image("photo4")
                        .resizable()
                        .scaledToFit()
                        .padding(.all)
                    
                    Spacer()
                }.offset(y: 20)
                    .frame(width: 300)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.horizontal)
                
                    Button(action: {
                        withAnimation {
                            isAboutOpen = false
                        }
                    }) {
                        HStack{
                            Image(systemName:"xmark")
                                .foregroundColor(Color("AccentColor"))
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                                .offset(y: 2)
                            Text("close")
                                .font(.custom("TrebuchetMS", size: 18))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                
                }.offset(y: 330)
              
            }
        
        }.offset(y: 40)

    }

}
