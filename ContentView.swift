//
//  ContentView.swift
//  SwiftUI3
//
//  Created by Stuart Rankin on 4/29/21.
//

import SwiftUI


struct Item1: View
{
    var body: some View
    {
        ScrollView
        {
            HStack
            {
                Text("Left")
                Spacer()
                Text("Right")
            }
            .padding()
        }
    }
}

struct Item2: View
{
    var body: some View
    {
        GeometryReader
        {
            Geometry in
        ScrollView
        {
            Image(systemName: "applelogo")
                .foregroundColor(.red)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
        .frame(width: Geometry.size.width,
               height: Geometry.size.height)
        }
    }
}

struct Item3: View
{
    @State var Toggle1: Bool = true
    @State var Toggle2: Bool = true
    @State var Toggle3: Bool = true
    @State var Toggle4: Bool = true
    
    var body: some View
    {
        ScrollView
        {
            Toggle(isOn: $Toggle1,
                   label: {
                    Text("Enable feature 1")
                   }).padding()
            Toggle(isOn: $Toggle2,
                   label: {
                    Text("Enable feature 2")
                   }).padding()
            Toggle(isOn: $Toggle3,
                   label: {
                    Text("Enable feature 3")
                   }).padding()
            Toggle(isOn: $Toggle4,
                   label: {
                    Text("Enable feature 4")
                   }).padding()
        }
    }
}

struct Item4: View
{
    @State var Toggle1: Bool = true
    @State var Toggle2: Bool = true
    @State var Toggle3: Bool = true
    @State var Toggle4: Bool = true
    @State var Text1: String = ""
    
    var body: some View
    {
        ScrollView
        {
            Toggle(isOn: $Toggle1,
                   label: {
                    Text("Enable feature 1")
                   }).padding()
            TextField("ralph the rabid roadkill",
                      text: $Text1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .font(.custom("Avenir-Book", size: 26.0))
            Toggle(isOn: $Toggle2,
                   label: {
                    Text("Enable feature 2")
                   }).padding()
            Toggle(isOn: $Toggle3,
                   label: {
                    Text("Enable feature 3")
                   }).padding()
            Toggle(isOn: $Toggle4,
                   label: {
                    Text("Enable feature 4")
                   }).padding()
        }
    }
}

struct UnexpectedView: View
{
    var body: some View
    {
        Text("Unexpected option.")
    }
}

struct FirstPage: View
{
    var body: some View
    {
        NavigationView
        {
            ScrollView
            {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                Text("Item 4")
                Text("Item 5")
                Text("Item 6")
                Text("Item 7")
                Text("Item 8")
                Text("Item 9")
                Text("Item 10")
                    .navigationBarTitle(Text("First Page"))
            }
        }
    }
}

struct ThirdPage: View
{
    var body: some View
    {
        NavigationView
        {
            ScrollView
            {
                Text("Item 一")
                Text("Item 二")
                Text("Item 三")
                Text("Item 四")
                Text("Item 五")
                Text("Item 六")
                Text("Item 七")
                Text("Item 八")
                Text("Item 九")
                Text("Item 十")
                    .navigationBarTitle(Text("Third Page"))
            }
        }
    }
}

struct RunTestView: View
{
    @State var ShowView: String
    
    var body: some View
    {
        switch ShowView
        {
            case "First":
                FirstPage()
                
            case "Third":
                ThirdPage()
            
            default:
                UnexpectedView()
        }
    }
}

struct LinkItem: View
{
    @State var ImageName: String
    @State var Headline: String
    @State var SubHeadline: String
    
    var body: some View
    {
        Image(systemName: ImageName)
            .foregroundColor(Color.red)
            .shadow(radius: 3)
            .padding()
        VStack(alignment: .leading)
        {
            Text(Headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text(SubHeadline)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        Spacer()
        Image(systemName: "chevron.right")
            .foregroundColor(.gray)
            .padding()
    }
}

struct Item5: View
{
    @State var Toggle1: Bool = true
    @State var IsActive: Bool = true
    
    var body: some View
    {
        ScrollView
        {
            NavigationLink(destination: RunTestView(ShowView: "First"))
            {
                LinkItem(ImageName: "01.circle",
                         Headline: "First item",
                         SubHeadline: "The very first item.")
            }
      
            HStack
            {
                Image(systemName: "02.circle.fill")
                    .foregroundColor(Color(UIColor.darkGray))
                    .shadow(radius: 3)
                    .padding()
                VStack(alignment: .leading)
                {
                    Text("Second item")
                        .fontWeight(.bold)
                    Text("Second switch item")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Toggle(isOn: $Toggle1,
                       label: {
                        Text("")
                       }).padding()
            }

            NavigationLink(destination: RunTestView(ShowView: "Third"))
            {
                LinkItem(ImageName: "03.circle",
                         Headline: "Third item",
                         SubHeadline: "The very last item")
            }
            
            Spacer()
        }
        .navigationBarTitle(Text("Homogeneous Test"))
    }
}

//https://stackoverflow.com/questions/56938805/how-to-pass-one-swiftui-view-as-a-variable-to-another-view-struct
struct TestView<Content: View>: View
{
    let ViewMaker: () -> Content
    @State var IsVisible: Bool = true
    
    var body: some View
    {
        ViewMaker()
    }
}

struct TestView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TestView
        {
            Text("Test 1")
        }
    }
}

struct RandomView: View
{
    @Binding var RandomIndex: Int
    
    var body: some View
    {
        switch RandomIndex
        {
            case 1:
                TestView
                {
                    Item1()
                }
                
            case 2:
                TestView
                {
                    Item2()
                }
                
            case 3:
                TestView
                {
                    Item3()
                }
                
            case 4:
                TestView
                {
                    Item4()
                }
                
            case 5:
                TestView
                {
                    Item5()
                }
                
            default:
                TestView
                {
                    Item1()
                }
        }
    }
}

struct ContentView: View
{
    @State var Index = 5
    
    var body: some View
    {
        NavigationView
        {
            RandomView(RandomIndex: $Index)
                .navigationBarTitle(Text("View \(Index)"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content:
                            {
                                ToolbarItem(placement: .navigationBarTrailing)
                                {
                                    Button("Next")
                                    {
                                        self.Index = self.Index + 1
                                        if self.Index > 5
                                        {
                                            self.Index = 1
                                        }
                                    }
                                }
                            })
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
