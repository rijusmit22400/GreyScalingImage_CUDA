#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>

#include "stb_image.h"
#include "stb_image_write.h"

using namespace std;

typedef struct Pixel{
    unsigned char r, g, b, a;
} Pixel;

void ConvertImageToGrayCPU(char* imageRGBA, int width, int height){
    for(int i=0;i<height;i++){
        for(int j=0;j<width;j++){
            Pixel* pixel = (Pixel*)&imageRGBA[(i*width)*4+4*j];
            float pixelValue = pixel->r*0.299f + pixel->g*0.587f + pixel->b*0.114f;
            unsigned char gray = (unsigned char)pixelValue;
            pixel->r = gray;
            pixel->g = gray;
            pixel->b = gray;
            pixel->a = 255;
        }
    }
} 

int main(){
    //check argument
    if(argc<2){
        cout << "Usage: 02_ImagetoGray <filename>" << "\n";
        return -1;
    }
    //open image
    int width, height, componentCount;
    unsigned char* imageData = stbi_load("sample_data_color.jpg", &width, &height, &componentCount, 0);
    if(!imageData){
        cout << "Failed to open \"" << arg[1] << "\"\n";
    }

    //validate image size
    if(width%32 || height%32){
        //image size must be multiple of 32
        cout << "Image size must be multiple of 32\n";
        return -1;
    }

    cout << "Image size: " << width << "x" << height << "\n";
    cout << "Loading....." << "\n";
    cout << "Processing the image....." << "\n";
    ConvertImageToGrayCPU((char*)imageData, width, height);
    cout << "DONE" << "\n"; 

    //buidling output
    string outputFilename = argv[1];
    outputFilename.substr(0,fileNameOut.find_last_of('.')) + "_gray.jpg";

    //Write image back
    stbi_write_jpg(outputFilename.c_str(), width, height, 1, imageData, 4*width);

    //close 
    stbi_image_free(imageData);
}