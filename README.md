# Video Object Detection

This MATLAB script performs object detection in a video using background subtraction and morphological processing. It's designed to identify and track moving objects within a video stream, filtering out noise and irrelevant detections.

## Description

The script reads a video file, applies background subtraction to isolate moving objects, and then uses morphological operations to refine the foreground mask.  It further filters detected objects based on size and aspect ratio to improve accuracy. Finally, it draws bounding boxes around the detected objects in the original video frame and displays the result.

Key features and techniques used:

* **Background Subtraction:** Uses the `vision.ForegroundDetector` object with optimized parameters (`NumGaussians`, `NumTrainingFrames`, `MinimumBackgroundRatio`) to effectively separate moving objects from the static background.  A balanced approach is used to avoid excessive background updates or overly sensitive foreground detection.
* **Gaussian Filtering:** Applies a Gaussian blur (`imgaussfilt`) to the video frames before background subtraction to smooth out noise while preserving the edges of moving objects. This helps to reduce false positives in the foreground mask.
* **Morphological Processing:** Employs morphological operations (`imopen`, `imclose`, `bwareaopen`) to clean up the foreground mask.  `imopen` removes small noise, `imclose` fills holes in the detected objects, and `bwareaopen` eliminates small, isolated regions.
* **Object Filtering:** Filters detected objects based on their area and aspect ratio. This helps to remove irrelevant detections and focus on objects of interest. The script uses thresholds for area and aspect ratio to achieve this filtering.
* **Bounding Box Drawing:** Draws red bounding boxes around the detected objects in the original video frame using `insertShape`.
* **Video Display:** Uses `vision.VideoPlayer` to display the processed video with bounding boxes.

## How to Run

1. **Prerequisites:**
   * MATLAB installed on your system with the Computer Vision Toolbox.
2. **Setup:**
   * Replace `'test.mp4'` in the script with the path to your video file.
3. **Execution:**
   * Open MATLAB and navigate to the directory containing the script.
   * Run the script by typing its name in the MATLAB command window and pressing Enter.

## Code Explanation

* **Video Reading:** The `VideoReader` object reads the input video frame by frame.
* **Foreground Detection:** The `vision.ForegroundDetector` object performs background subtraction.
* **Image Smoothing:** `imgaussfilt` applies a Gaussian blur.
* **Morphological Operations:** `imopen`, `imclose`, and `bwareaopen` refine the foreground mask.
* **Object Property Calculation:** `regionprops` calculates the bounding box, area, major axis length, and minor axis length of each detected region.
* **Object Filtering:** The script filters detections based on area and aspect ratio.
* **Bounding Box Insertion:** `insertShape` draws bounding boxes.
* **Video Display:** The `vision.VideoPlayer` displays the processed video.
* **Resource Release:** `release(videoPlayer)` releases the video player resources.

## Parameters

The following parameters can be adjusted in the script:

* **Video File:** Change `'test.mp4'` to your video file's path.
* **Foreground Detector Parameters:** Adjust `NumGaussians`, `NumTrainingFrames`, and `MinimumBackgroundRatio` in the `vision.ForegroundDetector` to fine-tune background subtraction.
* **Gaussian Blur:** Modify the standard deviation in `imgaussfilt`.
* **Morphological Operations:** Change the structuring element size in `strel('disk', size)` for `imopen` and `imclose`.
* **Area Threshold:** Adjust the area threshold in `bwareaopen` and the area check in the object filtering loop.
* **Aspect Ratio Threshold:** Modify the aspect ratio threshold in the object filtering loop.



