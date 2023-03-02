//
//  ThreeDSAuthView.swift
//  PayPal3dS2
//
//  Created by Yoseph Tilahun on 1/20/23.
//

import SwiftUI

public struct ThreeDSAuthView: View {
    @State var no1: String = ""
    @State var no2: String = ""
    @State var no3: String = ""
    @State var no4: String = ""
    @State var no5: String = ""
    @State var title: String = "Verify"
    @State var enterdValue: String = ""
    @State private var emailChecked = false
    @State private var phoneChecked = false
    @State private var shouldAnimate = false
    @State private var shouldResend = false


    enum Field {
        case no1
        case no2
        case no3
        case no4
        case no5
    }
    //YTYT

    @State var showingDetail = false
    @State private var willMoveToNextScreen = false
    @FocusState private var focusedField: Field?

    @Environment(\.presentationMode) var presentationMode
    @State private var isNavigationBarHidden = true

    func validateUserOTP() async {

       // goHomePage()

    }
    public var body: some View {

                VStack {
                    VStack {
                        Image("Paypal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .imageScale(.large)
                            .frame(width: 600, height: 150).padding()
                            .shadow(radius: 10)
                    }

                Text("Enter otp code")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue).padding(30)

                VStack {
                    ZStack {
                        HStack {

                            TextField("", text: $no1)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 50)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .no1)
                                .onChange(of: no1) { newValue in
                                    if newValue.count == 1 {

                                        focusedField = .no2
                                    }
                                }.onAppear {
                                    focusedField = .no1
                                }


                            TextField("", text: $no2)
                                .padding()

                                .foregroundColor(Color.white)
                                .frame(width: 50)

                                .background(Color.blue)
                                .clipShape(Circle())
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .no2)
                                .onChange(of: no2) { newValue in
                                    if newValue.count == 1 {
                                        focusedField = .no3
                                    }
                                }

                            TextField("", text: $no3)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 50)
                                .background(Color.blue)
                                .clipShape(Circle())

                                .foregroundColor(Color.blue)

                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .no3)
                                .onChange(of: no3) { newValue in
                                    if newValue.count == 1 {
                                        focusedField = .no4
                                    }
                                }

                            TextField("", text: $no4)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 50)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .no4)
                                .onChange(of: no4) { newValue in
                                    if newValue.count == 1 {
                                        focusedField = .no5
                                    }
                                }

                            TextField("", text: $no5)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 50)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .no5)
                                .onChange(of: no5) { newValue in
                                    if newValue.count == 1 {
                                        self.no5 = newValue
                                        focusedField = .no5
                                    }
                                    enterdValue = String(format: "%@%@%@%@%@",no1,no2,no3,no4,no5)
                                }
                        }}

                    Button(action: {
                        self.shouldAnimate.toggle()
                        Task.init {
                            await self.goHomePage(verify: true)
                        }}) {
                            HStack(alignment: .center) {
                                Spacer()
                                ZStack {
                                    ActivityIndicator(shouldAnimate: self.$shouldAnimate, color: UIColor(Color.white))
                                    Text("Verify").foregroundColor(Color.white).bold()
                                }
                                Spacer()
                            }
                        }.overlay(
                            RoundedRectangle(cornerRadius: 25.0).stroke(Color.blue, lineWidth: 2).frame(width: 360, height: 60))
                        .font(.headline).foregroundColor(Color.white)
                        .frame(width: 360, height: 60, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(25.0)
                        .padding(10)


                    Button(action: {
                        self.shouldResend.toggle()
                        Task.init {
                            await self.goHomePage(verify: false)
                        }}) {
                            HStack(alignment: .center) {
                                Spacer()
                                ZStack {
                                    ActivityIndicator(shouldAnimate: self.$shouldResend, color: UIColor(Color.white))
                                    Text("Resend").foregroundColor(Color.white).bold()
                                }
                                Spacer()
                            }
                        }.overlay(
                            RoundedRectangle(cornerRadius: 25.0).stroke(Color.blue, lineWidth: 2).frame(width: 360, height: 60))
                        .font(.headline).foregroundColor(Color.white)
                        .frame(width: 360, height: 60, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(25.0)
                        .padding(10)


                        VStack {
                            //HStack(alignment: .top) {
                            HStack {
                                CheckBoxView(checked: $emailChecked).padding()
                                Text("Send to email yy**.yahoo.com").foregroundColor(.blue)
                            }
                            HStack {
                                CheckBoxView(checked: $phoneChecked).padding()
                                Text("Send to phone .         ***-***-5608").foregroundColor(.blue)
                            }
                        }.font(.headline).foregroundColor(Color.white)

                }}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).background(.white)
                .edgesIgnoringSafeArea(.all)



                .navigationBarHidden(isNavigationBarHidden)
                .navigationBarTitle(" ")
                .onAppear {
                    self.isNavigationBarHidden = false
                }
                .onDisappear {
                    self.isNavigationBarHidden = true
                }

          //      .navigate(to: ContentView(), hideNavBar: true, when: $willMoveToNextScreen)
    }

    func goHomePage(verify: Bool ) async {
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            if verify {
                self.shouldAnimate.toggle()
                self.willMoveToNextScreen.toggle()
            } else {
                self.shouldResend.toggle()
            }
        }
    }
}


struct ThreeDSAuthView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDSAuthView()
    }
}

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, hideNavBar: Bool,  when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(hideNavBar)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(hideNavBar),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
