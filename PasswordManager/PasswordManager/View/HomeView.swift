//
//  HomeView.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI

struct HomeView: View {
    //MARK: - variable

    @State private var showDetailAccountSheet = false
    @StateObject var viewModel = PasswordViewModel(context: PersistenceController.shared.container.viewContext)
    @State private var showingAddEditView = false
    @State private var editableItem: PasswordTable?
    @State private var isEdit = false

    //MARK: - view
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                VStack(alignment: .leading){
                    viewHeader
                    Divider()
                }
                if viewModel.items.count > 0{
                    listPassword
                }else{
                    viewNoPassword
                }
            }
            btnAdd
        }.background(Color.backgroundColor)
        .sheet(isPresented: $showingAddEditView) {            
            AddEditAccountView(viewModel: viewModel, editableItem: $editableItem)
                .presentationDetents([.medium, .large])
               .presentationBackground(.thickMaterial)
               .presentationCornerRadius(30)
        }
        .sheet(isPresented: $showDetailAccountSheet, onDismiss: {
            if isEdit{
                showingAddEditView.toggle()
            }
        }) {
            AccountDetailView( viewModel: viewModel, editableItem: $editableItem, isEdit: $isEdit)
            .presentationDetents([.medium, .large])
           .presentationBackground(.thickMaterial)
           .presentationCornerRadius(30)
        }
    }

    private var viewHeader: some View{
        Text("Password Manager")
            .setFont(.titleColor, .sfProMedium, 20)
            .padding()
    }

    private var viewNoPassword: some View{
        VStack(alignment: .center){
            Spacer()
            Text("No saved Password")
            .setFont(.titleColor, .sfProMedium, 16)

            Spacer()
        }
    }

    private var listPassword: some View{
        NavigationStack {
            List{
                ForEach(viewModel.items) { item in
                    Button(action: {
                        self.editableItem = item
                        self.showDetailAccountSheet = true
                    }, label: {
                        PasswordRowView(password: item)
                        .padding(.bottom, 15)
                    })
                }.listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
        }
    }


    private var btnAdd: some View{
        Button(action: {
            self.editableItem = nil
            self.showingAddEditView = true
        }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
                .padding()
                .background(Color.blueColor)
                .dropShadowAndCorner(cornerRadius: 10)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
        .padding(.trailing, 20)
    }
}


#Preview {
    HomeView()
}
