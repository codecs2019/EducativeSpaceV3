using Amazon;
using Amazon.S3;
using Amazon.S3.Transfer;
using System;

namespace awsUpload
{
    public class AmazonUploader
    {
        public string sendMyFileToS3(System.IO.Stream localFilePath, string subDirectoryInBucket, string name)
        {

            //IAmazonS3 client = new AmazonS3Client(RegionEndpoint.USWest2);
            //TransferUtility utility = new TransferUtility(client);
            //TransferUtilityUploadRequest request = new TransferUtilityUploadRequest();
            //string bucketName = "bucket.sorozie"; //your s3 bucket name goes here  

            //Random rndNumbers = new Random();
            //int rndNumber = rndNumbers.Next(1000);

            //string s3FileName = rndNumber + name;

            //if (subDirectoryInBucket == "" || subDirectoryInBucket == null)
            //{
            //    request.BucketName = bucketName; //no subdirectory just bucket name  
            //}
            //else
            //{   // subdirectory and bucket name  
            //    request.BucketName = bucketName + @"/" + subDirectoryInBucket;
            //}
            //request.Key = s3FileName; //file name up in S3  
            //request.InputStream = localFilePath;
            //utility.Upload(request); //commensing the transfer  

            //string returnName = "https://s3-us-west-2.amazonaws.com/" + request.BucketName + "/" + request.Key;

            //return returnName; //indicate that the file was sent  
            return "";
        }
    }
}