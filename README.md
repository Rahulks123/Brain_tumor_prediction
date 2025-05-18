# Brain Tumor Prediction using MATLAB

This project uses image processing and deep learning in MATLAB to predict the presence of brain tumors from MRI images.

## Features
- Preprocessing of MRI images (grayscale, resizing, normalization)
- Feature extraction
- CNN/Transfer Learning-based classification
- Visualization of prediction masks

## How to Run

1. Place MRI images in the `data/` folder.
2. Run `main.m` to:
   - Load image
   - Preprocess
   - Predict tumor presence
   - Display output

## File Structure

- `main.m`: Main driver script
- `preprocess.m`: Image preprocessing
- `predictTumor.m`: Prediction using trained model
- `model/`: Contains `trainedModel.mat`
- `utils/`: Helper functions
- `results/`: Output masks and prediction visualizations

## Dependencies

- MATLAB R2020a or higher
- Image Processing Toolbox
- Deep Learning Toolbox

## Sample Output

![Tumor Mask](results/output_mask1.png)

## Dataset Used

(If using public data like BraTS, include link or mention source.)

## Author

Rahul K S
