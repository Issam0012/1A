#include "ocv_utils.hpp"

#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/opencv.hpp>
#include <iostream>

using namespace cv;
using namespace std;


void printHelp(const string& progName)
{
    cout << "Usage:\n\t " << progName << " <image_file> <K_num_of_clusters> [<image_ground_truth>]" << endl;
}

Mat centre(Mat image, int k, Mat labels)
{
    Mat matC = Mat::zeros(1,k,CV_32FC3);
    Mat Nb_elem = Mat::zeros(1,k,CV_32SC1);
    for (int i = 0; i<labels.rows; i++)
    {
    	int j = labels.at<int>(i);
    	matC.at<Vec3f>(j) += image.at<Vec3f>(i);
    	Nb_elem.at<int>(j) += 1;
    }
    for (int i = 0; i<k; i++)
    {
    	matC.at<Vec3f>(i) /= Nb_elem.at<int>(i);
    }
    return matC;
}

void kmoyennes(Mat image, int k, Mat labels, double eps, int maxIter){
    int n = image.rows;
    int m = n/k;
    Mat Center(1,k,CV_32FC3);
    // Chosing the centers of the k groups
    for (int j=0; j<k; j++) {
        Center.at<Vec3f>(j) = image.at<Vec3f>(j*m);
    }
    Mat newCenters(1,k,CV_32FC3);
    
    int p = 0;
    bool supEps = true;
    while (p<maxIter and supEps) {
    	Center.copyTo(newCenters);
        for (int i=0; i<image.rows; i++){
            Mat distance(1,k,CV_32FC1);
            for(int l=0; l<k; l++){
                distance.at<float>(l) = norm(image.at<Vec3f>(i), Center.at<Vec3f>(l), NORM_L2);
            }
            Point minLoc;
            minMaxLoc(distance, NULL, NULL, &minLoc, NULL);
            labels.at<int>(i) = minLoc.x;
        }
        newCenters = centre(image, k, labels);
        for(int i=0; i<Center.cols; i++)
        {
            supEps = (norm(newCenters.at<Vec3f>(i), Center.at<Vec3f>(i), NORM_L2)>eps) and supEps;
        }
        p += 1;
    }
    PRINT_MAT_INFO(labels);
}

Vec3f moyenne(Mat img, Vec3f x, int n, int m, int spatialRadius, int colorRadius) {
    Vec3f matM(0.0f, 0.0f, 0.0f);
    int nx = 0;
    int i = 1;
    int j = 1;
    while (i<spatialRadius) {
    	while (j<spatialRadius) {
    	    if ((n-i>=0) and (m-j>=0) and norm(img.at<Vec3f>(n-i,m-j), x, NORM_L2) < colorRadius) {
    	        matM += img.at<Vec3f>(i,j);
    	        nx += 1;
     	    }
     	    if ((n+i<img.rows) and (m+j<img.cols) and norm(img.at<Vec3f>(n-i,m-j), x, NORM_L2) < colorRadius) {
    	        matM += img.at<Vec3f>(i,j);
    	        nx += 1;
     	    }
    	    j += 1;
    	}
    	i += 1;
    }
    return matM/nx;
}

void moyenShift(Mat result, int spatialRadius, int colorRadius, double eps, int maxIter) {
    int n = 1;
    Mat copy;
    while (n <= maxIter) {
    	result.copyTo(copy);
        for (int i=0; i<result.rows; i++) {
            for (int j=0; j<result.cols; j++){
                Vec3f moyen = moyenne(copy, copy.at<Vec3f>(i,j), i, j, spatialRadius, colorRadius);
                result.at<Vec3f>(i,j) = moyen;
            }
        }
        n += 1;
    }
}

void comparaison(Mat labels, Mat ref, string name){
    int nb_pixel = labels.rows;
    Mat comp = Mat::zeros(4,1,CV_32FC1);
    for(int i = 0; i < ref.rows; i++ ){
        // 1 : True positive - 2 : True negative - 3 : False positive - 4 - False negative
        if (static_cast<int>(ref.at<uchar>(i)) == 0 && labels.at<int>(i) == 0){
            comp.at<float>(0) += 1.0f;
        }
        else if (static_cast<int>(ref.at<uchar>(i)) == 255 && labels.at<int>(i) == 1){
            comp.at<float>(1) += 1.0f;
        }
        else if (static_cast<int>(ref.at<uchar>(i)) == 255 && labels.at<int>(i) == 0){
            comp.at<float>(2) += 1.0f;
        }
        else {
            comp.at<float>(3) += 1.0f;
        }
    }
    // Calcul of segmentation quality
    Mat result = comp * 100 / nb_pixel;
    float TP = result.at<float>(0);
    float TN = result.at<float>(1);
    float FP = result.at<float>(2);
    float FN = result.at<float>(3);
    float P = TP / (TP + FP);
    float S = TP / (TP + FN);
    float DSC = 2 * TP / (2 * TP + FP + FN);
    cout << "//////////////////////////////////////////////" << endl;
    cout << " Pourcentage de vrais positifs pour "<< name <<" : " << TP << endl;
    cout << " Pourcentage de vrais négatifs pour "<< name <<" : " << TN << endl;
    cout << " Pourcentage de faux positifs pour "<< name <<" : " << FP << endl;
    cout << " Pourcentage de faux négatifs pour "<< name <<" : " << FN << endl;
    cout << " Précision pour "<< name <<" : " << P << endl;
    cout << " Sensibilité pour "<< name <<" : " << S << endl;
    cout << " Coéfficient de similarité  pour "<< name <<" : " << DSC << endl;
    cout << "//////////////////////////////////////////////" << endl;
}    

