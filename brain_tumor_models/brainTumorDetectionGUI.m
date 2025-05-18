function brainTumorDetectionGUI
    % Create UI Figure
    fig = uifigure('Name', 'Brain Tumor Detection (ResNet-18)', ...
                   'Position', [100 100 600 400]);

    % UI Axes to display image
    ax = uiaxes(fig, 'Position', [30 100 250 250]);
    title(ax, 'Selected MRI Image');
    ax.XColor = 'none'; % Hide axes ticks
    ax.YColor = 'none';
    
    % Label for classification result
    lbl = uilabel(fig, ...
    'Position', [280 260 250 60], ...
    'FontSize', 16, ...
    'FontWeight', 'bold', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'center', ...
    'BackgroundColor', [0.95 0.95 0.95], ...
    'WordWrap', 'on', ...
    'Text', '');


    % Load Image Button
    btnLoad = uibutton(fig, 'push', ...
        'Text', 'Load Image', ...
        'Position', [310 180 150 40], ...
        'FontSize', 14, ...
        'ButtonPushedFcn', @(btn,event) loadImageCallback(ax, lbl));

    % Close Button
    uibutton(fig, 'push', ...
        'Text', 'Close', ...
        'Position', [310 120 150 40], ...
        'FontSize', 14, ...
        'ButtonPushedFcn', @(btn,event) close(fig));
end

function loadImageCallback(ax, lbl)
    % Load trained model
    persistent netTransfer;
    if isempty(netTransfer)
        load('brain_tumor_resnet18_model.mat', 'netTransfer');
    end

    % Ask user to select an image
    [file, path] = uigetfile({'*.jpg;*.png;*.jpeg'}, 'Select MRI Image');
    if isequal(file, 0)
        return;
    end
    imgPath = fullfile(path, file);
    img = imread(imgPath);

    % Convert grayscale to RGB if needed
    if ndims(img) == 2
        img = repmat(img, [1 1 3]);
    elseif size(img, 3) == 1
        img = cat(3, img, img, img);
    end

    % Resize image
    inputSize = netTransfer.Layers(1).InputSize;
    imgResized = imresize(img, inputSize(1:2));
    augImg = augmentedImageDatastore(inputSize(1:2), imgResized, ...
        'ColorPreprocessing', 'none');

    % Classify image
    predictedLabel = classify(netTransfer, augImg);

    % Display image and prediction
    imshow(img, 'Parent', ax);

    % Display descriptive prediction message with color
    if predictedLabel == "yes"
        lbl.Text = sprintf('Prediction: YES\n✅ Tumor detected in the MRI scan.');
        lbl.FontColor = [0.85 0 0]; % dark red
    else
        lbl.Text = sprintf('Prediction: NO\n🧠 No tumor detected. The scan appears normal.');
        lbl.FontColor = [0 0.5 0]; % dark green
    end
end
