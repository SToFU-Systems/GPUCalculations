# GPUCalculation

How to install and setup CUDA Toolkit:

Step 1: Install CUDA Toolkit

1. Go to the NVIDIA CUDA website (https://developer.nvidia.com/cuda-toolkit) and download the latest version of CUDA Toolkit that is compatible with your GPU and operating system.
2. Run the CUDA Toolkit installer and follow the on-screen instructions to install CUDA Toolkit on your system.

Step 2: Install Visual Studio

1. If you haven't already, download and install Visual Studio from the official Visual Studio website (https://visualstudio.microsoft.com/).
2. Make sure to install the "Desktop development with C++" workload during the Visual Studio installation, as CUDA development requires C++ development tools.

Step 3: Configure Visual Studio for CUDA

1. Open Visual Studio and go to "Extensions" > "Manage Extensions".
2. Search for "CUDA" in the Extensions and Updates dialog box, and install the "NVIDIA CUDA Toolkit" extension.
3. Restart Visual Studio after the extension is installed.
4. After restarting, go to "CUDA" > "NVIDIA Nsight" > "Options" in the Visual Studio menu to open the "NVIDIA Nsight" options page.
5. In the "CUDA" tab, specify the path to the CUDA Toolkit installation folder that you installed in Step 1.
6. Click "OK" to save the settings.

Step 4: Create a CUDA Project

1. In Visual Studio, go to "File" > "New" > "Project" to create a new project.
2. Select "CUDA" under "Installed" > "Templates" > "Visual C++" > "NVIDIA" in the New Project dialog box.
3. Choose a CUDA project template, such as "CUDA Runtime Project" or "CUDA Driver Project", and click "Next".
4. Specify the project name, location, and other settings as desired, and click "Create" to create the CUDA project.

Step 5: Write and Run CUDA Code

1. In the CUDA project, you can write CUDA code in the ".cu" source files, which can be compiled and executed on the GPU.
2. To build and run the CUDA project, select the desired configuration (e.g., "Debug" or "Release") and click the "Local Windows Debugger" button in the Visual Studio toolbar.
3. Visual Studio will build and run the CUDA project, and you can view the output and debug CUDA code using the Visual Studio debugger.



