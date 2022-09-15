//
//  PostModelArray.swift
//  Housing Application
//
//

import Foundation
import SwiftUI




//housesviewmodel share same structure

class PostModelArray : ObservableObject
{
    
   
    @Published var dataArray = [PostModel]()
    @Published var posts = "5"
    
  
    
    init()
    {
        let post1 = PostModel(postId: "", userId: "", username: "Joe Breen", caption: "Test Caption1", streetName:  "kjkj", HouseFlat:"kjkj", Price:"1234", dateCreate: Date())
        let post2 = PostModel(postId: "", userId: "", username: "Emily Watson", caption: "Test Caption2",streetName:  "kjkj", HouseFlat:"kjkj",   dateCreate: Date())
        let post3 = PostModel(postId: "", userId: "", username: "Danny Granger", caption: "Test Caption3",streetName:  "kjkj", HouseFlat:"kjkj",   dateCreate: Date())
        let post4 = PostModel(postId: "", userId: "", username: "Jayson Tatum", caption: "Test Caption4", streetName:  "kjkj",HouseFlat:"kjkj",   dateCreate: Date())
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
    /// Used for getting single post
    init(post : PostModel)
    {
        self.dataArray.append(post)
    }
    

    
    ///Used for feed
    init(shuffled : Bool)
    {
        DataService.instance.downloadPostForFeed { returnedPosts in
            if shuffled
            {
                let shuffledPosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPosts)
            }
            else
            {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
//        self.updateCount()
    }
    
//    func updateCount()
//    {
//        self.posts = "\(self.dataArray.count)"
//
//        let likeCountArray = dataArray.map { exisitingPost in
//            return exisitingPost.likeCount
//        }
//
//        let likeSum = likeCountArray.reduce(0, +)
//        self.likeCount = "\(likeSum)"
//    }
}
