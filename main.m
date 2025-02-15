clc; clear; close all;

% Read video
videoReader = VideoReader('test.mp4'); 


foregroundDetector = vision.ForegroundDetector(...
    'NumGaussians', 5, ...
    'NumTrainingFrames', 150, ...
    'MinimumBackgroundRatio', 0.8); 

videoPlayer = vision.VideoPlayer('Position', [100, 100, 600, 400]);

while hasFrame(videoReader)
    frame = readFrame(videoReader);
    frame = imgaussfilt(frame, 1.5); 


    foregroundMask = step(foregroundDetector, frame);

    foregroundMask = imopen(foregroundMask, strel('disk', 5)); % Remove small noise
    foregroundMask = imclose(foregroundMask, strel('disk', 15)); % Fill holes
    foregroundMask = bwareaopen(foregroundMask, 1000); % Remove objects <1000 px

   
    stats = regionprops(foregroundMask, 'BoundingBox', 'Area', 'MajorAxisLength', 'MinorAxisLength');

    filteredBoxes = [];
    for i = 1:length(stats)
        aspectRatio = stats(i).MajorAxisLength / stats(i).MinorAxisLength;
        if stats(i).Area > 1200 && aspectRatio < 5  % Ensures only relevant objects
            filteredBoxes = [filteredBoxes; stats(i).BoundingBox];
        end
    end

    % Draw bounding boxes
    outputFrame = frame;
    for i = 1:size(filteredBoxes, 1)
        outputFrame = insertShape(outputFrame, 'Rectangle', filteredBoxes(i, :), 'Color', 'red', 'LineWidth', 3);
    end

 
    step(videoPlayer, outputFrame);
end

release(videoPlayer);