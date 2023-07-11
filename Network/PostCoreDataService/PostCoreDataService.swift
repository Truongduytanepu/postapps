////
////  File.swift
////  Ex1
////
////  Created by Trương Duy Tân on 21/06/2023.
////
//
//import Foundation
//import CoreData
//import UIKit
//
//protocol PostCoreDataService{
//    func index(page: Int,
//               pageSize: Int,
//               success: ((ArrayResponse<PostEntity>) -> Void)?,
//               failure: ((APIError?) -> Void)?)
//    func create(postEntity: PostEntity)
//    func clear()
//}
//
//class PostCoreDataServiceImpl: PostCoreDataService{
//    func index(page: Int, pageSize: Int, success: ((ArrayResponse<PostEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
//        guard let appDelegate = UIApplication.shared.delegate as?
//                AppDelegate else{return}
//        let mannagedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<PostEntity>(entityName: "Posts")
//
//        do{
//            //thêm vào array có sẵn
//            let posts = try mannagedContext.fetch(fetchRequest)
//            print(posts)
//
//            let postEntities = posts.map { post in
//                return PostEntity(id: post.id,
//                                  title: post.title)
//
//            }
//            success?(ArrayResponse(page: page, pageSize: pageSize, results: postEntities))
//        }catch let error as NSError{
//            print("Code not fetch. \(error), \(error.userInfo)")
//            success?(ArrayResponse())
//        }
//    }
//
//    func clear() {
//        guard let appDelegate = UIApplication.shared.delegate as?
//                AppDelegate else {return}
//
//        //lấy managed object context
//        let manageContext = appDelegate.persistentContainer.viewContext
//
//        // create fetch request
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
//        //initialize batch delete request
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do{
//            try manageContext.excute(deleteRequest)
//            try manageContext.save()
//        }catch{
//            // xử lý lỗi nếu có
//            ptinr("Failed to clear dât: \(error)")
//        }
//    }
//
//    func create(postEntity: PostEntity) {
//        <#code#>
//    }
//}