int main(int argc, char** argv)
{
    if (argc != 3 && argc != 4)
    {
        cout << " Incorrect number of arguments." << endl;
        printHelp(string(argv[0]));
        return EXIT_FAILURE;
    }

    const auto imageFilename = string(argv[1]);
    const string groundTruthFilename = (argc == 4) ? string(argv[3]) : string();
    const int k = stoi(argv[2]);

    // just for debugging
    {
        cout << " Program called with the following arguments:" << endl;
        cout << " \timage file: " << imageFilename << endl;
        cout << " \tk: " << k << endl;
        if(!groundTruthFilename.empty()) cout << " \tground truth segmentation: " << groundTruthFilename << endl;
    }

    // load the color image to process from file
    Mat m;
    // for debugging use the macro PRINT_MAT_INFO to print the info about the matrix, like size and type
    PRINT_MAT_INFO(m);

    // 1) in order to call kmeans we need to first convert the image into floats (CV_32F)
    // see the method Mat.convertTo()
    m = imread(imageFilename, cv::IMREAD_COLOR);
    PRINT_MAT_INFO(m);
    Mat float_m;
    m.convertTo(float_m, CV_32F);
    PRINT_MAT_INFO(float_m);

    // 2) kmeans asks for a mono-dimensional list of "points". Our "points" are the pixels of the image that can be seen as 3D points
    // where each coordinate is one of the color channel (e.g. R, G, B). But they are organized as a 2D table, we need
    // to re-arrange them into a single vector.
    // see the method Mat.reshape(), it is similar to matlab's reshape
    Mat vect_m;
    vect_m = float_m.reshape (3,m.rows * m.cols);
    PRINT_MAT_INFO(vect_m);

    // now we can call kmeans(...)
    Mat labels;
    Mat centers;
    kmeans(vect_m, k, labels, TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 10, 1.0),
    3, KMEANS_PP_CENTERS, centers);
    PRINT_MAT_INFO(labels);
    
    // show and save the image
    Mat img(vect_m.rows, 1 , CV_8UC1);
    Mat image;
    
    for(int i = 0; i < vect_m.rows; i++ )
    {
        int j = labels.at<int>(i);
        if (j==0) {
            img.at<uchar>(i) = 0;
        } else {
            img.at<uchar>(i) = 255;
        }
    }
    PRINT_MAT_INFO(img);
    image = img.reshape(1, m.rows);
    PRINT_MAT_INFO(image);
    imshow("k_means", image);
    imwrite( "../data/images/k_means.png", image);
    
    // we call our kmeans
    Mat labelsmoyennes= Mat::zeros(vect_m.rows, 1, CV_32SC1);
    kmoyennes(vect_m, k, labelsmoyennes, 1.0, 10);
    PRINT_MAT_INFO(labelsmoyennes);
    
    // show and save the image
    for(int i = 0; i < vect_m.rows; i++ )
    {
        int j = labelsmoyennes.at<int>(i);
        if (j==0) {
            img.at<uchar>(i) = 0;
        } else {
            img.at<uchar>(i) = 255;
        }
    }
    PRINT_MAT_INFO(img);
    image = img.reshape(1, m.rows);
    PRINT_MAT_INFO(image);
    imshow("k_moyenne", image);
    imwrite( "../data/images/k_moyennes.png", image);
    
    // comparaison to the reference
    if (argc == 4 && k == 2){
        Mat r = imread(groundTruthFilename, cv::IMREAD_GRAYSCALE);
        Mat ref = r.reshape(1, r.rows * r.cols);
        comparaison(labels, ref, "kmeans");
        comparaison(labelsmoyennes, ref, "notre kmeans");
    }
    
    // using MeanShift
    Mat result;
    int spatialRadius = 10;
    int colorRadius = 50;
    /* copying the image (we don't know what would happen inside pyrMeanShiftFiltering) */
    Mat copy;
    m.copyTo(copy);
    pyrMeanShiftFiltering(copy, result, spatialRadius, colorRadius);
	
    Mat labels_MS;
    Mat gray;
    cvtColor(result, gray, COLOR_BGR2GRAY);
    int numClasses = connectedComponents(gray, labels_MS);
    cout << "Nombre de classes par MeanShift opencv : " << numClasses << endl;
    // Show the result
    PRINT_MAT_INFO(result);
    imshow("Mean Shift", result);
    imwrite( "../data/images/mean-shift.png", image);
    
    // Using our MeanShift
    Mat r_MS;
    float_m.copyTo(r_MS);
    moyenShift(r_MS, spatialRadius, colorRadius, 0.1, 1);
    PRINT_MAT_INFO(r_MS);
    Mat our_result;
    result.convertTo(our_result, CV_8UC3);
    imshow("Moyen Shift", our_result);
    imwrite( "../data/images/moyen-shift.png", image);
    
    cvtColor(our_result, gray, COLOR_BGR2GRAY);
    numClasses = connectedComponents(gray, labels_MS);
    cout << "Nombre de classes par notre meanshift : " << numClasses << endl;
    
    waitKey(0);
    return EXIT_SUCCESS;
}
