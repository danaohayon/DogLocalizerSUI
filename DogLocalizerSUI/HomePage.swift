import SwiftUI

struct HomePage: View {
    @State private var image: UIImage?
    @State private var isImagePickerDisplayed = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary // Default source type
    @State private var showPhotoViewer = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {

                Color("panelColor")
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    Button(action: {
                        withAnimation {
                            print("Opening side menu")
                            navigationManager.isSideMenuOpen = true
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                    }
                    
                    Spacer()
                    Text("Made by Dana Ohayon")
                        .font(.custom("TrebuchetMS", size: 10))
                        .padding(.vertical, 5)
                        .foregroundColor(Color("AccentColor").opacity(0.7))
                    Spacer()
                    Button{
//                            print("Navigating to about page")
                            navigationManager.currentPage = "about"
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                    
                }.padding(.horizontal, 35)
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .padding(.top)
                
                VStack() {
                    Text("Dog Classification & Localization")
                        .font(.custom("TrebuchetMS", size: 30))
                        .fontWeight(.black)
                        .foregroundColor(Color("AccentColor"))
                        .multilineTextAlignment(.center)
                        .padding(.top, 25)
                    
                    ZStack {
                        // placeholder logo
                        Image(systemName:"pawprint.fill")
                            .font(.custom("TrebuchetMS", size: 24))
                            .fontWeight(.regular)
                            .foregroundColor(Color("titleColor").opacity(0.8))
                        //                        .padding(.top, 1)
                        Image(systemName: "pawprint")
                            .font(.custom("TrebuchetMS", size: 24))
                            .fontWeight(.regular)
                            .foregroundColor(Color("AccentColor"))
                        //                        .padding(.top, 1)
                    }.padding(.vertical, 1)
                    
                    
                    PhotoSwipeView()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    
                    HStack{
                        Text("Upload a photo of your dog and see their breed and a box around them, all done by my deep learning netwrok")
                            .font(.custom("TrebuchetMS", size: 12))
                            .foregroundColor(.accentColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    Button(action: {
                                    self.sourceType = .camera
                                    self.isImagePickerDisplayed = true
                                }, label:{
                                    HStack{
                                        Image(systemName: "camera")
                                            .foregroundColor(.accentColor)
                                            .font(.system(size:18))
                                            .padding(.bottom, 2)
                                        
                                        Text("Take photo")
                                            .font(.custom("TrebuchetMS", size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("AccentColor"))
                                            .padding(.leading, 5)
                                        
                                    }.padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color("backgroundColor").opacity(0.3))
                                        .cornerRadius(20)
                                        .padding(.top, 40)
                                        .padding(.bottom, 3)
                                })

                                if image != nil {
                                    PhotoViewerView(image: $image, chooseNewPhoto: {
                                        isImagePickerDisplayed = true
                                        sourceType = .photoLibrary // Ensure this is reset or managed correctly
                                    })
                                } else {
                                    Button {
                                        sourceType = .photoLibrary // Ensure this is set before showing the picker
                                        isImagePickerDisplayed = true
                                    } label: {
                                        HStack{
                                            Image(systemName: "square.and.arrow.up")
                                                .foregroundColor(.accentColor)
                                                .font(.system(size:17))
                                                .padding(.bottom, 2)
                                            
                                            Text("Choose photo")
                                                .font(.custom("TrebuchetMS", size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("AccentColor"))
                                                .padding(.leading, 1)
                                            
                                        }.padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color("backgroundColor").opacity(0.3))
                                            .cornerRadius(20)
                                            .padding(.top, 10)
                                    }
                                }
                            }.offset(y: 25)
                        }
                        .sheet(isPresented: $isImagePickerDisplayed) {
                            ImagePicker(sourceType: self.sourceType, selectedImage: $image)
                                .onDisappear {
                                    // Check if an image was selected and show PhotoViewer
                                    if image != nil {
                                        showPhotoViewer = true
                                    }
                                }
                        }
                        .fullScreenCover(isPresented: $showPhotoViewer) {
                            if let image = image {
                                PhotoViewerView(image: $image, chooseNewPhoto: {
                                    // Reset the image to allow reselection
                                    self.image = nil
                                    self.isImagePickerDisplayed = true
                                    self.showPhotoViewer = false
                                })
                            }
                        }
                    }
                }
            }

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(NavigationManager())
    }
}
