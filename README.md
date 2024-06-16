## Phononic Bandgap Predictor and Inverse Design App using Neural Networks

This repository contains a MATLAB application for predicting the bandgap ratio and performing inverse design of phononic crystals using a trained neural network. The tool leverages advanced machine learning techniques to optimize and tailor phononic crystal structures for specific bandgap properties. Key features include:

- **Bandgap Ratio Prediction**: Accurately predicts the bandgap ratio of phononic crystals using a trained neural network model.
- **Inverse Design**: Facilitates the design of phononic crystals with desired bandgap properties through an inverse design approach.
- **User-Friendly Interface**: MATLAB-based graphical interface for ease of use and accessibility.

---

### Features

1. **Prediction Tab**:
   - Adjust values of **e/a**, **r/a**, and **h/a** using sliders.
   - Instantly view the predicted bandgap ratio in a text box.
   - Automatically update the 3D view of the phononic crystal unit cell within the app.

2. **Inverse Design Tab**:
   - Set boundary ranges for **e/a**, **d/a**, and **h/a** using range sliders.
   - Input the desired bandgap ratio.
   - Click "Compute" to perform inverse design with minimal optimization using a trained neural network and particle swarm optimization.

### Getting Started

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/Amirhossein4096/PhononicBGRPredictDesign.git
    ```
2. **Install Dependencies**:
    - Ensure you have MATLAB installed.
    - Additional required toolboxes: Neural Network Toolbox, etc.

3. **Run the Application**:
    - Open MATLAB.
    - Navigate to the cloned repository directory.
    - Run the main script: `app_main.m`.

### Usage

- **Prediction Tab**:
  - Use the sliders to set the values of **e/a**, **r/a**, and **h/a**.
  - View the predicted bandgap ratio and 3D unit cell visualization.

- **Inverse Design Tab**:
  - Set boundary ranges for **e/a**, **d/a**, and **h/a**.
  - Input the desired bandgap ratio.
  - Click "Compute" to start the inverse design process.

### License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Amirhossein4096/PhononicBGPPredictDesign/blob/main/LICENSE) file for details.

### Contact

For any questions or suggestions, please contact amir.farajollahi@ut.ac.ir.

---

### Short Description

A MATLAB app for predicting bandgap ratios and inverse design of phononic crystals using a trained neural network.

### Title

**Phononic Bandgap Predictor and Inverse Design App using Neural Networks**

---

This description integrates your detailed explanation of the app's functionalities and user interface.
