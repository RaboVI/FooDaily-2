//
//  PostService.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 25/6/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import Firebase

final class PostService {
    
    // MARK: - Properties
    
    static let shared: PostService = PostService()
    
    private init() { }
    
    // MARK: - Firebase Database References
    let uid = Auth.auth().currentUser?.uid
  
    
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    
    let POST_DB_REF: DatabaseReference = Database.database().reference().child("posts")
    
    // MARK: - Firebase Storage Reference
    
    let PHOTO_STORAGE_REF: StorageReference = Storage.storage().reference().child("photos")

    // MARK: - Firebase Upload and Download Methods
    
    func getRecentPosts(start timestamp: Int? = nil, limit: UInt, completionHandler: @escaping ([Post]) -> Void) {
   
        print("Get recent posts...")
        var postQuery = POST_DB_REF.queryOrdered(byChild: "timestamp")
        if let latestPostTimestamp = timestamp, latestPostTimestamp > 0 {
            // If the timestamp is specified, we will get the posts with timestamp newer than the given value
            postQuery = postQuery.queryStarting(atValue: latestPostTimestamp + 1, childKey: Post.PostInfoKey.timestamp).queryLimited(toLast: limit)
        } else {
            // Otherwise, we will just get the most recent posts
            postQuery = postQuery.queryLimited(toLast: limit)
        }
        
        // Call Firebase API to retrieve the latest records
        postQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot)
            var newPosts: [Post] = []
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let postInfo = item.value as? [String: Any] ?? [:]
                
                if let post = Post(postId: item.key, postInfo: postInfo) {
                    newPosts.append(post)
                }
            }
            
            if newPosts.count > 0 {
                // Order in descending order (i.e. the latest post becomes the first post)
                newPosts.sort(by: { $0.timestamp > $1.timestamp })
            }
            
            completionHandler(newPosts)
            
        })
        
    }

    func getOldPosts(start timestamp: Int, limit: UInt, completionHandler: @escaping ([Post]) -> Void) {
        
        let postOrderedQuery = POST_DB_REF.queryOrdered(byChild: Post.PostInfoKey.timestamp)
        let postLimitedQuery = postOrderedQuery.queryEnding(atValue: timestamp - 1, childKey: Post.PostInfoKey.timestamp).queryLimited(toLast: limit)
        
        postLimitedQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            var newPosts: [Post] = []
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let postInfo = item.value as? [String: Any] ?? [:]
                
                if let post = Post(postId: item.key, postInfo: postInfo) {
                    newPosts.append(post)
                }
            }
            
            // Order in descending order (i.e. the latest post becomes the first post)
            newPosts.sort(by: { $0.timestamp > $1.timestamp })
            
            completionHandler(newPosts)
            
        })
        
    }
    

    func uploadImage(image: UIImage, completionHandler: @escaping () -> Void) {
        
        // Generate a unique ID for the post and prepare the post database reference
        let postDatabaseRef = POST_DB_REF.childByAutoId()
        
        // Use the unique key as the image name and prepare the storage reference
        let imageStorageRef = PHOTO_STORAGE_REF.child("\(postDatabaseRef.key).jpg")
        
        // Resize the image
        let scaledImage = image.scale(newWidth: 640.0)
        
        guard let imageData = UIImageJPEGRepresentation(scaledImage, 0.9) else {
            return
        }
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Prepare the upload task
        let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
        
        // Observe the upload status
        uploadTask.observe(.success) { (snapshot) in
            
            guard let displayName = Auth.auth().currentUser?.displayName else {
                return
            }
            
            // Add a reference in the database
            if let imageFileURL = snapshot.metadata?.downloadURL()?.absoluteString {
                let timestamp = Int(NSDate().timeIntervalSince1970 * 1000)
                
                let post: [String : Any] = [Post.PostInfoKey.imageFileURL : imageFileURL,
                                            Post.PostInfoKey.votes : Int(0),
                                            Post.PostInfoKey.user : displayName,
                                            Post.PostInfoKey.timestamp : timestamp
                ]
                
                postDatabaseRef.setValue(post)
            }
            
            completionHandler()
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Uploading... \(percentComplete)% complete")
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            
            if let error = snapshot.error {
                print(error.localizedDescription)
            }
        }
    }

}

