//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos = [Photo]()
    var images = [UIImage]()
    
    // data to send
    var photoToSend: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath)->UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCell
        cell.backgroundColor = UIColor.blackColor()
        print(indexPath.row)
        print(photos[indexPath.row].url)
        loadImageForCell(photos[indexPath.row], imageView: cell.imageView)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 125, height: 125)
    }
    
    override func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCell
        photoToSend = photos[indexPath.row]
        self.performSegueWithIdentifier("ShowPhotoSegue", sender: self)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPhotoSegue" {
            if let destination = segue.destinationViewController as? PhotoViewController {
                var url: NSURL = NSURL(string: photoToSend!.url)!
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
                    (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    if error == nil {
                        //FIX ME
                        if error == nil {
                            destination.image = UIImage(data: data!)
                        }
                    }
                }
                task.resume()
                destination.poster = photoToSend!.username
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                destination.datePosted = dateFormatter.stringFromDate(photoToSend!.date)
                destination.likes = String(photoToSend!.likes)
            }
        }
    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        var url: NSURL = NSURL(string: photo.url)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                //FIX ME
                if error == nil {
                    let img = UIImage(data: data!)
                    imageView.image = img
                    print("success")
                }
            }
        }
        task.resume()
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

