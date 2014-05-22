FaceDetectionLab
================

Face Detection Lab

./facepp-matlab-sdk

getFaceRect.m: get face rect by face++ face dection matlab
sdk

demo_list_rect.m: store face rect info


./performance

1. downloading fddb image set

bash image_download.sh


fddb-all-image.list: a list of fddb test images

fddb-all-rect.list: a list of true face rect of fddb test
images


2. test face detection

cd ../facepp-matlab-sdk

run demo_list_rect.m


fddb-all-rect.facepp: face++ face dection result on fddb
test images


3. face detection performance

do location_check.m


